From: "Dana How" <danahow@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 15:15:54 -0800
Message-ID: <56b7f5510712181515m2b9056b6u70e586358be6f2a1@mail.gmail.com>
References: <20071218173321.GB2875@steel.home>
	 <20071218222032.GH2875@steel.home>
	 <Pine.LNX.4.64.0712182239500.23902@racer.site>
	 <200712190011.52613.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>, danahow@gmail.com
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:16:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4lg8-0005jw-Pm
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 00:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbXLRXP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 18:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbXLRXP5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 18:15:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:50585 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbXLRXP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 18:15:56 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1484938nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 15:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WbdmPa0HTBw+rFQAfqDxdNi8viRyZeN1meoNa/vSVlI=;
        b=pofXJoXLptXft4NF6V0pq+CTHsU9jWtLrKovjBla9CBtqt+7pACSdmWblfi4irL0SLttZZiheLVxLtzJSIc1mri6q2Ska4tAdbjFpwDvIs957tDe4jPCPudmYnRwv9IDt9tBn2EqJhZ7pbN4JZXiiGDx9TsdOXzU40qdZWH0a30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cQPTvQwH8tI8bM9eLAxtPh//MHXPr61lVmvVfcWZ0G/6TpH5wkvksH9TE4P+WOGG1fQsKOmb/mW5oUQP/lVNT94abFvTbUIjxU3rGbG2TjR1hn265zTtb7KQVjDZvow9j0EO+CmWlFZlpjkLi66CaYCJzNCnva1GRHb5/qIrvEc=
Received: by 10.78.171.20 with SMTP id t20mr11323186hue.41.1198019754442;
        Tue, 18 Dec 2007 15:15:54 -0800 (PST)
Received: by 10.78.130.1 with HTTP; Tue, 18 Dec 2007 15:15:54 -0800 (PST)
In-Reply-To: <200712190011.52613.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68844>

On Dec 18, 2007 3:11 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Although Linus argument about thinking that cwd affects translation
> from _commit_ sha1 to _tree-ish_ is also sound. Nevertheless I'd rather
> have separate syntax for cwd-relative paths, i.e. <commit>:./<relpath>.

Cool -- so adding recognition for ":." will support relative paths
when useful and will not interfere with any current syntax.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
