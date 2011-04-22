From: Michael Witten <mfwitten@gmail.com>
Subject: Dates in Commits and other issues of style
         (Re: [RFC 2/5] Pretty Print: show tz when using DATE_LOCAL)
Date: Fri, 22 Apr 2011 14:08:42 +0000
Message-ID: <811b01a9-f10e-4444-9e5e-581adaf059c2-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <acbcf231-e0a6-440e-be42-5f25da3e318d-mfwitten@gmail.com>
            <7vtydrutbq.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 16:58:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDHo7-0003t1-PG
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 16:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905Ab1DVO6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 10:58:04 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39621 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab1DVO6A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2011 10:58:00 -0400
Received: by vxi39 with SMTP id 39so494059vxi.19
        for <git@vger.kernel.org>; Fri, 22 Apr 2011 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:to:from:cc:message-id:in-reply-to
         :references;
        bh=Av5ZALHgmK2uZxWn75M+/0GwsFVlQOpDy1DRCGX3+ZQ=;
        b=v0hGLVcLfVOROabSh6VzIpKNFKvUnNThim/Q81NXdRqx0bI86Skf47tJKhv++Q0qQr
         bJOlmje6JUT8ADbdDsrV01f5b3jyl0AjJq4pctOymRNX22COZp4ePcUonPeJ+O7kgS3r
         s0W9lYTCXIeRf5TNONHDW4DurKOs2D8qHdBeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:to:from:cc:message-id:in-reply-to:references;
        b=s4lXS/q3ddzL7eJGorcnWWH8VyCXuv8ciV8mm6gFz4MlROAHYJI63V9z+pGYwLtnnv
         05fH4Ot4z3INmQtFBa1P9wbA49J5uTjdmIFjorGejtJkeyLVSwhQMUOcqgjUyVV8e+VP
         nr87gvEAKjx2PUpfW/ijkm/wecoYP+Gbjxupw=
Received: by 10.52.187.42 with SMTP id fp10mr1794389vdc.270.1303484279406;
        Fri, 22 Apr 2011 07:57:59 -0700 (PDT)
Received: from gmail.com (pool-96-249-153-44.hrbgpa.fios.verizon.net [96.249.153.44])
        by mx.google.com with ESMTPS id b7sm259106vci.45.2011.04.22.07.57.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Apr 2011 07:57:58 -0700 (PDT)
In-Reply-To: <7vtydrutbq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171936>

On Thu, 21 Apr 2011 15:34:49 -0700, Junio C Hamano wrote:

> Michael Witten <mfwitten@gmail.com> writes:
>
>> Date: Fri, 11 Feb 2011 16:06:36 +0000
>> Currently, when the date mode is DATE_LOCAL, the
>> time zone is never pretty printed;...
>
> This is a tangent but it is funny to see the unnecessary Date: in-body
> header for a series about date display.  Please drop it.

No.

> Backdating the author timestamp will make it harder to find the related
> discussion from the list archive; the only plausible benefit I can see is
> that you may get "I thought of this much earlier than when I posted it to
> the public for the first time" pee-in-the-snow value out of doing so, but
> that is done at the cost to all others who need to inspect the history
> later.  Please don't.

What if I had submitted a pull request instead of inlined patches? Would
you be asking me to wipe the dates in my repository? Would you rewrite
the commits on your end?

Let's suppose that I like backdating specifically for the "pee-in-the-snow"
value; well, that's one of the prime motivators for doing unpaid, volunteer
work, and that's one of the reasons that distributed SCM tools like git are
so great: Unlike with, say, CVS, the actual author gets his or her information
officially recorded.

Perhaps you think we should dispense with identity information as well, given
that it's just a pee-in-the-snow value...

BUT WAIT!

Names and email addresses are important because of copyright issues; we need
to know whence came a contribution, after all.

Well... don't you think the particular date at which something was written
might be similarly valuable in a dispute over copyright?

Junio, you'll take my pee-in-the-snow and you'll like it.

> As a future reference, when you have a valid reason to override the
> header information your MUA would give your message with an in-body
> header, please leave a blank line after the in-body header to make the
> result easier to read, like this:
>
>         Date: Fri, 11 Feb 2011 16:06:36 +0000
>
>         Currently, when the date mode is DATE_LOCAL, the
>         time zone is never pretty printed;...

Fair enough.

> Also paragraphs that wrap lines at too narrow a margin is just as hard to
> read as paragraphs wrapped at a margin that is too wide.

I disagree that
it's too narrow,
and I feel like
you are now
nitpicking.

Sincerely,
Michael Witten
