From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Wed, 23 Jul 2008 18:52:09 +0700
Organization: AcademSoft Ltd.
Message-ID: <200807231852.10206.litvinov2004@gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 13:53:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLcuN-00017d-7b
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 13:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbYGWLw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 07:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYGWLw2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 07:52:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:29909 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbYGWLw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 07:52:27 -0400
Received: by ug-out-1314.google.com with SMTP id h2so479697ugf.16
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 04:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ls0kTjD2itT/81aj3pY+xXQUEOQG0t56gPtyc/eRspA=;
        b=nwgd7hTUAs6NFND9lkBATWckzH7/V+OH2D3Gdj7J/mm5W9a0mP6HT0/BgadD5hj4Ek
         W1NXZKy2l2IKfZ8XxDBXzN37ghLQhOMUzNAhsdxENMZlRssVrgaymmq7ssiopuducRFk
         V6kTMNlUyiyXtBma7KEMNTgb9pMkaAISW8RfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TcO+p8uHeQGba2OBJ3/j2cHh5VGoTLjIp5grkXj0Zv7ncbLuuMt89lw4y+e0g85ZfI
         dl4BbJ7+S5WULEWjJTAj1Q98bK7NoBY/mAAw0NHA0F53xZiLuW/j85SEDcfSf8ImbW2I
         1pJFyL1gKcojbF+z2rxNdV1WWmiqZUSqwrQlQ=
Received: by 10.67.115.12 with SMTP id s12mr196487ugm.51.1216813945765;
        Wed, 23 Jul 2008 04:52:25 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [91.201.74.194])
        by mx.google.com with ESMTPS id k30sm12874004ugc.31.2008.07.23.04.52.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 04:52:18 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89637>

> On Wed, 23 Jul 2008, Alexander Litvinov wrote:
> > In short: I can't clone svn repo into git when crlf convertion is
> > activated.
>
> This is a known issue, but since nobody with that itch seems to care
> enough to fix it, I doubt it will ever be fixed.

That is a bad news for me. Anyway I will spend some time at holidays during 
digging this bug. 
