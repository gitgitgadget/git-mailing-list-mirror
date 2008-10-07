From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit bug] git user settings not retrieved when launched for Windows explorer
Date: Tue, 7 Oct 2008 13:10:52 +0200
Message-ID: <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>
References: <48EB10C8.4070009@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Abdelrazak Younes" <younes@lyx.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 13:12:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnATz-0002KS-4Z
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 13:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbYJGLKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 07:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752955AbYJGLKz
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 07:10:55 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:30830 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbYJGLKy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 07:10:54 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2745272fkq.5
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 04:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XArU1Zbli6ga2sC5YGYYLNOmFkWA0767Hd9TW+bf/vs=;
        b=iAfAGY3SCOwMqIyqsTT8UqJX1zjxrRFWYtlldeVB8Mrwq4RJxHkHNAsrqJQOlCiKyj
         Ulq7eaXsUzGIn2+XFT0tlek9dqJml17S16eukP2fIKssL/EqHGStD08+kBD5V9DtkRb6
         DTBbnazLc/lG+T64pLbX1r7PF8CQ723xDWMZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SVnMcm6qKsFF8F17eCPnbzQ8HOpTSn6s3UGxVI4Cg+jJhm/8LRPXNLcquddrbTsouv
         l+V2vttac3itNTItEI9+ojWy7ZNuknkRE/o58dMetLp5GymjIqbvtQNt58YlvPBY/aJ5
         JThKJxb1UAqWSumoPeNkwUyWGH8/iDeH8Y+fI=
Received: by 10.181.58.18 with SMTP id l18mr4629684bkk.81.1223377852915;
        Tue, 07 Oct 2008 04:10:52 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Tue, 7 Oct 2008 04:10:52 -0700 (PDT)
In-Reply-To: <48EB10C8.4070009@lyx.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97691>

On Tue, Oct 7, 2008 at 9:33 AM, Abdelrazak Younes <younes@lyx.org> wrote:
> Dear Marco,
>
> When I double click on qgit.exe, the user name and email are not shown in
> the user settings (for any of the 3 combo values). But if I run qgit from
> the commandline at the mysysgit bash prompt, the boxes are properly filled.
> I would like to debug it but, as I reported last week, the MSVC project
> doesn't work for me.
>

Sound like a problem of startup directory: on the command line you
start from the right directory...when you double click on which repo
qgit is open ?

Marco
