From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Suggestion: make git checkout safer
Date: Fri, 5 Jun 2015 14:37:21 -0400
Message-ID: <CAPig+cTuajnDGdVs18zLd_ngcA=3TZnCn9iNutB9J0FVU1HqrA@mail.gmail.com>
References: <loom.20150603T104534-909@post.gmane.org>
	<20150603090654.GD32000@peff.net>
	<loom.20150603T110826-777@post.gmane.org>
	<20150603093514.GF32000@peff.net>
	<loom.20150603T114527-151@post.gmane.org>
	<20150603194756.GB29730@vps892.directvps.nl>
	<loom.20150604T124827-124@post.gmane.org>
	<5570B1AC.2060108@web.de>
	<loom.20150605T113129-339@post.gmane.org>
	<CAPig+cTK4pXgweoGZc1-nj41aYo0bEK6Zrsc9291xQr5v8=p8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 20:37:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0wUi-0006ka-Bz
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 20:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbbFEShX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 14:37:23 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36214 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721AbbFEShV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 14:37:21 -0400
Received: by ieclw1 with SMTP id lw1so63859939iec.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=xeYepFGsv2ID4VOp/vmUienUSmSWYhL3zqB3YTuomuY=;
        b=hznwZIyVRxqgKhaFZZkyib4MDDzBBlyaOpOyC1cCsutXR5o7fMyu/Uc89xwTt5kQyL
         iwHZxfLHzCBrDXn4gl/+tvt3LmtOXV5vyxfkNHBxPQoQyJwLiiDJA4IV4jljBNa6l1kp
         YadCHcS950S4vgVyPggtIkQK2AUlUjcxTZaKvvl2S7WYn9E6B+M7KNAnPlREN2y0ccpe
         WdKYKzvIEut1kTpO5iIShA5PcsFmt3Uimszl3EeV13Olqf26VvfjWqOF/cDjNrlTKdmW
         n56idK1wnoT52evm+W+C7yUz4IRlO3wVXGWX5SgM0eKb5lhaO2ed+cBEpi6G/vEjApm1
         oi6g==
X-Received: by 10.50.66.174 with SMTP id g14mr17512976igt.7.1433529441314;
 Fri, 05 Jun 2015 11:37:21 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 5 Jun 2015 11:37:21 -0700 (PDT)
In-Reply-To: <CAPig+cTK4pXgweoGZc1-nj41aYo0bEK6Zrsc9291xQr5v8=p8g@mail.gmail.com>
X-Google-Sender-Auth: epoNpmNjeCHj7dPRmFH7Ry-rp6Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270870>

On Fri, Jun 5, 2015 at 1:44 PM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Fri, Jun 5, 2015 at 5:32 AM, Ed Avis <eda@waniasset.com> wrote:
>> Torsten B=C3=B6gershausen <tboegi <at> web.de> writes:
>>>Do you think you can write a patch to improve the documentation ?
>>
>> Here is my attempt, but it is only a starting point.
>>
>> diff --git a/Documentation/git-checkout.txt b/Documentation/git-chec=
kout.txt
>> index d263a56..ee25354 100644
>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>> @@ -3,7 +3,7 @@ git-checkout(1)
>>
>>  NAME
>>  ----
>> -git-checkout - Checkout a branch or paths to the working tree
>> +git-checkout - Overwrite working tree files with a given branch
>
> I agree with Duy's suggestion of "switch branches or reset working

I meant, but forgot to say, that I'd probably replace "reset" with
"restore" in Duy's suggestion.

> tree files" since it explains the high-level purpose of the command,
> whereas your wording gives details of the low-level operation without
> conveying the high-level purpose.
