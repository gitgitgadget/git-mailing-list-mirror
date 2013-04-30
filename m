From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 13:18:16 -0500
Message-ID: <CAMP44s22Gz=fjregUE37r-V7R+eC_vLhdkefTybEpPDm680NBQ@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<CAMP44s0PcB7nu_67p=hfMy4Kb2iYTSp5ZT6y2Gn24OAtDzR_sw@mail.gmail.com>
	<20130430175635.GA1972@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:18:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXF8A-0006cc-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760862Ab3D3SST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:18:19 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:37855 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760751Ab3D3SSR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:18:17 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so707738lab.29
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=U71aPRjujkYDOjYD+H3DTBQ4CCs0GbB30FFtnMlSqPU=;
        b=Wn9Mvf6H7Sx7UINwJeb5N64g9TYYnl08Z//fEwwmfmvDpj2PQNDBiWAJaLTGIFjT3F
         8COz0jk9WyAZt4SzzdB0J86gwBvRt6MwL019OvnCRBm2zbBwiSgV8Rumvdp1FBG1x/5G
         rmqcKYvgQCVlvILz2sjuUQvB1H5YYRJHyHjZLtpgBnn4ciEiZD252f45pMtDyQpgtAHC
         dBSR/ls8zNXRwyErwZcKphtA11aJ10XQga26EOIDekJAVYCVNLZItISN3bg/Lrst5Vrl
         nPUnk6ck1Ty2A+fDwPsWOowC6WmcEd4hcdpdKSKk909vJU6nohWvHFaPpSH2temLgusT
         RZBg==
X-Received: by 10.112.139.226 with SMTP id rb2mr65245lbb.12.1367345896313;
 Tue, 30 Apr 2013 11:18:16 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 11:18:16 -0700 (PDT)
In-Reply-To: <20130430175635.GA1972@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222980>

On Tue, Apr 30, 2013 at 12:56 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 30, 2013 at 12:47:57PM -0500, Felipe Contreras wrote:
>
>> > We should make sure that the code rejects "git update-ref @ foo"
>> > because that is "git update-ref @{0} ref", by the way.  I didn't
>> > check with Felipe's patch.
>>
>> Hmm, with or without my patch 'git update @ foo' does nothing, same
>> with 'git update blah foo'. No error, no non-zero exit code, just
>> doesn't do anything.
>
> Are you sure?
>
>   $ git version
>   git version 1.8.2
>
>   $ git update-ref @ foo
>   fatal: foo: not a valid SHA1
>
>   $ git update-ref @ origin/master
>   $ echo $?
>   0
>   $ cat .git/@
>   89740333e8d398f1da701e9023675321bbb9a85b

Right. I don't know why I expected it to show in 'git show-ref'.

-- 
Felipe Contreras
