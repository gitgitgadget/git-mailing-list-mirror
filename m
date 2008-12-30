From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone - failing on cygwin with git:// but not with ssh://
Date: Tue, 30 Dec 2008 11:54:29 -0800
Message-ID: <7v1vvp30cq.fsf@gitster.siamese.dyndns.org>
References: <u7i5hy5ti.fsf@terrapin.northbound-train.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Joe Casadonte" <jcasadonte@northbound-train.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 20:56:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHkh3-0000ZD-M3
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 20:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbYL3Tyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 14:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbYL3Tyg
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 14:54:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYL3Tyg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 14:54:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B7FC41B65E;
	Tue, 30 Dec 2008 14:54:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9005E1B657; Tue,
 30 Dec 2008 14:54:31 -0500 (EST)
In-Reply-To: <u7i5hy5ti.fsf@terrapin.northbound-train.com> (Joe Casadonte's
 message of "Tue, 30 Dec 2008 11:40:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AE900992-D6AB-11DD-AB81-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104200>

"Joe Casadonte" <jcasadonte@northbound-train.com> writes:

> Looking for a little help, please.  Is this not a legitimate git issue?  Can
> anyone at least help me diagnose the issue?  Please?

I think "git on Cygwin" is as legitimate as git on anything else, but at
the same time my guess is that it is a combination of the fact that
everybody is busy with other things around the end of year , and that
probably there are not many "git on Cygwin" experts monitoring the list to
begin with.

Sorry, I do not work on Cygwin (nor Windows in general).  "fatal: read
error (Socket operation on non-socket)" sounds like it is coming from
pkt-line.c::safe_read() on the downloading side (i.e. git-clone).

Googling for that error message seems to indicate that it seems to a
rather common error message on wide variety of programs running on Cygwin.

C.f.

http://www.google.com/search?&q=%22Socket+operation+on+non-socket%22+site%3Acygwin.com
