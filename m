From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v7 0/5] git help: group common commands by theme
Date: Fri, 15 May 2015 22:50:57 +0200
Message-ID: <55565C31.7060406@gmail.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>	<CAPig+cTAMrQEfK81WWn3honj5yL5RjYvt13P63kZoZ+pQ1f98g@mail.gmail.com> <xmqqiobtftxk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 15 22:51:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtMZW-0004zg-TJ
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 22:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934854AbbEOUvC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 16:51:02 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35224 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934627AbbEOUvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 16:51:00 -0400
Received: by wgkx2 with SMTP id x2so6283557wgk.2
        for <git@vger.kernel.org>; Fri, 15 May 2015 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VlTY7/pwpFQwTKpXDFeYHZLB/1ew03TZeUTpnXOyU2A=;
        b=jlpNKuklpPS3NOjo2ircsubu0gk6j2KxyKQ/Efu1go9awY9tI8g0rncApEES/a6Tlt
         vHcZYHGqXYXYQXwJrV4aDU95DqmI9Dk0qJlEApNf1U0LvB2xig3zBU/u4NOw8US5LPUD
         d2u7/KPrFUa0fyHO18u0XL9b0xvGbBH0N4P2IZDdtXqRR/lDg8KlyNHH8KbiEndKc55p
         +EQLZU8ANmybx4bO0DqisLUN1dDwZsVw6J7/8BCxQ0c//0Ldm/FsE9Ehl5whGFydYvVE
         +9SCN0nIMMsfF7KcJqSrTu/f/B6oVWBXWFIchvsfI2mfm2KJ80iGDCX6E2wBl1Fhz8c4
         rJKA==
X-Received: by 10.180.82.73 with SMTP id g9mr704051wiy.87.1431723059620;
        Fri, 15 May 2015 13:50:59 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id bh7sm4200174wjb.8.2015.05.15.13.50.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 13:50:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqiobtftxk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269183>



On 05/15/2015 10:48 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> rebased on 'next' (a2776d4)
>>
>> Something to keep in mind for the future: It's usually easier to
>> manage preparatory cleanup patches by incorporating them into the
>> series which needs/wants them rather than posting them as separate
>> topics. That way, your patch series isn't held hostage by those
>> separate topics.
>
> Not a big deal in this case, as I was very well aware that there was
> a preparatory change sent, so no harm done to me personally; I even
> asked S=C3=A9bastien to rebuild on top of that patch.
>
> For people who are helping to review the series but haven't paid
> attention to everything that was said on the list (read: almost all
> the people), it would have been better if it said "depends on
> bf990a2", instead of saying that it depends on the 'next' as a whole
> (which it doesn't).
>
> Thanks.
>

Lesson learnt. I'll mention the commit itself instead of the branch
for the next series. Thanks :)
