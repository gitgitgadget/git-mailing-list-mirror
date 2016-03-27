From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v10 3/3] commit: add a commit.verbose config variable
Date: Sun, 27 Mar 2016 17:41:48 +0530
Message-ID: <CAFZEwPPwz5Woz-TXiDQz43VChueDGqzOPB0VQQiefH7igWNiQQ@mail.gmail.com>
References: <01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
	<1459079497-19121-1-git-send-email-szeder@ira.uka.de>
	<CAFZEwPOhTC_LjUPHMN0PJsc94gvmHgmQL2Xe63oRGOiEMR2jjQ@mail.gmail.com>
	<20160327140733.Horde.hQiEcpos_hNprvjPS1zIbi2@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Mar 27 14:11:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ak9Xu-00032P-J5
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 14:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbcC0MLu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2016 08:11:50 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35662 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbcC0MLt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2016 08:11:49 -0400
Received: by mail-qk0-f194.google.com with SMTP id s5so9245719qkd.2
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=lWbbfz/cX0gqnBNplGhsJWs7VEZ+ZiEr6MR27IrOFQg=;
        b=cq8NUETYrx/Wtd/I66S6hKujms9b8uSx5fW9JLZvUn/mFPsUrE6YWxyo+jqrtsC4fW
         wUEyiZMxJP8v/DS32kNRJPsBkc0ux5lKifG/ujTv3P2/R2c1cS6TUQwxuXu3eHP0nktG
         tUndazI1R9+ueuRLp/54/u3hFbkJrwC/UkXH30scmtcWJtLjokgk8xyjG7fv8NjyokYk
         c+gqPaCkFAOI8RuK/AcWiS1NTLC0yeA8z5cpWvEGpCbEhQeP0N8PlYFUnU5uAkUxu6eC
         2aDTrt4xCTVqGctUfrA5/S0m9mxbxGrvz1tO2TH3w0HLmN+jPfogE8RXsSpWpMcbi0/V
         M4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=lWbbfz/cX0gqnBNplGhsJWs7VEZ+ZiEr6MR27IrOFQg=;
        b=eMPdEU1ONoELMhjICK2THCyafqXgQM8y3QJeK+2KGfE1bjDw5iGJjowioJOpQlqFI+
         4wuv32yJ7pvHUCfA/27jSc1PO1IVrSVwf/h8O1c5EcdrOjWMC7EiXs4J9rsrNpI2mTr8
         mNr+vvgviYKvgQ/55CmPUPgxZ5dmItg97iDPUXq6TdqVr2NmtQE73KwNqYS6CYymB92a
         7KdxMWgZq8xWriDTSfsXo/3OgWX/9dNoiamqVxI9Xs4hCzzBIr6oSF74woZq1qs8OTIr
         b/8Fje2ej+GXAQM1NI5q4dkaOpdtvbe8ozfqc1UTtJTwZeyynpSEYLYQdR+YA1M2F7MO
         U5og==
X-Gm-Message-State: AD7BkJK5gPbJfJEYL4DzNraVOyvcaiaveAmOHVZObottJPCl3Uo/c1z7KtuyXOfVn8AkEgpy10tjtzYAi+KSNA==
X-Received: by 10.37.100.196 with SMTP id y187mr11440801ybb.80.1459080708798;
 Sun, 27 Mar 2016 05:11:48 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 27 Mar 2016 05:11:48 -0700 (PDT)
In-Reply-To: <20160327140733.Horde.hQiEcpos_hNprvjPS1zIbi2@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290005>

On Sun, Mar 27, 2016 at 5:37 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> t/test-lib-functions.sh contains all our test helpers functions, that=
's
> where you can look for a suitable helper, should it be necessary.
Thanks. I will surely look into it.
