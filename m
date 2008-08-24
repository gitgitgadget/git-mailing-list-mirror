From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (BUGFIX)] Respect core.autocrlf in combined diff
Date: Sat, 23 Aug 2008 17:56:56 -0700
Message-ID: <7vej4fw7qf.fsf@gitster.siamese.dyndns.org>
References: <200808232321.21795.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 02:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX3vt-0002qQ-SO
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 02:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbYHXA5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 20:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbYHXA5D
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 20:57:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbYHXA5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 20:57:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 38D23654A1;
	Sat, 23 Aug 2008 20:57:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7E4E6654A0; Sat, 23 Aug 2008 20:56:58 -0400 (EDT)
In-Reply-To: <200808232321.21795.angavrilov@gmail.com> (Alexander Gavrilov's
 message of "Sat, 23 Aug 2008 23:21:21 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F6BC306-7177-11DD-BEBE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93506>

Alexander Gavrilov <angavrilov@gmail.com> writes:

> 	Steps to reproduce:
>
> 		git init
> 		echo foo > file
> 		git add file
> 		git commit -m init
> 		git checkout -b a
> 		git checkout -b b
> 		echo bbb >> file
> 		git add file
> 		git commit -m bbb
> 		git checkout a
> 		echo aaa >> file
> 		git add file
> 		git commit -m aaa
> 		git config core.autocrlf true
> 		git merge b

Please add this kind of sequence to test scripts.

The patch from a cursory look appears correct.  Thanks.
