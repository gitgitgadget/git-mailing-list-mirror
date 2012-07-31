From: Vipul Amler <vipulnsward@gmail.com>
Subject: Re: Centralized git
Date: Tue, 31 Jul 2012 21:17:37 +0530
Message-ID: <CAKo1VjpiPEbPhHnbStduYefq1-ssJw3oPJv=bc9WxWTz0cC5Qw@mail.gmail.com>
References: <CALZVapnwGK=cKdHbZRsN0Ust7TAvFqa3AmYD7pzgoxdDxQh+uw@mail.gmail.com>
 <CALZVapkUu+hckMRAaNULSW5s9Q7P+78eVt1Q+ZrKFdPYb5uFVQ@mail.gmail.com>
 <CAH-tXsCGxpqP+C2CiCCB88exMT6H3w0id-otFWPRXrhhreRfWg@mail.gmail.com>
 <CALZVapniy5iNJbuOikZdgHv2qQ80nDSATw8udV=Tk2wNgxXY4w@mail.gmail.com>
 <CALZVapm-=HXdfb6LCrc60HgUJA0ptzb+E5r3Y1C2w_0eBo1onQ@mail.gmail.com> <CACBZZX7drB62ohpPOEs03SGe12sDmGzJDcGMboF50y9QLa6HbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Javier Domingo <javierdo1@gmail.com>,
	jaseem abid <jaseemabid@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 17:48:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwEg1-0005hz-5y
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 17:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275Ab2GaPsA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jul 2012 11:48:00 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42192 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab2GaPr6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2012 11:47:58 -0400
Received: by vcbfk26 with SMTP id fk26so5951857vcb.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vZCY1V7MLwqOYlSD8K3JqXamFB1v3R22R7XGlM07Ujc=;
        b=aHXNgowj4S68wtzMbZsMsu6ErCFa41QdziuuUxVucb+2P8bbSIj7xe8Pa3lU/PTufy
         0pbo04D7N/zqV3iTpwdx3KydbMZaHJ6w5yONoSQZG+EWJ6ZVcG6wgwodUlXM9CqL8ZEO
         PxVoal0n5d7NxHT2yrKI9YGHmVBrnFDuvU3+/PpnaCKE4IuP1soFFyN1U5HWW46V0yTT
         aNhtlFO5eFulEeiP1u+rKHc4fBtymkgkVmncXehyVnyCxUNWGVQs2ZEvQyXyPIUFVT6m
         9GMbONBk028uvI4L4K31DE6JgLS+0UhgMgm4lAUT+w+XD3W6qF7w/h9u9DZRSzk5asNT
         qnKA==
Received: by 10.52.98.8 with SMTP id ee8mr12652439vdb.58.1343749677831; Tue,
 31 Jul 2012 08:47:57 -0700 (PDT)
Received: by 10.58.58.142 with HTTP; Tue, 31 Jul 2012 08:47:37 -0700 (PDT)
In-Reply-To: <CACBZZX7drB62ohpPOEs03SGe12sDmGzJDcGMboF50y9QLa6HbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202657>

On Tue, Jul 31, 2012 at 8:22 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jul 31, 2012 at 3:08 PM, Javier Domingo <javierdo1@gmail.com>=
 wrote:
>> Network, in this case is cheaper. The thing is that If I commit
>> frecuently, will have plenty of GBs of history, that nearly for sure=
 I
>> won't use. I just need to have other people's work to merge. But I
>> want to think in Git style, I am pretty accustomed to that way of
>> doing things. That is why I sent this mail here.
>>
>> The idea is that if I modify 700MBs of video, with 20 commits I woul=
d
>> get in 21GB. And making a pull would be... just even more horrible
>> than anything. That is why I need to have also last checkouts filter=
=2E
>> Just download branch's HEADs.
>
> You're obviously aware of git-annex, is there any reason you can't
> just use that?
>
> That would give you what you want, you'd have a moving window of
> current files, and then you'd delete old files as they become
> un-needed.

If there is a lot of static content, you should try git-media[1]. Its
specifically aimed at what you are trying to achieve.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

[1] https://github.com/schacon/git-media/
