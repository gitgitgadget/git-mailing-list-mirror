From: Alexander Iljin <ajsoft@yandex.ru>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Tue, 1 Jun 2010 23:14:15 +0700
Message-ID: <1533278916.20100601231415@yandex.ru>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com> <4BF7B751.7050704@pileofstuff.org> <4BFB7F7F.5090407@drmicha.warpmail.net> <4C041656.7000008@pileofstuff.org> <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCY0LvRjNC40L0=?= 
	  <ajsoft@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 18:22:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJUES-0007JX-Ue
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 18:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438Ab0FAQWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 12:22:20 -0400
Received: from forward1.mail.yandex.net ([77.88.46.6]:58982 "EHLO
	forward1.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab0FAQWT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 12:22:19 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jun 2010 12:22:19 EDT
Received: from smtp1.mail.yandex.net (smtp1.mail.yandex.net [77.88.46.101])
	by forward1.mail.yandex.net (Yandex) with ESMTP id 87A7369E90BE;
	Tue,  1 Jun 2010 20:15:33 +0400 (MSD)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1275408933; bh=6rILQKE/zwVumUfMB2diEVYjJQ/OaBKhgoy9OEWRatE=;
	h=Date:From:Reply-To:Message-ID:To:CC:Subject:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=crFeZ3kvoTnz0YeH1LU8dtTCjyylFscAVgynl9EX6fJfBgX2CfTyZpjKa8MM+v4us
	 RPxfil5ksSPDI7zKan8wvGX8vzLTg+qzqrazfi9ASohYRn63UFlfg6UuUtVsYnFOf2
	 eTZdbNJ5cZFhPQ/W8lisTp7rrwhE0gBL4JJV1zJE=
Received: from h88-115-108.sibinet.com (unknown [88.204.115.108])
	by smtp1.mail.yandex.net (Yandex) with ESMTPA id 11095290096;
	Tue,  1 Jun 2010 20:15:32 +0400 (MSD)
X-Priority: 3 (Normal)
In-Reply-To: <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
X-Yandex-TimeMark: 1275408933
X-Yandex-Spam: 1
X-Yandex-Front: smtp1.mail.yandex.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148136>

Hello!

DS> You also can't create new Subversion branches or tags with git-svn,
DS> you'll had to use subversion directly for that.

  Another point: you can't contribute to branches via git-svn, you can
  only commit to trunk. It is easy to be confused if you've created a
  feature branch in Git. If you then want to git-svn dcommit a
  half-done work, you will mess up the trunk.


---=====---
 Alexander
