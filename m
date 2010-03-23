From: Alexander Iljin <ajsoft@yandex.ru>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 20:21:12 +0600
Message-ID: <465338777.20100323202112@yandex.ru>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com> <1269353235.14299.0.camel@kheops> <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCY0LvRjNC40L0=?= 
	  <ajsoft@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 15:32:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu59V-0002MB-5F
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 15:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab0CWOcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 10:32:12 -0400
Received: from forward12.mail.yandex.net ([95.108.130.94]:49864 "EHLO
	forward12.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab0CWOcL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 10:32:11 -0400
X-Greylist: delayed 641 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Mar 2010 10:32:11 EDT
Received: from smtp13.mail.yandex.net (smtp13.mail.yandex.net [95.108.130.68])
	by forward12.mail.yandex.net (Yandex) with ESMTP id 7584315D0951
	for <git@vger.kernel.org>; Tue, 23 Mar 2010 17:21:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1269354086; bh=r+72QtrU9R0s/GPGelvbBYLwoh1l1PPgo1I0vgzu7e4=;
	h=Date:From:Reply-To:Message-ID:To:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=VyrqxoIUmhakkuFOMPwJCnrRyXrJIH1eezXvVSz4+2oWIyyxa0dz+D/27XRtdGSBh
	 9ZDnHHfq9UvAlY+dvOGgPh5D7Ni9mGijvEzfIiAxJnSyKNqWptmjwgpWYPlseubmX5
	 mUIvBnhNSK60T9cDOz7GDDnMGiNV2KgExLxKcLMY=
Received: from h88-115-126.sibinet.com (unknown [88.204.115.126])
	by smtp13.mail.yandex.net (Yandex) with ESMTPA id 37AC932200D4
	for <git@vger.kernel.org>; Tue, 23 Mar 2010 17:21:26 +0300 (MSK)
X-Priority: 3 (Normal)
In-Reply-To: <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>
X-Yandex-TimeMark: 1269354086
X-Yandex-Spam: 1
X-Yandex-Front: smtp13.mail.yandex.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143021>

Hello!

>>
>> git push origin +local_branch:remote_branch
>>

HM> Tell me more about that '+'. I've never heard of it before. Can't s=
ee
HM> anything in the docs (although I'm probably not looking in the righ=
t
HM> place)

  git help push

<refspec>=85
  The format of a <refspec> parameter is an optional plus +, followed
  by the source ref <src>, followed by a colon :, followed by the
  destination ref <dst>. It is used to specify with what <src> object
  the <dst> ref in the remote repository is to be updated.

  ...

  By having the optional leading +, you can tell git to update the
  <dst> ref even when the update is not a fast forward. This does not
  attempt to merge <src> into <dst>. See EXAMPLES below for details.

---=3D=3D=3D=3D=3D---
 Alexander
