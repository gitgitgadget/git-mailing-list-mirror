From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Tue, 14 Oct 2014 19:17:54 +0700
Message-ID: <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
References: <1413090791-14428-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Oct 14 14:18:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe13f-0008Aj-Px
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 14:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbaJNMS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 08:18:28 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:60978 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177AbaJNMS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 08:18:27 -0400
Received: by mail-ig0-f172.google.com with SMTP id r2so14194902igi.17
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7zftxho8uEDLFVGZQLa8/08sOOula69EF1lGESHRgg8=;
        b=CZQMXiVgaBZjfBvSHIm+jQ/YCTB48JzYBamQOaPrrK1buyUoKUaJGRizlR3iywunhl
         fwtZTp17iJh59R7gaHizY5TIFS6qlSWrQz2JYyJOHFpMtz3u/eW8YMN4vr4auXNjfEqR
         0WRWzp2dHynVByVG7GqC7U1ysg+yVwkl8mDWmd6URe9y9Fz2AVdhNWStSPO/XR8bXeCR
         SRZcNcMPVtgbor3GTr7u/+szEDyUygn/iqG469SynmMe5roONBAc+Pnw6rs3eHcnrt0U
         GTNMXeV/OW0ZVjOcfczDwfcQfC7UBe3ZTpJDtNzDyc32cDdP2fYpsQFWudkbg5y2f0h9
         qVfA==
X-Received: by 10.50.85.101 with SMTP id g5mr6504326igz.40.1413289104583; Tue,
 14 Oct 2014 05:18:24 -0700 (PDT)
Received: by 10.107.131.1 with HTTP; Tue, 14 Oct 2014 05:17:54 -0700 (PDT)
In-Reply-To: <1413090791-14428-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 12, 2014 at 12:13 PM, Max Kirillov <max@max630.net> wrote:
> These are fixes of issues with submodules with use of multiple working
> trees.

I think the patches look fine from the nd/multiple-work-trees writer's
perspective. I know too little about submodules to judge if this is
the right way and not that way..
-- 
Duy
