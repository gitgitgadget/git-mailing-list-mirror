From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Prevent users from adding the file that has all-zero SHA-1
Date: Mon, 19 Sep 2011 19:26:43 +1000
Message-ID: <CACsJy8Dc2mUPU5x=stRo+Hx+A4ZuVpVWvQAT2-Mq4VMmNywTAQ@mail.gmail.com>
References: <1316259574-1291-1-git-send-email-pclouds@gmail.com> <CAHYJk3TRHu0whbdPQXzs2ELpoiEqZPxeWmz_V4HQzj5XfAJDBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 11:27:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5a8J-0005ZY-Dw
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 11:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab1ISJ1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 05:27:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58159 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab1ISJ1O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 05:27:14 -0400
Received: by bkbzt4 with SMTP id zt4so5140258bkb.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 02:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=31XjW2yuJ5VC1yb8rREDDuQ35B+YyyV/oOwIsBhX+VM=;
        b=HqYSh5lexdmqZEoWaFS8cTdqcM/bFAEahKFPoYsbTFkoMAfSmTmT6AVhHiE8hw2pST
         YFoToOvrQcgzgrwjfSbCQGxioCLkngUtHU9oaE8T5eBzJrxyn292sgMboYu12xENC1q2
         TEznuIM6eVyos2I2gz/9Lg3dNAimXR1nxhafg=
Received: by 10.204.141.147 with SMTP id m19mr1347981bku.339.1316424433165;
 Mon, 19 Sep 2011 02:27:13 -0700 (PDT)
Received: by 10.204.7.1 with HTTP; Mon, 19 Sep 2011 02:26:43 -0700 (PDT)
In-Reply-To: <CAHYJk3TRHu0whbdPQXzs2ELpoiEqZPxeWmz_V4HQzj5XfAJDBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181672>

2011/9/19 Mikael Magnusson <mikachu@gmail.com>:
> Bad things will happen if you get an object with the same hash as any
> already existing one, and AFAIK, there are no checks for this.

Right. Forgot this, thanks.
-- 
Duy
