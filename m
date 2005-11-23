From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: git-mv is not able to handle directory with one file in it
Date: Wed, 23 Nov 2005 16:21:34 +0600
Organization: AcademSoft Ltd.
Message-ID: <200511231621.34259.lan@ac-sw.com>
References: <200511231141.57683.lan@ac-sw.com> <200511231326.27972.lan@ac-sw.com> <438420CC.4050303@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 11:20:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeriF-0007UG-Kq
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 11:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbVKWKSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 05:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbVKWKSt
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 05:18:49 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:49859 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1030386AbVKWKSs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 05:18:48 -0500
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 2071DBD1B; Wed, 23 Nov 2005 16:18:47 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 602A21C9B38; Wed, 23 Nov 2005 16:21:39 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 816BB1C9376;
	Wed, 23 Nov 2005 16:21:34 +0600 (NOVT)
To: Andreas Ericsson <ae@op5.se>
User-Agent: KMail/1.8
In-Reply-To: <438420CC.4050303@op5.se>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12616>

On Wednesday 23 November 2005 13:57, Andreas Ericsson wrote:
> This is broken. It only checks if there's just one source-file
> regardless of whether or not it resided in a subdirectory. I'm not
> exactly fluent in perl so I can't submit a patch, but the src option
> needs to be directory aware, traverse all source directories and then
> move the files axing everything but the bottom-most dirname to the
> destination directory.
>
> Any takers?

I still does not understand what this part should do. I know perl enought to 
fix it but I don't understand the logic.
