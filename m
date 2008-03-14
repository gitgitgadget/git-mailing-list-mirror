From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 15:53:52 +0100
Message-ID: <b77c1dce0803140753w21515021u4541796d6e6934b@mail.gmail.com>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
	 <m3lk4ly3vy.fsf@localhost.localdomain>
	 <20080314134205.GA19674@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, geoffrey.russell@gmail.com,
	git@vger.kernel.org
To: "Chris Shoemaker" <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 15:54:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaBIy-0006Vl-CF
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 15:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbYCNOx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 10:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbYCNOx6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 10:53:58 -0400
Received: from rn-out-0910.google.com ([64.233.170.187]:60841 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYCNOx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 10:53:57 -0400
Received: by rn-out-0910.google.com with SMTP id v46so2737784rnb.15
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Kvj23EEaVe3Yugfoh7l9t2MgUEL5TIlc9yU5Ol1mxTs=;
        b=cwHTPAP7bJf4KPvKxOrucq1+ucYCC8/UcfALLjx4BdHC3IUuD2auANdFq4o3CQtfDtLzvBQ15qplMphxiasKjtFRTLA269mcXIxDOLAIUT1VcwC13qMoaNs9ymcflO8bspuVeJWupY9NKOv2UuXU7PoIxmMZ7aS88YPQ2vpYWFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DLd/NenZ14VPfO8Qy3LTdSzzYQ/YdGpg5E8lZTydw1GMLra83qekexpUa8PoE28UIxpZ3b62Krvy2bwUSj6y1PRcjlG11UdQlVnJ2Qiswg7JB/rkbjqyHDRuPQe78ttLJqaE+noj5B4868vXQpExQjbd3N820OqfYlP0ct7dc7I=
Received: by 10.142.226.2 with SMTP id y2mr4971481wfg.75.1205506432330;
        Fri, 14 Mar 2008 07:53:52 -0700 (PDT)
Received: by 10.142.156.10 with HTTP; Fri, 14 Mar 2008 07:53:52 -0700 (PDT)
In-Reply-To: <20080314134205.GA19674@pe.Belkin>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77233>

On 14/03/2008, Chris Shoemaker wrote:
>   This way you would get exactly:
>
>     1---2---3---4---5---3'   <--- master <--- HEAD
>
>
>  While the 3' commit has the same contents as 3, it is a new, distinct
>   commit with its own history.  Its commit message should explain why
>   you want to go from 5 back to the contents of 3.

Just a small question -- does that mean that 3 and 3' share the same
tree object ?
