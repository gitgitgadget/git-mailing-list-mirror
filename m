From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Distinguishing trivial and non-trivial merge commits
Date: Sun, 02 May 2010 13:12:08 -0700 (PDT)
Message-ID: <m31vdugj2t.fsf@localhost.localdomain>
References: <19419.1721.763210.679444@winooski.ccs.neu.edu>
	<20100502181854.GC16051@progeny.tock>
	<19421.54064.178345.489772@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sun May 02 22:12:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8fWb-0000r5-DA
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 22:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102Ab0EBUMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 16:12:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51992 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758578Ab0EBUMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 16:12:12 -0400
Received: by wye20 with SMTP id 20so1264961wye.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 13:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lYFKtbd6ejSvq2eL+y7ebA2q4hBirwE1kZPqtg8OCww=;
        b=NbasQ7rWQSRLH9oEEdMw+iFs9w9CcPmZxuBZSmaM7/IxBAN2jophp1DnfWwCNPQ5xr
         tPoVbdqim8LEPtNYBT9OpSf6r82LfxPWjvYuwiDWPEhgpvNlhhEtKQyvzfqlyAqzfM0Z
         xKbH3yJOEPwEAHxsPZzHdj5T2gKvb1NxoPxmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=lWmEWQ8/72XggSg4Cenq4d3A1MZEEJn5x5udZ8miBYY4lOJ4Ir2jovVaFEI4Qfv47M
         9MppH/dBZiHp/Ihh4GZP/u/3S4IF9z+tMROhM6PCVr2CaTkc6XXMAqMxVl++0qbfTvX0
         CdAUrGreke1rIRINyiN0N3qOgUVybx7L4i4VE=
Received: by 10.216.86.16 with SMTP id v16mr5830580wee.169.1272831129822;
        Sun, 02 May 2010 13:12:09 -0700 (PDT)
Received: from localhost.localdomain (abvt225.neoplus.adsl.tpnet.pl [83.8.217.225])
        by mx.google.com with ESMTPS id z3sm35585937wbs.10.2010.05.02.13.12.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 13:12:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o42KBd6m014313;
	Sun, 2 May 2010 22:11:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o42KBMNP014309;
	Sun, 2 May 2010 22:11:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <19421.54064.178345.489772@winooski.ccs.neu.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146199>

Eli Barzilay <eli@barzilay.org> writes:

> OK, thanks for clarifying that.  For my purpose, I basically just want
> to know whether there was manual tweaking involved in the merge.  (For
> my thing I don't even need to see those changes, since I show the
> overall push diff only.)  What I ended up doing is pretty bad:

Well, the compact combined output is thought in such way that 
"git diff --cc" should be empty except for evil merges, when change
comes from neither of parents.  See description of --cc format in
git-diff(1) manpage.

The other side is "git diff --raw" output for merges.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
