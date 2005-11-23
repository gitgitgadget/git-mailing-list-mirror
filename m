From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: git-mv is not able to handle directory with one file in it
Date: Wed, 23 Nov 2005 15:57:12 +0600
Organization: AcademSoft Ltd.
Message-ID: <200511231557.12547.lan@ac-sw.com>
References: <200511231141.57683.lan@ac-sw.com> <200511231326.27972.lan@ac-sw.com> <438420CC.4050303@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 10:55:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EerKh-0006UE-Bu
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 10:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbVKWJy2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 04:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbVKWJy2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 04:54:28 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:20416 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1030364AbVKWJy1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 04:54:27 -0500
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 1AB34BD1B; Wed, 23 Nov 2005 15:54:26 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 2E8BD1C25AD; Wed, 23 Nov 2005 15:57:18 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id CB3E21C255C;
	Wed, 23 Nov 2005 15:57:12 +0600 (NOVT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12615>

On Wednesday 23 November 2005 13:57, Andreas Ericsson wrote:
> Are you saying this setup
> 	foodir/somefile.c     <--file
> 	newdir/               <--directory
>
> with this command
> 	git-mv foodir/ newdir

It is calling git-update-index --add newdir but actiual file structire is 
correct: 
newdir/somefile.c - is a file
