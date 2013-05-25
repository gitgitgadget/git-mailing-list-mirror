From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/9] fast-export: add new --refspec option
Date: Sat, 25 May 2013 02:27:00 -0400
Message-ID: <CAPig+cQQBF-fCK2kQA35F_AuD=uFY0KVNMAurRA1U10ctDxxBA@mail.gmail.com>
References: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
	<1369450060-19011-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 08:27:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug7wa-0002tg-Ld
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 08:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348Ab3EYG1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 02:27:04 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:54186 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab3EYG1D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 02:27:03 -0400
Received: by mail-la0-f43.google.com with SMTP id ez20so5171637lab.30
        for <git@vger.kernel.org>; Fri, 24 May 2013 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=M2T9JqJPwLfbKBXE7FCgl8h6G3P3ZJvhe5NagHu6wNM=;
        b=aYrMRIr+yq5U160eDo5negsnQVKSrlgBYpfosZl2ydJd8xEUxcpZ45v/fOZexXbSRm
         yXxEtb2WBAZS7gjSMyOsNnJvUcem5RgERCt6/jdwpPZkm/kIFXjh95GbMTUl6DfgxBGU
         /ODGP7RzgbHRuPDSDvsFt6y0YPV6hjZEMudyoK9/s+zm6nfA/KIJH94pt8LSk5V9WIH/
         xemx11ODG/ry4H0YPV4K8Qs16HYQ9CCs2uUYrKkqq2Vp6onnDXOAtwlerbeImR714QjA
         1QGSECyjAkuwSjfq3HQJvJUcw+L+liMbtSdRjmJTwag3D9jRwm9ke10dwnYZqmmuM/gr
         MDOQ==
X-Received: by 10.152.22.73 with SMTP id b9mr10481043laf.36.1369463220964;
 Fri, 24 May 2013 23:27:00 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Fri, 24 May 2013 23:27:00 -0700 (PDT)
In-Reply-To: <1369450060-19011-6-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: OY7b7hXfCHD72DjX1340EZgko-M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225489>

On Fri, May 24, 2013 at 10:47 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So that we can covert the exported ref names.

s/covert/convert/

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
