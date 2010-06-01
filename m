From: Alexander Iljin <ajsoft@yandex.ru>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Wed, 2 Jun 2010 00:45:19 +0700
Message-ID: <1785192885.20100602004519@yandex.ru>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com> <4BF7B751.7050704@pileofstuff.org> <4BFB7F7F.5090407@drmicha.warpmail.net> <4C041656.7000008@pileofstuff.org> <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com> <1533278916.20100601231415@yandex.ru> <AANLkTimnQJmctLU1LmT1x3KhB84J2Wrqsa8Nfo5vVDLI@mail.gmail.com>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCY0LvRjNC40L0=?= 
	  <ajsoft@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 19:46:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJVXg-0001cT-0B
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 19:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab0FARqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 13:46:15 -0400
Received: from forward12.mail.yandex.net ([95.108.130.94]:35205 "EHLO
	forward12.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756735Ab0FARqO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 13:46:14 -0400
Received: from smtp13.mail.yandex.net (smtp13.mail.yandex.net [95.108.130.68])
	by forward12.mail.yandex.net (Yandex) with ESMTP id A48D922107CF;
	Tue,  1 Jun 2010 21:46:12 +0400 (MSD)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1275414372; bh=5dOYwONaEbWWcviBNpQQVBnfxKckBtdXam3XYcMl+jM=;
	h=Date:From:Reply-To:Message-ID:To:CC:Subject:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=T9jTV/Sub7i/f7XNWuroPSjENB9AUlJViya0zcFHyI20IkKL1+exEEZLtDXj4vgFZ
	 0LLfybbXNDCMteLd0w2uI5Siiyjk0L69cbV03ST/vYUGKcZIpulPClg4wIICE3ZQKk
	 MiRCY9I1lposU9kc+P+g2S+A7ZIfPLiPyWh1jQl4=
Received: from h88-115-108.sibinet.com (unknown [88.204.115.108])
	by smtp13.mail.yandex.net (Yandex) with ESMTPA id D60C64158062;
	Tue,  1 Jun 2010 21:46:11 +0400 (MSD)
X-Priority: 3 (Normal)
In-Reply-To: <AANLkTimnQJmctLU1LmT1x3KhB84J2Wrqsa8Nfo5vVDLI@mail.gmail.com>
X-Yandex-TimeMark: 1275414372
X-Yandex-Spam: 1
X-Yandex-Front: smtp13.mail.yandex.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148148>

Hello!

DS> You can contribute to any subversion branch, but you have to do it
DS> with a local branch tracking the
DS> remote one

DS> say you are on "master" which track remote svn "trunk" and you want to
DS> contribute to remote branch "v1.x"

DS> you can do this:

  Thank you for the correction. I branched off the master, and then
  worked on both master and the feature branch. When I tried to
  dcommit, I could either push one or the other set of changes,
  whichever was currently checked out in Git. Glad to know there IS a
  way to do this properly. Still, a possible point to make in the
  Wiki.

---=====---
 Alexander
