From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: An interesting opinion on DVCS/git
Date: Fri, 06 Mar 2015 08:55:25 +0530
Message-ID: <54F91E25.4050008@gmail.com>
References: <54F2CD12.8050609@gmail.com> <CAGZ79kZ8CrjwVh3+OHSV1tv+fRXaDZ_diOO5E7QnSLZ=HTFSfg@mail.gmail.com> <CAJo=hJuKL3akaG3Xh8mH5iij_dAdMkBW8fQgvreOsUHV517gpw@mail.gmail.com> <alpine.DEB.2.02.1503031642340.26501@nftneq.ynat.uz> <54F723D3.1050805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	David Lang <david@lang.hm>, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 04:26:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTitO-0000a3-3L
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 04:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbbCFDZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 22:25:34 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36367 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbbCFDZd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 22:25:33 -0500
Received: by padfa1 with SMTP id fa1so41813231pad.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 19:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=P2joss9WqAVDYeJU9yGsB80tB0XSaGZ9aFyFervfhHU=;
        b=exZ5M6Ir7lijZDCE+pJL1rFIEtROgi8lA7xiPxmB53G8zho/MUnrfKUioJxOmwtEOO
         wtwIz0+W+/Selhv7NCyhn6F3g65ZvHUe8YhprxWGFksfPvoGiG/x5WtWdaIH8nsjwB5I
         MJRl3JNFJoyD45AK8pEiDkB70p6haHNyvIjnB59JcfH5WZdwCRk5MPboHakM+CeBpbp0
         jLJQmHyWN2WJYQIAGAHaEjB+uDB8i3FR4vL5bmVI/y/K1pk0jxacnowh4t/O3NLP8h/N
         avKySRvhFg+OYYOjWtEDZJyszRCCKOIwBcpNr3nWndscnXuyvOD2Q43CtvGS4OIspOTE
         ItzA==
X-Received: by 10.66.141.109 with SMTP id rn13mr21345450pab.113.1425612332815;
        Thu, 05 Mar 2015 19:25:32 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.216.213.80])
        by mx.google.com with ESMTPSA id di5sm8239002pbc.36.2015.03.05.19.25.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 19:25:31 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54F723D3.1050805@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264887>

On 03/04/2015 08:55 PM, Michael J Gruber wrote:

> Yes, that article has a few really weak lines of arguments, such as t=
he
> tutorial count.

Here's his definition of the main draw of a DVCS:

    No, the only thing that a DVCS gets you, by definition, is that
    everyone gets a copy of the full offline history of the entire
    repository to do with as you please.

That completely misses the point.  What about committing while offline,
'git blame' months-old changes offline, or local branches that don't
have to make it to the server until they have cooked for a while, and s=
o
on and on?

We're not all "facebooks" with multi-GB repos, and I certainly don't
care as much about disk space or bandwidth if losing those features is
the cost.

It gets worse:

    Let me tell you something. Of all the time I have ever used DVCSes,
    over the last twenty years if we count Smalltalk changesets and
    twelve or so if you don=E2=80=99t, I have wanted to have the full h=
istory
    while offline a grand total of maybe about six times.

I don't know how you can work on anything reasonably complex and
multi-developer without using some of those features six times in a
*week* (sometimes, six times in a *weekend*) let alone 12 years.
