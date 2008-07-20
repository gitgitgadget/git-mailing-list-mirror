From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable git rev-list to parse --quiet
Date: Sun, 20 Jul 2008 00:56:28 -0700
Message-ID: <7vwsjhc7kj.fsf@gitster.siamese.dyndns.org>
References: <20080718040459.13073.76896.stgit@marcab.local.tull.net>
 <7v8wvzeojm.fsf@gitster.siamese.dyndns.org>
 <20080718092001.GD16102@mail.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nick Andrew <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Sun Jul 20 09:57:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKTnT-00060o-N2
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 09:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbYGTH4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 03:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbYGTH4f
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 03:56:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbYGTH4e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 03:56:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C662A2E925;
	Sun, 20 Jul 2008 03:56:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 48B802E924; Sun, 20 Jul 2008 03:56:31 -0400 (EDT)
In-Reply-To: <20080718092001.GD16102@mail.local.tull.net> (Nick Andrew's
 message of "Fri, 18 Jul 2008 19:20:01 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5EFCB060-5631-11DD-A802-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89172>

Nick Andrew <nick@nick-andrew.net> writes:

> ...Without
> a working "--quiet" nor exit code I can pipe the output to "wc -l"
> but is there a more efficient/reliable way to implement the requirement?

Did you read the whole thread before asking the above question?

IOW, does this answer the above question?

    http://mid.gmane.org/7vy73zd8ok.fsf@gitster.siamese.dyndns.org
