From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC 2/3] Teach mv to move submodules using a gitfile
Date: Wed, 10 Apr 2013 18:59:54 +0200
Message-ID: <51659A8A.80605@web.de>
References: <515C88FE.9020203@web.de> <515C8987.2060804@web.de> <7vwqsbnvxz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 19:00:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPyNZ-00066x-UK
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 19:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132Ab3DJRAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 13:00:05 -0400
Received: from mout.web.de ([212.227.17.11]:53410 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965006Ab3DJRAE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 13:00:04 -0400
Received: from [192.168.178.41] ([79.193.81.26]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M5woT-1Unnox49zF-00xbGM; Wed, 10 Apr 2013 18:59:56
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vwqsbnvxz.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:V0QYLXcfu/LtI+pIItOJdNo/KOJ6TuF2/YIgD1UMGPN
 md2w65tY9GMxFRwfBIjk86Fm5U0JnArZtPCx98p7ebQmHfzBR2
 S3c5EcQgaMzzYOiWtnZhMjQ3XQNJHFy7PIa8u5HQec3ALJpzKA
 xIirHRjYUTYAzv3wb1lhy6V1EVdSKISCIx/gVQrx+SpXtSxvG4
 saQWEGBxF+np12Afi/NzA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220704>

Am 10.04.2013 01:08, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> diff --git a/submodule.c b/submodule.c
>> index 975bc87..eba9b42 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1001,3 +1001,67 @@ int merge_submodule(unsigned char result[20], const char *path,
>> ...
>> +	if (!fp)
>> +		die(_("Could not create git link %s"), gitfile_name.buf);
>> +	fprintf(fp, gitfile_content.buf);
> 
> Perhaps.
> 
> 	fprintf(fp, "%s", gitfile_content.buf);

Sure. Will fix in v2.
