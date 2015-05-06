From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: [PATCH] fixed translation in config file to enhance user output
 message from the porcelain command(git config). This fixes the error and die
 function by wrapping it in the _(...) function. This also avoid the code from breaking
Date: Wed, 6 May 2015 20:33:35 +0100
Message-ID: <CAKB+oNt7WFqqXLwjxyoEVj2_eP2wworpb-_uXXkEvVgQgR8uTg@mail.gmail.com>
References: <554a6462.c2bbb40a.1e2a.0255@mx.google.com>
	<CAGZ79kaVhYi8amQkRMsHEWZCyMOSWr7NwRaz5TG+pyz5O79k6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 06 21:33:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq54f-000658-MP
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 21:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbbEFTdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 15:33:36 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35426 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbbEFTdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 15:33:36 -0400
Received: by qkhg7 with SMTP id g7so13368631qkh.2
        for <git@vger.kernel.org>; Wed, 06 May 2015 12:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jmdXXenDO/F5bcQDFetz7mKibU3+H0z1u9EI2xLyyfo=;
        b=CTKiIY0dcBqt3IUew3rFBALl7mmRmLBDrw3PuK4DGhdbBc/AHc30U5Y2hhreFEl7Wn
         2EDGcjbqBCud/DNGP7GVih+nvBCepmPT40Axb6hEObqU6GhCgiX0B1pc4bWmTB81ci9m
         uWIzYgrpDgHzHBOul5SrJ8k8AFatpIsXqDHx/FcnK5W0FIMQ9PLMg4bqQheJuofLDtO6
         LjiSVrUlV96yKFm6UauFRRDKtFOFFrABfq5is+gvDRlbrWuGv43BFYP7lyxdN+3Mheep
         bjFi1hMTb6Z6a8scWIN0xc4te15jm1d5bKry1yJ2/fnCRwqJgwaU72iV7C8ib7D/XVzU
         oWwQ==
X-Received: by 10.55.40.132 with SMTP id o4mr672433qko.61.1430940815355; Wed,
 06 May 2015 12:33:35 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Wed, 6 May 2015 12:33:35 -0700 (PDT)
In-Reply-To: <CAGZ79kaVhYi8amQkRMsHEWZCyMOSWr7NwRaz5TG+pyz5O79k6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268486>

Thanks so much for the correction. So the points i should not is that;
- I shouldn't Bcc but i should instead Cc
- I should work with porcelain commands and not plumbing commands
- My patch should have a description and a brief title
But my problem is figuring out the porcelain commands from the
plumbing commands. But that is a task for me to do. Let me fix the Bcc
problem.
