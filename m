From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] config: add core.sharedconfig
Date: Fri, 10 Dec 2010 08:53:23 +0700
Message-ID: <AANLkTikqW5Z2YQw7Yjy6jERpsdFXSO06W=MSi8iyKDkx@mail.gmail.com>
References: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
 <1291907388-9068-4-git-send-email-pclouds@gmail.com> <AANLkTinVw+H1OsdJVofiGMkpNAdOjS5n0-HZCGCg3f5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 02:54:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQsBM-00016l-Vk
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 02:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab0LJBxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 20:53:55 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62937 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab0LJBxy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 20:53:54 -0500
Received: by wyb28 with SMTP id 28so2939350wyb.19
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 17:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gwweH5M7RLCZvlmG2/ks9daPP1yb/DurdIrJen+3Gqs=;
        b=QWpaei9ALzVnoOsmW7llAVyfmt13UBeO2mL96pLgmAmaiSivgAHOWuQwl83GCDmF5d
         sPQ27PoK5MTRFnsu7mKAdHTXbajIEoeTvkAOCO47u7osaa7xvCj+gsFdRW2XY9Zn4Xx3
         g+iDwA3c3VWgInR8X/yEt6NAZND5Yqt5hU9g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wZsL1eqhRIqURbJRXlyzTkIKxeFGJk1dje2zAdx2W8S7EPJkbe7DuPSCELX1Dt5ZOM
         KFLEtRroZwY5HQz5R8nnJGkMQ6PVWiSF9nixuDHRbooVU3k2cb2M9KiXrIp0mxOqqPP5
         1K8g6N2bipfhbrgZV+UQO1uqSMTiwDo0SIA5w=
Received: by 10.216.162.70 with SMTP id x48mr1448956wek.4.1291946033183; Thu,
 09 Dec 2010 17:53:53 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Thu, 9 Dec 2010 17:53:23 -0800 (PST)
In-Reply-To: <AANLkTinVw+H1OsdJVofiGMkpNAdOjS5n0-HZCGCg3f5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163380>

2010/12/9 Thiago Farina <tfransosi@gmail.com>:
>> diff --git a/cache.h b/cache.h
>> index e83bc2d..e91ce35 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -559,6 +559,7 @@ extern int read_replace_refs;
>> =C2=A0extern int fsync_object_files;
>> =C2=A0extern int core_preload_index;
>> =C2=A0extern int core_apply_sparse_checkout;
>> +extern const char *core_shared_config;
>>
>
> Why you need to export this string? Isn't it used only in config.c?
>

git-prune should know about this but I haven't got that far.
--=20
Duy
