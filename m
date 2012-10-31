From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 20:47:43 +0100
Message-ID: <CAMP44s0KFJW2F3gbO_Xd9QKrZ1OoxvUCvecU084-zH2UDqXKag@mail.gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
	<20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
	<509149D9.3070606@drmicha.warpmail.net>
	<CAMP44s2oKMog5GygrAag8SOdwhQJr4gCZxZAwWUo-ERDzni0ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 20:48:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTeGc-0003YB-5o
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 20:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760313Ab2JaTrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 15:47:45 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50472 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760196Ab2JaTro (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 15:47:44 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1843705oag.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f5vIvOdOnoAtwgsI4MwQ6kT7dhArnNmL9uCa+k0jXJs=;
        b=aUebitdMJaEB6FNvta2bxExksm1L4apx8asof8wcrskUpMNr/V8uJc1WVoZUxzBz5o
         Qql463iltHf0xI7K30khrJK9c+xidB/s9LWDP+1GxHQU0a6DcpiNmezS7zbg+eIfwENA
         /6Vm4fAM+tMrXsLXUiRBR5ttyxQU8S2Eyq/40Dj0UlJgE0r5ex7SE7ovewcBdBVzbkY+
         F/UvX40lAQ3USLucEA3r5yuhINLy4GPtHtLXIi7fD1YOybGzkp982MwTgh0arCxKcxFJ
         qx0pxQW8Dx0im4rThvYufgi9HXncYQn+6y54pc5LJ+JA6TYX9rCSIvB0SZNOilKJXNsx
         WBKg==
Received: by 10.60.31.241 with SMTP id d17mr32376955oei.107.1351712863986;
 Wed, 31 Oct 2012 12:47:43 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 12:47:43 -0700 (PDT)
In-Reply-To: <CAMP44s2oKMog5GygrAag8SOdwhQJr4gCZxZAwWUo-ERDzni0ag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208851>

On Wed, Oct 31, 2012 at 7:04 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> How about performance?

>      174.038642915 seconds time elapsed
>
> Compared to;

>      340.976843750 seconds time elapsed
>
> Looks like there's something to improve in this area, but I wouldn't
> be surprised if the reason for the better performance is that
> something is not being done. I'll investigate.

Turns out msysgit's remote-hg is not exporting the whole repository,
that's why it's faster =/

Let's try with a smaller repo:

 Performance counter stats for 'git clone hg::~/dev/love love-2':

      16130.554299 task-clock                #    1.311 CPUs utilized
             5,625 context-switches          #    0.349 K/sec
               241 CPU-migrations            #    0.015 K/sec
            84,042 page-faults               #    0.005 M/sec
    28,985,094,782 cycles                    #    1.797 GHz
    12,235,424,421 stalled-cycles-frontend   #   42.21% frontend cycles idle
   <not supported> stalled-cycles-backend
    38,762,850,763 instructions              #    1.34  insns per cycle
                                             #    0.32  stalled cycles per insn
     6,727,815,043 branches                  #  417.085 M/sec
       354,887,290 branch-misses             #    5.27% of all branches

      12.300536156 seconds time elapsed

And mine:

 Performance counter stats for 'git clone hg::~/dev/love love-1':

      16116.643370 task-clock                #    1.295 CPUs utilized
             6,270 context-switches          #    0.389 K/sec
               183 CPU-migrations            #    0.011 K/sec
            57,767 page-faults               #    0.004 M/sec
    28,962,073,772 cycles                    #    1.797 GHz
    11,844,122,698 stalled-cycles-frontend   #   40.90% frontend cycles idle
   <not supported> stalled-cycles-backend
    39,679,556,857 instructions              #    1.37  insns per cycle
                                             #    0.30  stalled cycles per insn
     6,609,397,307 branches                  #  410.098 M/sec
       371,092,848 branch-misses             #    5.61% of all branches

      12.446643210 seconds time elapsed

That's more like it. msysgit's is still missing a few commits, but
nothing mayor.

Cheers.

--
Felipe Contreras
