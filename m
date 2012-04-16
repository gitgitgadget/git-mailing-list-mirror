From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 15:09:41 -0500
Message-ID: <20120416200941.GD12613@burratino>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
 <20120415213718.GB5813@burratino>
 <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
 <7vaa2by8nj.fsf@alter.siamese.dyndns.org>
 <20120416160729.GM5813@burratino>
 <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:09:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJsFH-0002pi-NF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405Ab2DPUJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 16:09:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41105 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab2DPUJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 16:09:50 -0400
Received: by ghrr11 with SMTP id r11so2720603ghr.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kGgvmAFzYx++QTBac6+c6Mq5aDxR3MepMtc5bDvPr7E=;
        b=Sj401Qcn/yA7j2o7bqmrZZd6bPJS125DURU9N41hk2NsDFpTAw02KLCF58PRMG6oDc
         QjaYWoHB5Kwh0crWVV9CUQY92aFAEojWERaBYMH//znFnkTRh2NPf9yu8Csn0ebQDRRs
         CuR4jM3sAd/ph0D6pwZi1l0F1Y6ajM5e93mfxbqxDRHBJCFpe9b2Ad1aIZ8XfOx8n20J
         kSVEAzqj3rde6ctwvxgt6iCLSYxZFPCVRZ2GsGqEBrYpqAuYVRTfAWnKArdQSN8Kia4y
         w14zAYT6pVewUW6p95pEBCclSUMYnSmXFhKU40gMIgVePabxLDXbdpAdd11GOhWMoOka
         cHbQ==
Received: by 10.60.21.103 with SMTP id u7mr17632940oee.11.1334606989929;
        Mon, 16 Apr 2012 13:09:49 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h5sm20532345oba.17.2012.04.16.13.09.48
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 13:09:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195685>

Felipe Contreras wrote:

> I would like to see a completion script that actually has a function
> supposed to be exported and that still uses the _ prefix anyway.

The /etc/bash_completion library itself exports lots and lots of
functions with a _ prefix.
