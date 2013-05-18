From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] fetch: add new fetch.default configuration
Date: Sun, 19 May 2013 00:13:01 +0530
Message-ID: <CALkWK0mGPMw8NuhJFS0gK2BVutRO=FxX1ss+1o8fnndCc13LWw@mail.gmail.com>
References: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 18 20:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udm6c-0007WA-AR
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 20:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738Ab3ERSnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 14:43:42 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:64759 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab3ERSnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 14:43:42 -0400
Received: by mail-ia0-f182.google.com with SMTP id z3so6120058iad.13
        for <git@vger.kernel.org>; Sat, 18 May 2013 11:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gYPpF3CdeghIPRT8XDBdMgkLkE4txs2g41Yt160Ud4Y=;
        b=w2oDAuOEGNOar6cv3qgpsv9nvtXqpwcllV7gcQwHIUbmupVL7nY0yhJTW2LUbif/st
         3Js022r2eej9wfu4zZCh2hsVQcdmspL9OI62oOpmXfxy2k0LPIroRv0uHbKjhAIcsvQr
         w3RTPct4ob665Gd+8qrS+8j3edpKVs7yNAWtQMRKuXVUbCITC2afwZHQdyI5qGuu2wTJ
         1x2iZJLQ5k7KCZ56kYYXI8upYnX/8SSq5Vnx5J/deR2bnpcCrOfDhxvAErTBN0SJPtlb
         TjX3vf1bqajlr1/RWS7AiRJdNtSwLppykWfAw811sfBg96v2PaP58MN9pNTHuljL/gUc
         WVgA==
X-Received: by 10.50.3.38 with SMTP id 6mr1643789igz.44.1368902621739; Sat, 18
 May 2013 11:43:41 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 18 May 2013 11:43:01 -0700 (PDT)
In-Reply-To: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224803>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
>   % git checkout --set-upstream-to master

What is the problem you're trying to solve: why do you want an
upstream set to master?  Is it only because of rebase?  We should
probably get rebase.defaultUpstream = @{u}|origin|...
