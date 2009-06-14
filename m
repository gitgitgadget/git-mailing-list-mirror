From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: running git as root
Date: Sun, 14 Jun 2009 15:08:51 +0900
Message-ID: <20090614150851.6117@nanako3.lavabit.com>
References: <3a3d9e520906130825k25815c9atafde301d9fbc1da2@mail.gmail.com>
	<81b0412b0906131049v60cfbc9bm3fd26cc25acc2cd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Marco Nelissen <marcone@xs4all.nl>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 08:10:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFivE-0006hW-UM
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 08:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbZFNGKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 02:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbZFNGKT
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 02:10:19 -0400
Received: from karen.lavabit.com ([72.249.41.33]:39070 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbZFNGKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 02:10:18 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 4FD4011B7E1;
	Sun, 14 Jun 2009 01:10:20 -0500 (CDT)
Received: from 5306.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id GZQF2KQT1BZN; Sun, 14 Jun 2009 01:10:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=YP1LxuF8ErppUpY9hyHAHiYSUipG5wwO+3ngke79dCaKPZLgWWMhTjQzPDFxQe4REC5FRSGEx51HYHakGKZ4/FhQ8gqMGekXgEQhEig3fNk92lsGjT+if0FbSHIkccvIyHV25VCmzbFtJq++Q/GlDLxugfGQjJZ1S6kQ6/adcMk=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <81b0412b0906131049v60cfbc9bm3fd26cc25acc2cd4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121536>

Quoting Alex Riesen <raa.lkml@gmail.com>:

> 2009/6/13 Marco Nelissen <marcone@xs4all.nl>:
>> When running as root, git fails a number of test cases that expect it
>> to fail on read-only repositories (for example 't0004-unwritable.sh').
>> I was thinking of either changing the code so that it checks
>> permissions itself when opening files as root, or add a prerequisite
>> to those test cases so that they are skipped when running as root.
>
> There is such a prerequisite already (POSIXPERM), but what caused
> you to run the _tests_ as root?
>
>> What would be the preferred way?
>
> Use the prerequisite would sound right when not the
> strangeness of the idea.

I think somebody needs to repost an old patch from the archive.

    http://thread.gmane.org/gmane.comp.version-control.git/116729/focus=118385

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
