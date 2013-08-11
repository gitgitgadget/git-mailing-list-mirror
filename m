From: =?UTF-8?B?0JjQu9GM0Y8g0JLQvtGA0L7QvdGG0L7Qsg==?= 
	<prijutme4ty@gmail.com>
Subject: Re: Bug in git on windows
Date: Sun, 11 Aug 2013 10:45:21 +0400
Message-ID: <CAHHiLxTsTrQy3PBHSpMTUHpRMWnKwgzf=nSuUrZU3cniK6=vvg@mail.gmail.com>
References: <CAHHiLxQW00Zc9hpUEVV0bZ7_+18tCNdGT+bhrmryr47aj=x6XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 11 08:46:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8PPx-0007hl-Uq
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 08:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab3HKGpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 02:45:53 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:56397 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab3HKGpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 02:45:53 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so4582302wes.20
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=E0dwYMwoEczDaRK6iFyyMs3tpvLJiuQPyltegJbCO+k=;
        b=bHHNATmQehunjiPF2qWqOTW+XT9igG/80Nii7Eu0JAnU3vqmj5OH2FIClvxo63vxX2
         ZIdGYWkVcK/BybIanYbDzU4aOKiunN6cpCcY3K4Syf0JDhPzLEfbcsIhx2R75P/Yther
         3QUK0WZDJ5HMivSKinixXYdq/zRVSaxn8t1gxna6hf7EcDnSJE6sfFo/gZwDppEoSRcL
         Tq7IqETxmHOn/UPBPf6jpjwFs1oj7hteyOl3GUkASKg6qUf3DZrLZZJWDgbcqpJ8JaB+
         wc8LVvOHyQYzxIrVqg5BoMoo0yU+v4gPBHfdrKR6BnYhjZil5f1c2k1uYLgpsypTYhin
         U/Ew==
X-Received: by 10.180.19.196 with SMTP id h4mr3700829wie.38.1376203552091;
 Sat, 10 Aug 2013 23:45:52 -0700 (PDT)
Received: by 10.194.110.163 with HTTP; Sat, 10 Aug 2013 23:45:21 -0700 (PDT)
In-Reply-To: <CAHHiLxQW00Zc9hpUEVV0bZ7_+18tCNdGT+bhrmryr47aj=x6XA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232124>

git under windows doesn't check case of letters in filename. So when
one rename for example images from *.JPG to *.jpg, git doesn't files
in a repository so when one deliver this repo on *nix -system, old
filenames preserve and this matters.
It can be very confusing when some of assets in your website on server
can't be loaded after deploy, though on windows all was ok.
Possibly git windows shall identify changed case of symbols and
suggested to rename files in commit.
