From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 0/5] git help: group common commands by theme
Date: Fri, 15 May 2015 16:37:22 +0200
Message-ID: <555604A2.6080204@gmail.com>
References: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com> <xmqqa8x6khlr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 16:37:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtGk9-0002di-Iu
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 16:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbbEOOhh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 10:37:37 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33363 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbbEOOhg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 10:37:36 -0400
Received: by wicmx19 with SMTP id mx19so40338711wic.0
        for <git@vger.kernel.org>; Fri, 15 May 2015 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SI1x/WsZqkh4khlEQtbwaIGk39apBwESufk/pdDPLBs=;
        b=HISbkjsYO2S6xBsT5UgS16xcIe3ut1dPyhC2oAcN2vJMxAkhi3kBIdUjibDIABwe+A
         lYliQP6RcsJqffx3yFCZG3LxKc5U5h/uxSEc1AnfgVsIueFaQD+fOdiJsEAMKaCAYit1
         DtioY9ltX5n0zJr/DdjwlK7BwFsI873hBTzzQb8QKmrXQnaMo4oP9UQW9M6o59vDCuS/
         8dXVcHy97yXU8H2IiFNjtdZpG26AZVohXoNbblvYjGC6i/zrRV8xsbsKvGW4wMpBerzD
         hZ8GbWM8BoMxesQUyqBiPKzZ03SxblMuymQ1vgW+V4B8hyaCuOdNya0s1hR5ux4Ds5ci
         c9Ew==
X-Received: by 10.180.103.130 with SMTP id fw2mr34605383wib.87.1431700655069;
        Fri, 15 May 2015 07:37:35 -0700 (PDT)
Received: from [192.168.0.15] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id v3sm2122379wiz.14.2015.05.15.07.37.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 07:37:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqa8x6khlr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269146>

On 05/14/2015 10:51 PM, Junio C Hamano wrote:
> S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:
>
>> This v6 is very similar in content to the v5 [1], except minor forma=
tting
>> adjustments in 'git help' output and recommendations from Eric.
>>
>> The major change is in the patch series itself. Commits have been
>> reordered and adjusted so that each 'apply' doesn't break the build,=
 and
>> preserve bisectability.
>
> Hmph, did you decide to abandon the "whitespace fix" patch?  This
> does not seem to be based on that one, and it would be crazy to
> have these pa beltches *and* the other one as independent two topics
> and expect them to be merged cleanly later.
>

My mistake : I believed the preparatory patch and the new series had to=
 be
independent, and thus had to be merged in your own tree. I will correct=
 this.

Thanks
