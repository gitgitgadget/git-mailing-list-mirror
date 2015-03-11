From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] config.txt: stick to CamelCase naming convention
Date: Wed, 11 Mar 2015 19:17:13 +0700
Message-ID: <CACsJy8BCfLMuvCxqnbKqNMx=iytDyUXZ7_LjibWVS+KGc5JNEQ@mail.gmail.com>
References: <1425983981-634-1-git-send-email-pclouds@gmail.com> <54FEFB7E.4020209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 13:17:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVfa9-0000cz-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 13:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbbCKMRp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2015 08:17:45 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34504 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbbCKMRo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 08:17:44 -0400
Received: by iecsl2 with SMTP id sl2so26182572iec.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2015 05:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=D1nbYo1k5gJNY1SQIX7J7lrU/ncGlmbmpsgZaQ3wRpA=;
        b=ieHTaxEIFEhv9HYIs+F5UF7uhjhjmL6RsZ/PbMJ0+j+n987Wml8cqw3hy6DoJfFr4u
         P2zsDpEYQN9Kbx39+N2gZ1aLfXkQ34w29imb9TJ4Xfc+YaBFrdpVGeB5yTtM5WCTFMA8
         ZulCqaLrs+nwT6NVnswo9a4u51BaY+BUJqjcOzwsLzhh/IGT3WiVDO2ki4OQ4VXfkhUE
         /GLdr+xbRarG5d9XvnmcdvynxxQkmylRh3WxDGGPBMCzvRQvkNQjGdorO6Hw0VucV1K6
         WB5aj/6vO9hTnO5sIAsaD2KKtkjXXLIlE26fEBedz59yxTQrGGp3U/cY6EmL0aqiqJPE
         YPgA==
X-Received: by 10.50.79.229 with SMTP id m5mr90340853igx.23.1426076264101;
 Wed, 11 Mar 2015 05:17:44 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 11 Mar 2015 05:17:13 -0700 (PDT)
In-Reply-To: <54FEFB7E.4020209@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265321>

On Tue, Mar 10, 2015 at 9:11 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 10.03.15 11:39, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  .. while I'm looking at config.txt. I think this is the preferred n=
aming
>>  convention for config keys.
>
> I think the default is unix-like lowercase,
> this is what Git itself produces.
> (core.ignorecase, core.filemode, core.precomposeunicode)

You made me look back in history. Nobody actually mentioned about
filemode vs fileMode. And config.txt is a mixed bag. But I think
fileMode is better for reading.
--=20
Duy
