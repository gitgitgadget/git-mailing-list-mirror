From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG PATCH RFC] mailinfo: correctly handle multiline 'Subject:'
 header
Date: Thu, 08 Jan 2009 00:13:42 -0800
Message-ID: <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org>
References: <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
 <20090107224342.GB4946@roro3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Thu Jan 08 09:15:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKq2v-0006Ty-NB
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 09:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbZAHINt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 03:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbZAHINt
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 03:13:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZAHINs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 03:13:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CB511C0F5;
	Thu,  8 Jan 2009 03:13:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4B12D1C0DA; Thu, 
 8 Jan 2009 03:13:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 462BBBC8-DD5C-11DD-AE2D-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104898>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> On Fri, Dec 26, 2008 at 09:38:41PM +0300, Kirill Smelkov wrote:
>> When native language (RU) is in use, subject header usually contains several
>> parts, e.g.
> ...
> Junio, All,
>
> What about this patch?

What's most interesting is that I do not recall seeing this patch before.
Neither gmane (which is my back-up interface to the mailing list) nor my
mailbox seems to have a copy, and from the look of quoted parts (namely,
some Russian strings in the message), it is not implausible that my spam
filter (either on my receiving end or at the ISP) may have eaten it.

> It at least exposes bug in git-mailinfo wrt handling of multiline
> subjects, and in very details documents it and adds a test for it.
>
> ..., but may I try to attract git
> community attention one more time?

It is very appreciated.

> P.S. original post with patch:
>
> http://marc.info/?l=git&m=123031899307286&w=2

I have not had chance to look at your patch at marc yet, but from the look
of your problem description, I presume you could trigger this with any
utf-8 b-encoded loooooong subject line?
