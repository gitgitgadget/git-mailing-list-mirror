From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] fetch-pack: check for valid commit from server
Date: Fri, 19 Aug 2011 11:19:16 +0700
Message-ID: <CACsJy8AhQ2EqdZRyBD3-E1Sx52Jz_OhSVoGUbCmsC2LKMiYZhw@mail.gmail.com>
References: <1313674563-12755-1-git-send-email-pclouds@gmail.com> <CAJo=hJvN9W00ncG53933yiqT++QCxGLUqp8KtG=BsvKD81wWyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 06:19:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuGYi-0002S3-77
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 06:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab1HSETs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 00:19:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64734 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab1HSETr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 00:19:47 -0400
Received: by bke11 with SMTP id 11so1933336bke.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 21:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QBCgH6GxqRt/dEw4U65CQ8wHbV2dWqRaO1oDhBpg3OA=;
        b=W13Z+lf4ARyYjHuOyK1Kd6/h92IPE6UBjJqaMjHtu5rQjFc0mTYgKeGeonusWjmmw9
         BF0O1nXUNd2S83aMEmjjzKaYLciWLk0b9C6ZNH2uf4WxlBuEuGUI0EQc+gEKqQtCbc27
         18PzcCXSO+/veFoLreMFQImNhdxvSvd8NBVLM=
Received: by 10.204.150.193 with SMTP id z1mr144788bkv.123.1313727586241; Thu,
 18 Aug 2011 21:19:46 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Thu, 18 Aug 2011 21:19:16 -0700 (PDT)
In-Reply-To: <CAJo=hJvN9W00ncG53933yiqT++QCxGLUqp8KtG=BsvKD81wWyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179672>

2011/8/19 Shawn Pearce <spearce@spearce.org>:
> Just curious, did you see this on a particular server somewhere?

No. I was looking for lookup_commit() call sites without proper NULL handling.
-- 
Duy
