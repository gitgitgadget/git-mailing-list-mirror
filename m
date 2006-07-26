From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Wed, 26 Jul 2006 13:50:54 -0400
Message-ID: <9e4733910607261050k5f8d8d5dke5ded3a806b46f21@mail.gmail.com>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jul 26 19:51:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5nXA-00082h-Fn
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 19:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWGZRu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 13:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWGZRu5
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 13:50:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:43059 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751730AbWGZRu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 13:50:56 -0400
Received: by ug-out-1314.google.com with SMTP id m3so3283717ugc
        for <git@vger.kernel.org>; Wed, 26 Jul 2006 10:50:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nriIsxOcMon3ov6feb65vClmkvVTTJJd2izHhznc9tuNw+uQPwRPrgWSYEprigkPT1cduocISPQxswqgzK3PBeuVVp25b6NVwMy5XUn4wHRS09A3eka7MiQpCwNtINJZFBI9mLMk2g/gkGo6p5PvLeO4N8tmcR9sxIjgzes5FB4=
Received: by 10.78.122.11 with SMTP id u11mr3315811huc;
        Wed, 26 Jul 2006 10:50:54 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Wed, 26 Jul 2006 10:50:54 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24229>

An exact test case:

git clone git foo
git clone git foo1
cd foo
mkdir zzz
git mv gitweb zzz
cg diff >patch
cd ../foo1
cg patch <../foo/patch

This patch won't apply because zzz does not exist in foo1

-- 
Jon Smirl
jonsmirl@gmail.com
