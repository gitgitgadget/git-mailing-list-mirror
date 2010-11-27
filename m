From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Patchbombing or not, that is the question
Date: Sat, 27 Nov 2010 18:18:12 +0100
Message-ID: <AANLkTi=C4opog2SfU9R_=dSOGY_5+0WYtFL8BNqcOwUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 27 18:20:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMORd-0003dV-S6
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 18:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab0K0RSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 12:18:33 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34489 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab0K0RSd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 12:18:33 -0500
Received: by iwn5 with SMTP id 5so81127iwn.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 09:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=mLXgNBjplHyoLv61ok/xrr+ugR31gsPVGdmH9eTlM5M=;
        b=hquIGoxulzsqJ3W4B6QzZFWQcMnWun8LXv9lF0zK9+03Sn93U5uAxV5PDN6toHZ0IC
         pH/yrepDNfIFp8qv8gvn8OidINEGkRHdefamUbNJymWFP2uKTsJUr6Xy8TA6f1kkLP6R
         uOFSqF3wZ4qzEQjiW6OJk7Mevp0bFeGjXiN98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=ZrMKx1t1hf8WeAxmFsJzvgOzE4cy8TV9IjgVJeB4pRSEnws0hz0WLkAggMX+jU0Lu3
         jBML3/Iwed0WxpmqlGZ1bbq/En+7lSjdzKg+m71STy2BjLxq65CJNhJrvByVYodDIxL/
         YW6MXQwC/DkYfVcLYTmWRmi8tIkaBCeA8p9hM=
Received: by 10.231.191.4 with SMTP id dk4mr3168340ibb.82.1290878312367; Sat,
 27 Nov 2010 09:18:32 -0800 (PST)
Received: by 10.231.160.210 with HTTP; Sat, 27 Nov 2010 09:18:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162315>

Hello all,

I prepared a bunch of patches to add support to some other browsers to
git-web--browse (opera, seamonkey, elinks). Currently I did one patch
per browser. Should I squash them all together? (The series will also
contain some other patches that will stay separate.)

-- 
Giuseppe "Oblomov" Bilotta
