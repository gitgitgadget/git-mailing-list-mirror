From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb bug?
Date: Tue, 26 Jun 2007 02:05:48 +0200
Message-ID: <200706260205.49337.jnareb@gmail.com>
References: <905315640706242315v3f649ef5w2a0706d0c4c68d8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog19@eaglescrag.net>
To: "Tarmigan Casebolt" <tarmigan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 01:59:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2yTL-0007F8-Gq
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 01:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbXFYX7y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 19:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbXFYX7y
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 19:59:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:27643 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbXFYX7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 19:59:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1402910ugf
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 16:59:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=impEo60XwoBQq6YJ745oCH+nWnvNq+bQVjWHoCVYxzVlR2RvEue6qgnQwyFXJvxr03KQiusG4Ru4mjftBixOO4C1B8T/TGi6QW28zsrugwjaxzgmgoA0tIXGpJ/mfqMSzKyg7Cq1XARuZHHmtRzSLcW3gPy3Va45WFrItKsnGXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Bacz/U96yGN2a9oOTQH5ECEKb4OV/DPoVuzErVapbhqs9riuwvU2lTMP5F4YCIBemA/Ort1Lbx7aZpb6PEcZIGrr/VKGYEgu8Uff+ab22UZLjeljYxy0GhaF7KhnstEZLvChhZtQcrgvzvLVu8Uz1cxOu117CYX/0klAgB5mmJE=
Received: by 10.66.240.12 with SMTP id n12mr5491768ugh.1182815991750;
        Mon, 25 Jun 2007 16:59:51 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w7sm12582784mue.2007.06.25.16.59.49
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jun 2007 16:59:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <905315640706242315v3f649ef5w2a0706d0c4c68d8e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50938>

On Mon, 25 June 2007, Tarmigan Casebolt wrote:
>
> I was looking through the kernel source and noticed a difference
> between the git version and the gitweb version here:
> http://git.kernel.org/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=net/netlink
> on gitweb, I only see 4 files, but in git locally on linux I see 71.
> 
> This might be because there are files that differ only in case?  (I'm
> using OSX, which has problems with case, and in particular that
> directory of the kernel source.)
> 
> Am I missing something, or is this a bug?

First of all, this question should be asked IMVHO on git mailing list,
with Cc: sent to Kernel.Org admins or John 'Warthog9' Hawley, author of
the gitweb modification (caching gitweb) used at kernel.org

I cannot help you what the contents of net/netlink should look like,
because I don't have clone of the linux kernel repository. By "in git
locally on linux" you mean in the working area? Or perhaps result of
"git ls-tree HEAD:net/netlink"? You should have provided command used
to get those 71 files, and perhaps even those 71 files list.

-- 
Jakub Narebski
Poland
