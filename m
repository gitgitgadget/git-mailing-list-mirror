From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Is Git Scalable?
Date: Mon, 09 Feb 2009 10:51:55 -0600
Message-ID: <49905F2B.5030306@freescale.com>
References: <21916359.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: agent59624285 <agent59624285@spamcorptastic.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 17:53:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWZO8-0002yy-NY
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 17:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbZBIQwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 11:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbZBIQwN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 11:52:13 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:34910 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611AbZBIQwM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 11:52:12 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id n19Gq0mn015274;
	Mon, 9 Feb 2009 09:52:01 -0700 (MST)
Received: from [127.0.0.1] (mvp-10-214-73-77.am.freescale.net [10.214.73.77])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n19Gpw98008402;
	Mon, 9 Feb 2009 10:52:00 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <21916359.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109094>

agent59624285 wrote:
> I'm thinking on use Git in my projects. But I have a doubt I couldn't resolve
> in the Git Docs or Wiki.
> My organization has really big projects that we split in sub-projects, like
> this:
> 
> Big Project
>   \---> Project A
>   \---> Project B
>      \---> Project B1
>      \---> Project B2
>      \---> Project B3
>   \---> Project C
>      \---> Project C1
> 
> and so on...
> 
> Now it's possible to work in each "small" project independently (like "git
> clone ProjectB3") or you can work with a big project inheriting its
> sub-projects (like "git clone ProjectB" that automatically makes a "git
> clone ProjectB1",  "git clone ProjectB2" and  "git clone ProjectB3", putting
> each sub-project in the right place).
> 
> The question is: does Git support something like this?
> 

Perhaps "git submodule" ?

jdl
