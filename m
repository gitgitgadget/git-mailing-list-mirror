From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-commit.txt: Add missing long/short options
Date: Sat, 07 Jun 2008 14:05:24 -0700
Message-ID: <7vy75hlzvv.fsf@gitster.siamese.dyndns.org>
References: <1212798261-26785-1-git-send-email-s-beyer@gmx.net>
 <1212798261-26785-2-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jun 07 23:06:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K55cb-0005dJ-OZ
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 23:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbYFGVFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 17:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753672AbYFGVFw
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 17:05:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbYFGVFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 17:05:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 135B23522;
	Sat,  7 Jun 2008 17:05:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 751803520; Sat,  7 Jun 2008 17:05:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 753E0FB8-34D5-11DD-AAE3-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84228>

Stephan Beyer <s-beyer@gmx.net> writes:

> Furthmore, use
> 	short option::
> 	long option::
> instead of
> 	short option|long option::
> and split the "-c or -C <commit>" item into two separate items.

> ... 
> --q|--quiet::
> +-q::
> +--quiet::

While this may result in easier-to-read output, there are tons of other
pages that follow the current style.  I'd prefer:

 (1) a patch without "a|b\n" => "a::\nb::" for only git-commit.txt and

 (2) a patch that is "a|b\n" => "a::\nb::" for everybody but without any
     other changes.
