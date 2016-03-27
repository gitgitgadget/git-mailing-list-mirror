From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v10 3/3] commit: add a commit.verbose config variable
Date: Sun, 27 Mar 2016 17:29:47 +0530
Message-ID: <CAFZEwPOhTC_LjUPHMN0PJsc94gvmHgmQL2Xe63oRGOiEMR2jjQ@mail.gmail.com>
References: <01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
	<1459079497-19121-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Mar 27 13:59:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak9MH-0006k7-T1
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 13:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbcC0L7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2016 07:59:49 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34819 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbcC0L7s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2016 07:59:48 -0400
Received: by mail-qk0-f193.google.com with SMTP id s5so9222887qkd.2
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=nT77kqU6xaIFEAZiT8QMqvv3x7njE9eq5LPWDSoyNBo=;
        b=iI3sqPhoMoEDttOTvce8bN76+US0SCPqHc4O3Jjtdqfy7kGrgNbwn1uezYDnpcb0Nh
         0ShnbRV/E2RT1GEihY1Gar3+pPdCkaN7C6wkMcW8Kq/8H4Sqqf9E6j2ZLgKBqfTBI1K4
         ZQ8Rfkau9lagH/4FMkb12h/u8JEQb9dn+K+VU30OzEC2CJniQyGm5ygMZeGcAk/v3Y3R
         o8kb11qMki5Gy3OmP3wURuRGhHPo6Xtgo9sersQMCGlg8Xpfa/DQT/euhsJY+0u/zPPA
         EV9GQjX+GQCrxNW218SbIvn+QQTjn4oUCXRn0L2ZvP0rBhGAHSKOIg1XQ2GLDj6nNhsw
         NHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=nT77kqU6xaIFEAZiT8QMqvv3x7njE9eq5LPWDSoyNBo=;
        b=a7vh/tzGThWtFJSMgjE7XpdzMPTF+NvcvhUMeA5TtQfhD05L0S7DUaSlBijkRmJWBa
         Iss7MVUycPmQPyXkmLAD/hPPfJE/3Nuv9SNT/QX0QRoLnVJjFymQ6y8sYlf0Y28TlsSR
         IrzPmx7gSQOkJJ7sSNJWWRRoCuAxckykCG2RtSl6vi79jV0kqP+M6BsjcFvOfbd7H3VR
         jQzMiVwJtL7dkHaHSzCpyxG06iMWZfliNxqUY/l+lgMvDdGaYW6PTxgORbnuzFinSEk8
         SegrvmviQwVsy6aRMZlWUHSAjTGizUFkEJfhPLmVGvaM/yOOkfnOESj+daBnvQjMsaBw
         XS8Q==
X-Gm-Message-State: AD7BkJIsAmjifM+Q94ILhzzNXi4chjPHVaxnf50EJ9VfG81WEQeGa+nVAca2DNu2IqU6m4hZaRZJCHQpU4Nz/Q==
X-Received: by 10.37.22.134 with SMTP id 128mr11492943ybw.7.1459079987290;
 Sun, 27 Mar 2016 04:59:47 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 27 Mar 2016 04:59:47 -0700 (PDT)
In-Reply-To: <1459079497-19121-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290003>

On Sun, Mar 27, 2016 at 5:21 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>> +test_expect_success 'commit.verbose true and --no-verbose' '
>> +     git -c commit.verbose=3Dtrue commit --amend --no-verbose &&
>> +     ! test -s out
>
> Please use the test_must_be_empty helper instead, because it has a
> nice, human-readable name and it complains with a helpful error
> message if something goes wrong, whereas 'test -s' just fails
> silently.

Thanks for pointing it out. I was unsure whether 'test -s' is a good
choice but used it since I did not know any other alternative.
