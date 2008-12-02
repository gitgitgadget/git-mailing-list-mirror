From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Overwrite master
Date: Tue, 2 Dec 2008 11:32:29 -0500
Message-ID: <eaa105840812020832p395ecefdq57e62f95182a3557@mail.gmail.com>
References: <D1AC0A41-E89A-4B53-A449-DA9C4422998E@zooppa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicholas Wieland" <nicholas.wieland@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:33:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7YC6-0003T8-9V
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 17:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbYLBQcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 11:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbYLBQcb
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 11:32:31 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:52818 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYLBQca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 11:32:30 -0500
Received: by qyk4 with SMTP id 4so3503660qyk.13
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 08:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=qV22YSP/WM1zoX3+x4V37JJ49eApkVxgCSE1tMESrYU=;
        b=gbfvboFWtAPEHE/Gn9OrRskwtQeS7z4mFRNgMXoQC2ojjpwnpOfijSkyHjlfwawZHM
         BdiwCqWSOW1149UA0piQgI/pWwc6FHqIyz8Zm1/M7SSbLsjy+BcAHu7tXx0JmnyekqRx
         0U1SM3JokAJgiaQjCc5YSuNTT+l1+q4FT71kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=SxvZXEu5HjXXtTv7wxqfaDUiyfVi0yA3C019ADHhns3b7qixQwuB6dirw+v+L6klIl
         KB7z16z9bgYS7/1O6Yo3ICjo5vU4K+K08QYmpjZL2ZuGewOu7+VgO6uK0zcD/TQ/BLOY
         KAFk/EKotU8kaVI/LoaXZTjnKEfQuNQJ8z1R4=
Received: by 10.64.243.19 with SMTP id q19mr12979297qbh.50.1228235549297;
        Tue, 02 Dec 2008 08:32:29 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Tue, 2 Dec 2008 08:32:29 -0800 (PST)
In-Reply-To: <D1AC0A41-E89A-4B53-A449-DA9C4422998E@zooppa.com>
Content-Disposition: inline
X-Google-Sender-Auth: b1d20fff57154660
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102155>

On Tue, Dec 2, 2008 at 11:10 AM, Nicholas Wieland wrote:
> Hi *,
> I need to overwrite my master branch with another branch. I've already
> created a backup branch of my master.

While on master,
"git reset --hard <newbranch>"

Or while on a different branch,
git branch -D master
git branch master <newbranch>

Peter Harris
