From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Centralized repository
Date: Sun, 25 Feb 2007 09:51:34 +0000
Message-ID: <200702250951.37867.andyparkins@gmail.com>
References: <EF7846A2-C573-4018-B399-EBBEEE2812A4@mac.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bob <kranki@mac.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 25 10:54:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLG5W-0000rm-9s
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 10:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbXBYJy3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 04:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbXBYJy3
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 04:54:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:19496 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbXBYJy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 04:54:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so604465uga
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 01:54:27 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=grghGqEt1QL9xRKeHbd1RQloHusx/rC5HyBiLbgOyZ3nhImu2go7fDtnMhv63Dhq2J5kjjNgW9hYyGgNeMVMb2Xc9Y/n6Gpy1PVWUIW8qulQNbSoQ7SQ0eo4OH4ak1b4RJhDn6QiN3w9MwuzMVyeOEe72bS0BzZRxy9G1gznE2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CWjfz/z9Y7cpXfFMYZD/OR+tyFM0yl4b2CyGHtEpAWLRjj7dr7HrgwEcVkRHPh5wds0n4e4atNkZj8cbqhEggdjwTKWWEJqAOoifzqfxs8RncCkAEzPhYjcIWAtPRnfFF2rCDmyd6742+Gff3/8my4z6z/6QuEm+wTHn2z48hl0=
Received: by 10.67.100.17 with SMTP id c17mr4478300ugm.1172397267274;
        Sun, 25 Feb 2007 01:54:27 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id j1sm4262256ugf.2007.02.25.01.54.24;
        Sun, 25 Feb 2007 01:54:25 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <EF7846A2-C573-4018-B399-EBBEEE2812A4@mac.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40548>

On Sunday 2007, February 25, bob wrote:

> Anyway, for this one repository, I would really like GIT to support
> the CVS/SVN central repository system.  The rest of the time, I am

In the case of subversion: you really /wouldn't/ want that model.  
Subversion keeps a local pristine copy in the .svn directory of every 
file.  This makes local diffs and stats fast and not require network 
access, but also doubles the storage requirements of your working 
directory.

I've found that a packed git repository is often smaller than a full 
checkout of the project (it's almost scary actually - your entire 
project's history in less space than the project).


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
