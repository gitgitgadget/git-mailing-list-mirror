From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Fri, 4 Nov 2011 16:45:10 -0700
Message-ID: <CA+55aFzCuEG7ZpSJ5BLFF3Rfe1Tqjr82fUwFGJTqMvzB=fbVcA@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org> <7vaa8bbni3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Ted Ts'o" <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Sat Nov 05 00:45:43 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RMTSB-0004d0-6V
	for glk-linux-kernel-3@lo.gmane.org; Sat, 05 Nov 2011 00:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588Ab1KDXpe (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 4 Nov 2011 19:45:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33246 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab1KDXpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2011 19:45:32 -0400
Received: by wwi36 with SMTP id 36so4230949wwi.1
        for <multiple recipients>; Fri, 04 Nov 2011 16:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=EW6QTClYRrVSPH1s+nE/2mzZpxVofQASvDQs2TuJFYs=;
        b=cX85A/zOAaHZDbEwyzOiv/fzBqTvJF+Ez3hB5TEP5GsSrzf/GcJHhr9QSE0QL8qwlC
         SDMd3F3jHeFEE9okWFS9L60VJHO2g0HXTeYqzpulp6WCJuM5+ufjPwPpZfzMdxF/tlt4
         VToCLb5D2CYp+GGB2WfIxQLaBz9l0mnwTC3qI=
Received: by 10.216.24.39 with SMTP id w39mr1468317wew.67.1320450331103; Fri,
 04 Nov 2011 16:45:31 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Fri, 4 Nov 2011 16:45:10 -0700 (PDT)
In-Reply-To: <7vaa8bbni3.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: -26sgQiDAIENEaQe6XvPA3jATh8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184810>

On Fri, Nov 4, 2011 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> If we really wanted to go this route, the attached single-liner should be
> sufficient for the DWIMmery.

My first reaction on reading the patch was "maybe it would be safer to
put the tags case after 'branches', so that the behavior in the
presense of ambiguity would stay the same as with the old case", but
thinking it through I think it's more important to be consistent with
the other lookups, which all prefer tags over branches when ambiguous.

So Ack, patch looks sane to me, and clearly makes it easier to fetch
tags individually.

                  Linus
