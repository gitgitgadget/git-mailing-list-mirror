From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Re: Bug? url.insteadOf overwrites remote.pushUrl
Date: Fri, 14 Oct 2011 23:16:41 +0400
Message-ID: <0656F8BA-3B41-473D-88A6-6A703C9A9CED@jetbrains.com>
References: <CAB6D58F-A3C9-4532-A9CC-10E43CD34E4E@jetbrains.com> <4E9856BD.3010807@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 21:16:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REnFR-0005yY-Od
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 21:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004Ab1JNTQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 15:16:45 -0400
Received: from mail1.intellij.net ([46.137.178.215]:51703 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286Ab1JNTQo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 15:16:44 -0400
Received: (qmail 20193 invoked by uid 89); 14 Oct 2011 19:16:43 -0000
Received: by simscan 1.1.0 ppid: 20149, pid: 20184, t: 0.0842s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO ?10.0.1.7?) (Kirill.Likhodedov@jetbrains.com@109.167.130.96)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 14 Oct 2011 19:16:42 -0000
In-Reply-To: <4E9856BD.3010807@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183598>

>> On the other hand, pushInsteadOf doesn't
>> override explicit pushUrl. Is it a bug?
> 
> That is as described in the thread (thanks for linking to it).

> pushurl predates pushinsteadof, and when the latter was introduced, one
> could have argued for or against "insteadof" being applied to pushurls.
> But that was necessary before, and existing behavior at the time when
> pushinsteadof was introduced. So, I don't see a bug, nor anything we
> could change now, though arguably most people use either pushinstead of
> or pushurl, but not both.


Yeah, that's clear now. As I already answered to Junio in another thread, my question was only about insteadOf, not pushInsteadOf behavior. 
The behavior of pushInsteadOf is completely clear from the thread and from t5516-fetch-push.sh
Sorry for making it not clear enough. 

Anyway, thanks for giving a one more explanation and example on how url, pushUrl and insteadOf configs work, it is always useful to go though it once again.
