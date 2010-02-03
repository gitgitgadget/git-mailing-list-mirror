From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gui translation updates needed
Date: Wed, 03 Feb 2010 11:42:00 -0800
Message-ID: <7vwryuhzsn.fsf@alter.siamese.dyndns.org>
References: <20100201151647.GB8916@spearce.org>
 <7vy6jbunu8.fsf@alter.siamese.dyndns.org>
 <201002031111.29557.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:42:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncl7I-0008DY-RX
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757644Ab0BCTmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 14:42:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757656Ab0BCTmK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 14:42:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6013696BCC;
	Wed,  3 Feb 2010 14:42:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rYJV0+vGX5H4EeshmnEP+SinonI=; b=o8nQmd
	xyYCrf8PyJrJgBm/byHPkwgi+Ch67smNnoa9TSzWNLpRFPqA3WVrWlJtmGMAWcO/
	VX9h1T0BZ7/mlC6BUalz2MpQlznVpH1R+yn0g52TqRImQb9+klduF3R9sjWarJOH
	uN0BrQttwH5vOiWaMJFVrl1Bnq23iJtvg6CQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IjmF97fQ0Uoy82+gdEfp8sfALJXFJpCO
	BssBFouM0bDFf9czNsIOFzFYfTZN8TO+Srvdts/BwhkNVw3L+tLNnnH/rt6TkLhd
	ZHIclW16e1TW8tgpHNJT1HRNloh2/dicmu8rcE8GFbzcQThLFsnsqGOIRY9vBHME
	oDAZZMK84lo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2767496BCA;
	Wed,  3 Feb 2010 14:42:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44A0F96BC3; Wed,  3 Feb
 2010 14:42:02 -0500 (EST)
In-Reply-To: <201002031111.29557.barra_cuda@katamail.com> (Michele Ballabio's
 message of "Wed\, 3 Feb 2010 11\:11\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3596B842-10FC-11DF-8822-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138870>

Michele Ballabio <barra_cuda@katamail.com> writes:

> On Wednesday 03 February 2010, Junio C Hamano wrote:
>>  - It is curious that de.po is ...
> IIRC, the timetable was:
> 	* Christian Stimming submits a new de.po
> 	* Shawn Pearce updates git-gui.pot and asks for help
> 	* other languages are submitted
>
> So de.po has a different date, but doesn't miss anything since
> no major change has occurred in git-gui.git in the meantime.

That explains it; thanks.

>>  - I am seeing "1 untranslated", even though it.po is based on the latest
>>    git-gui.pot.  It translates "buckets" to an empty string; somebody who
>>    care about Italian may need to double check.
>
> An empty string means "there's no translation, use the default" -- in
> this case: "buckets". I left it this way because I couldn't come up
> with a decent translation, and I wanted to keep a reminder.

I understand your intention, and I think I phrased it wrongly, as if I was
saying that you were actively telling git-gui to say nothing when it wants
to say "buckets" in English.  You did the right thing by leaving it
"empty", so that other people (like me) can notice the "untranslated"
warning during build.  That is why I said "somebody ... may need to double
check".

> In this case, git-gui is counting objects during a clone; would it be OK
> to consider "buckets" as synonim of "objects" or "items" or something
> else?  Then I would translate accordingly.

A cursory read of the codepath with that message tells me that Shawn is
calling one [0-9a-f][0-9a-f] directory under .git/objects/ a "bucket" and
counting the number of them while copying them to implement "git clone"
inside git-gui (why?---that is a separate issue).

Calling it "objects" would be technically incorrect; using a countable
noun that does not have a particular meaning (e.g. "items") would be a
good solution for this, I think.
