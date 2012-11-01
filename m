From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 1 Nov 2012 05:08:52 +0100
Message-ID: <CAMP44s3UHQE69O__EVK29uN_VPdZN=a0-Gczeh-Tbjp1ZAAbJw@mail.gmail.com>
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
	<CAMP44s0KFJW2F3gbO_Xd9QKrZ1OoxvUCvecU084-zH2UDqXKag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 01 05:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTm5i-00048u-MT
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 05:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879Ab2KAEIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 00:08:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55457 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab2KAEIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 00:08:52 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2190489obb.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9tu40LYhLsZcv0xGoQWIthGFSTgkMZlYF8fs6SPkUgI=;
        b=yu3Uv/BDTEa6vBOr7VIOgFJMF+tQ0c88kqGvgcZVoS+OLbycJGfgv2AEJsblRtmzHM
         da7HGOfSTujYbvGA66iX50Y6e4Wci7T0Lqt/rWRU0sx+/pQul4qWbBk/u6cL5grS5NrM
         BUx5eGGftUzX8goUweO9yZFAgyrL1TeIJU70sPzqMLawVL5XGEo3x2fykdLPB2TCEAch
         bseGc9uvlrI1EqhAHFYSEUwDylw76lQcUK/RikBqAAfD+1ZO0x+0oLAoesx8aTYfALbB
         LwyR1e4dR1q2iud5T6+wjhhpQzw05RAvx4Q15usRrBmJF4lNvObj/wk5YOxdXM/Elp31
         KAwA==
Received: by 10.60.1.164 with SMTP id 4mr16131132oen.96.1351742932090; Wed, 31
 Oct 2012 21:08:52 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 21:08:52 -0700 (PDT)
In-Reply-To: <CAMP44s0KFJW2F3gbO_Xd9QKrZ1OoxvUCvecU084-zH2UDqXKag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208864>

On Wed, Oct 31, 2012 at 8:47 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Oct 31, 2012 at 7:04 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>> How about performance?
>
>>      174.038642915 seconds time elapsed
>>
>> Compared to;
>
>>      340.976843750 seconds time elapsed
>>
>> Looks like there's something to improve in this area, but I wouldn't
>> be surprised if the reason for the better performance is that
>> something is not being done. I'll investigate.
>
> Turns out msysgit's remote-hg is not exporting the whole repository,
> that's why it's faster =/

It seems the reason is that it would only export to the point where
the branch is checked out. After updating the to the tip I noticed
there was a performance difference.

I investigated and found two reasons:

1) msysgit's version doesn't export files twice, I've now implemented the same
2) msysgit's version uses a very simple algorithm to find out file changes

This second point causes msysgit to miss some file changes. Using the
same algorithm I get the same performance, but the output is not
correct.

Here's after the latest updates:

 Performance counter stats for 'git clone hg::~/dev/hg-clean hg-clean-5':

     288338.286545 task-clock                #    1.299 CPUs utilized
            46,441 context-switches          #    0.161 K/sec
             6,098 CPU-migrations            #    0.021 K/sec
           509,600 page-faults               #    0.002 M/sec
   518,370,729,897 cycles                    #    1.798 GHz
   204,476,102,906 stalled-cycles-frontend   #   39.45% frontend cycles idle
   <not supported> stalled-cycles-backend
   726,005,034,102 instructions              #    1.40  insns per cycle
                                             #    0.28  stalled cycles per insn
   127,662,400,651 branches                  #  442.752 M/sec
     6,758,976,722 branch-misses             #    5.29% of all branches

     222.020233009 seconds time elapsed

Which is taking roughly 60% more time than msysgit, but the output is
actually correct.

Cheers.

-- 
Felipe Contreras
