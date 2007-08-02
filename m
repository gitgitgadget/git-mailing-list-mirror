From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: multiple checked out branches
Date: Thu, 2 Aug 2007 02:02:17 +0200
Message-ID: <20070802000217.GA20018@raptus.dandreoli.com>
References: <20070801220435.GA19226@raptus.dandreoli.com> <Pine.LNX.4.64.0708012309010.28202@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 02:02:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGO90-0005cq-1j
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 02:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbXHBACS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 20:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbXHBACS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 20:02:18 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:47292 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbXHBACR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 20:02:17 -0400
Received: by mu-out-0910.google.com with SMTP id i10so446629mue
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 17:02:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=cUQ+Up3jNH+ptipJlX8q8m8p5RB5Xr+J7nBzm2rEsqKBdurIa9rckJ7cQG/Up2uBl+Z1nmZo53WpTIi/VhT6re/0aU0WUwc536+EkbPTP87RQXsvtxI3CcxLlOwkWO786CXK4SlFYLvSizEWzh0PpIAP2mi/LsDqFx9X69mWNDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BnHm22mLS7ntRaB1pwGRm76POkPXOZlxzDKl0NEnVW07I1poJHnPsW0X/6LScd+ZDVmpaMfWI/lMIByVDEsXLTy02qyWp6H/+/id+Hu8AVMyYmTrWYxk/rkvyYQvS7Uk9XrL4ER7UzJyjD5AYjK2NLDKzuRCA16ED/622z5FMIo=
Received: by 10.86.73.17 with SMTP id v17mr962950fga.1186012935156;
        Wed, 01 Aug 2007 17:02:15 -0700 (PDT)
Received: from raptus.dandreoli.com ( [159.149.71.27])
        by mx.google.com with ESMTPS id m1sm2642009fke.2007.08.01.17.02.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 17:02:13 -0700 (PDT)
Received: by raptus.dandreoli.com (Postfix, from userid 1000)
	id 5A5FE68C7C; Thu,  2 Aug 2007 02:02:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708012309010.28202@beast.quantumfyre.co.uk>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54505>

On Wed, Aug 01, 2007 at 11:19:25PM +0100, Julian Phillips wrote:
>
> The biggest issue with doing this is that you have no protection against 
> making changes on the same branch in more than one place - something you 
> really don't want to be dealing with.  Basically you need to be careful 
> about updating refs that you have checkedout in workdirs.

Yes, I figured out this would have been a problem after thinking at it
a bit more. I surely do not want to be careful about acting on the same
branch in two working repositories at the same place.

The actual problem is that switching form a branch to another makes
my autotools fuck and I have to rebuild stuff all the time. My box is
still a faint-hearted single core...

cheers,
Domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
