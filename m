From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Subject: [PATCH] git-merge-pack
Date: Fri, 7 Sep 2007 08:24:20 +0100
Message-ID: <200709070824.23541.andyparkins@gmail.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org> <7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 09:24:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITYCm-0005Yi-6A
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 09:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbXIGHYf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 03:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbXIGHYf
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 03:24:35 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:3208 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbXIGHYe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 03:24:34 -0400
Received: by fk-out-0910.google.com with SMTP id z23so365076fkz
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 00:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=gFL9UPUacb8tXzBkByVq50RHcbxRLhnJbVsy6egyLsI=;
        b=eIE5jjJiD3GBcB/XuA+zB76r1eOKmNjbK+LWVn9oAWnvNzMT4TjDw9cD4Bvv+IdwT4hGoMk2gPkvnRwUKpUmGg9zyBeU/FY2wbLqLkcgGuwPFAIMqBppg7iXSWOmrB0VTyYBnEz9CesS6QpncUebdaW4A/XyebA83IDdCXvNXPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lKh3pGsGxJkkc/LiOjb3T71VxKmZTNkWIw3nPo/CKTi57Yw55CG9XrE2ePx7swYvl/BEjPrMuNu+JdKQelpu8lAotF3J5bEq2nhB/iOsSBCKOrRz4zPwZO77/Ah57HZlKs9uqsYr8TIh1ieqKnknwbAjq1NVk0wNaHDeBjZ56wA=
Received: by 10.82.183.19 with SMTP id g19mr2018313buf.1189149869089;
        Fri, 07 Sep 2007 00:24:29 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id h1sm425605nfh.2007.09.07.00.24.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Sep 2007 00:24:28 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57995>

On Friday 2007 September 07, Junio C Hamano wrote:

>  builtin-merge-pack.c |   87

Can I suggest not calling it git-merge-pack?  It makes it look like it's a new 
merge strategy called "pack"...

git-merge-base
git-merge-file
git-merge-index
git-merge-octopus
git-merge-one-file
git-merge-ours
git-merge-recur
git-merge-recursive
git-merge-resolve
git-merge-stupid
git-merge-subtree
git-merge-tree


  
Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
