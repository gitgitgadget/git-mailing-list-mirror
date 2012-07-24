From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v3 7/7] i18n: merge-recursive: mark strings for translation
Date: Tue, 24 Jul 2012 11:47:05 +0200
Message-ID: <500E6F19.8090009@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com> <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com> <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com> <441f0613d796c35b6865a1258f074d1ea91e605c.1343112786.git.worldhello.net@gmail.com> <e3481427da5efcb60053bb4cd5bcc7e4567100f0.1343112786.git.worldhello.net@gmail.com> <d3711733085d683d9a63cff6f615ef3114f2d3c0.1343112786.git.worldhello.net@gmail.com> <dc805486adc18bf70cea73f9c6363bb3c4cf6c2b.1343112786.git.worldhello.net@gmail.com> <ad6de748d6d50cd82f7e439284df168f422db50d.1343112786.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:47:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stbi0-0006k7-UR
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 11:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab2GXJrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 05:47:11 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41778 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab2GXJrK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 05:47:10 -0400
Received: by lbbgm6 with SMTP id gm6so8885615lbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=p34oc2mU1g0jOh3mb01sJifzGD0A3rraeCDq2h1SG2I=;
        b=Ha9pf7yE7r+YIh3DSYZOnqmEkIX8VyHwZ/sCWQc/z4zLMjzzIEZ2yDE6CvHtnghTqu
         yvIAEveLMgr/gdAEEq9ep9mhFTPz44yr2OMNRIJhICzHZ1tFlo7CcpnjYudpIPRyvC1p
         dtbFvzS3gPconiArdAjMyAX/YOWPtkfYHBA8fTc+/sqsTK1zowzNZM810+IJMSqQhRuT
         HJK9YyUNHKk1QYRDNzgu3FQUPvxqztMRWNUrRfHQiKNrGMvQ/rXh/b+EI5izEVKjYO83
         lpHcIHemHERvqAmq7MX0e+mKjUCiUgSVb+KIK951V8HhhOGXE0IcZlGSbTocGkh28sFt
         1BoA==
Received: by 10.152.131.68 with SMTP id ok4mr20603645lab.47.1343123228934;
        Tue, 24 Jul 2012 02:47:08 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id lv13sm16074973lab.8.2012.07.24.02.47.07
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 02:47:08 -0700 (PDT)
In-Reply-To: <ad6de748d6d50cd82f7e439284df168f422db50d.1343112786.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202025>

On 07/24/2012 08:59 AM, Jiang Xin wrote:
> Mark strings in merge-recursive for translation.
> 
> Some test scripts are affected by this update, and would fail if are
> tested with GETTEXT_POISON switch turned on. Use i18n-specific test
> functions, such as test_i18ngrep in the related test scripts will fix
> these issues.
>
The same comments I made for [PATCH 2/7] in this series apply here.

Regards,
  Stefano
