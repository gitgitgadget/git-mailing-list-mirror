From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 02/24] read-cache: use fixed width integer types
Date: Sun, 18 Aug 2013 16:21:22 -0400
Message-ID: <CAPig+cSRh==3PH3qZ9GNQiZ731c0sOWhQFmu3J8sBsP_wNM6Qg@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
	<1376854933-31241-3-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 22:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB9Te-0004IR-12
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 22:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab3HRUVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 16:21:25 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34524 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab3HRUVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 16:21:23 -0400
Received: by mail-lb0-f172.google.com with SMTP id o7so2527543lbv.31
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yyohU/UXSR6+j3bhOKpKjhOhxoAqn4QQc/6G4Yip/8E=;
        b=Phm4UBiIwb2FmPvqHObpN4qhw+IEnZKmyvj5j0feti/1cDXR00VKOF9QAVePwKlIQb
         Jd5OYTKr7xy2opfO2LkGCISNQE/UiXs870cQahssDwgxmy9Lhz3Y7WdXrsAt7++mTQUW
         JY2rZzbILpnzYIlbMxAppwo9OnLYzuNW8rNWdvsoQESW29SOk1EyouBzNMZ75gVvWZvf
         +bG8sqglkAsBivl6lmaVZRrwmUrsUERq+1iJoDJTnazSopKBxVzl2msfoMrdegTI0pHv
         ObHKKlT918tuHnW7jVSbKsBSUTTtNBa2SbMQiOg2QWzTw12nX014+uc7jg4TYtP7heVY
         4bOQ==
X-Received: by 10.112.42.68 with SMTP id m4mr8484254lbl.4.1376857282294; Sun,
 18 Aug 2013 13:21:22 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 18 Aug 2013 13:21:22 -0700 (PDT)
In-Reply-To: <1376854933-31241-3-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: MxC_VmiLcxKxqpM86aiNUAUSGpY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232514>

On Sun, Aug 18, 2013 at 3:41 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Use the fixed width integer types uint16_t and uint32_t for ondisk
> structures, because unsigned short and unsigned int do not hae a

s/hae/have/

> guaranteed size.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
