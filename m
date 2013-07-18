From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Thu, 18 Jul 2013 22:56:37 +0700
Message-ID: <CACsJy8Av7b9GMuO-HsT_+QHAc3iDUZQk5KdJ=p8VugaYc3nUPg@mail.gmail.com>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com> <CACsJy8CpZHTCr0=MkSpfurPW_fyLGN_zd4uSzvBSYbuqH8aXew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Rahul Bansal <rahul.bansal@rtcamp.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 17:57:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzqZu-0003aw-L6
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 17:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447Ab3GRP5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 11:57:10 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:45338 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab3GRP5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 11:57:09 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so4314415oah.25
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RUdHuyuLhhwgwZVT3tLBQqHky9oR5eJZrR33K3VFLy0=;
        b=WqH4VAE0djFCJVTgBS1PVv40XpV6QVR4Qhto48WzE0brbl/Lv32DBp9LCI0yGwYWY6
         tHzh6V0ZO4hqKcekDWmOblpPCl8++yX3VYM8mkfgsJnpH9rkXhmF2jAEm55XDjl1C7P5
         mMIRIGBQ0W9OEhqL9P5y8o+7W7E50inlwPJmdASRIVIhZk9XGwFgDkMmIa4vWECuXeNt
         GJtjejWjfujE+7rP0kpdbozZd+O31Gd8vErYBeT/MbQv9kPpXzvcd3SDGxO29g5/D3ji
         bSM4DXM9B0ftykGro4UHgFNagrLz+qbFxz0fV5PmP87xwkrVOR2ro891PK3ziN5b1+MA
         I2aQ==
X-Received: by 10.60.136.161 with SMTP id qb1mr13992228oeb.32.1374163028709;
 Thu, 18 Jul 2013 08:57:08 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Thu, 18 Jul 2013 08:56:37 -0700 (PDT)
In-Reply-To: <CACsJy8CpZHTCr0=MkSpfurPW_fyLGN_zd4uSzvBSYbuqH8aXew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230696>

On Thu, Jul 18, 2013 at 10:51 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> Try
>
> git for-each-ref --sort=committerdate --format='%(refname:short)' refs/tags

And I wondered why it did not seem right. Use this one instead

git for-each-ref --sort=taggerdate --format='%(refname:short)' refs/tags

make it --sort=-taggerdate to reverse sort order.
--
Duy
