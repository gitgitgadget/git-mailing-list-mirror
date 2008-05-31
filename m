From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test cases for git-am
Date: Sat, 31 May 2008 15:41:06 -0700
Message-ID: <7vod6mdrlp.fsf@gitster.siamese.dyndns.org>
References: <20080530140447.GB10514@leksak.fem-net>
 <7vy75rh25i.fsf@gitster.siamese.dyndns.org>
 <20080531024027.GB5907@leksak.fem-net>
 <7viqwuffdy.fsf@gitster.siamese.dyndns.org>
 <20080531220723.GD5907@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jun 01 00:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2ZmB-0003iV-4L
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 00:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbYEaWlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 18:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754543AbYEaWlX
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 18:41:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbYEaWlW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 18:41:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 718172C98;
	Sat, 31 May 2008 18:41:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E73BE2C97; Sat, 31 May 2008 18:41:16 -0400 (EDT)
In-Reply-To: <20080531220723.GD5907@leksak.fem-net> (Stephan Beyer's message
 of "Sun, 1 Jun 2008 00:07:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B10A4160-2F62-11DD-BBBF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83412>

Stephan Beyer <s-beyer@gmx.net> writes:

>> I tend to prefer "sed -n -e '3,$p'" for things like this for portability.
>
> I'm fine with that, but I sometimes wonder if systems that do not like
> "tail -n +3" really tend to like a "sed -n -e '3,$p'" :)

Why?  sed is as old as V7, which does not have "tail -n".
