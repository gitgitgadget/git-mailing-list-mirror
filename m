From: Domenico Andreoli <cavokz@gmail.com>
Subject: multiple checked out branches
Date: Thu, 2 Aug 2007 00:04:35 +0200
Message-ID: <20070801220435.GA19226@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 00:04:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMJ6-0006Na-DH
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbXHAWEh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbXHAWEh
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:04:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:40361 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbXHAWEg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:04:36 -0400
Received: by nf-out-0910.google.com with SMTP id g13so87676nfb
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 15:04:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=meGfgA7S5rKlovXPPXdeAQrzw4I5UjHIVgH1JAklXAHOfgH61CoVx47hePfzQAwVhdK3E7RGXxQzdHI6PWwhyEftt4rEUE0gaBYITVv39EDXwvOCwXD6FAg6JtO8Hr8caCJ2YskRyf9fj74okIaXf2EJXwLzWkCRMsMGDPs0At0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Xczptuzgi/zOwOHGqDxSN16Lk00UAkhLraxwvAgRn11aaI6pXx9zKKJfqE1q0WQwZkKjMJbVITRolIGtXTY6aC1O+VfuuhOUb8n2DNU5wTRKt6u1q+DFP0Nkh9zq7HDnwQoNdLRd4qiX4+hEGHKs77MHUQMF7qh1+LY/nTG3urE=
Received: by 10.86.57.9 with SMTP id f9mr884371fga.1186005875033;
        Wed, 01 Aug 2007 15:04:35 -0700 (PDT)
Received: from raptus.dandreoli.com ( [159.149.71.27])
        by mx.google.com with ESMTPS id p9sm2444155fkb.2007.08.01.15.04.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 15:04:32 -0700 (PDT)
Received: by raptus.dandreoli.com (Postfix, from userid 1000)
	id 89AF76E359; Thu,  2 Aug 2007 00:04:35 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54482>

Hi again,

  I would like to contemporaneously work with multiple branches out of
the same git repository. This does not work out of the box.

So I prepare multiple copies of the same repository, every one will have
its own checked out branch but I want to share most of their .git subdir.

I surely want to share the object db, the local and remote refs.
This way it is enough to make a round of fetches/merges/pushes to have
all the shared-repositories up to date.

I expect to do the trick with some symlinks but I am not an expert of
git internals. Which traps are waiting me? Any hint? Thank you.

Regards,
Domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
