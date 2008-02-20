From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] Add support for host aliases in config files
Date: Wed, 20 Feb 2008 20:44:53 +0100
Message-ID: <200802202044.54987.jnareb@gmail.com>
References: <alpine.LNX.1.00.0802182317520.5816@iabervon.org> <47BAF18F.5040709@freescale.com> <alpine.LSU.1.00.0802191547580.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jon Loeliger <jdl@freescale.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 20 20:45:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRusu-0001E0-2S
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 20:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbYBTTpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 14:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756319AbYBTTpF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 14:45:05 -0500
Received: from gv-out-0910.google.com ([216.239.58.185]:9939 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbYBTTpC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 14:45:02 -0500
Received: by gv-out-0910.google.com with SMTP id s4so428731gve.37
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 11:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=f7tPsje3aJ5leCwVH47lD7aoB77hoVv2ooO0LPwjC6Q=;
        b=WbiSMa9kOPFLHBi7xIIszJMftpy+CRxP3NUmy5VTdvY2Z5MtEqqD7uh0oeyDW8FQFAO+05bXd/QS4r9gpngBAygOtEz9DTPAm4Okbx7RD7gmfa6B1J0kHLDNqqa8xjdswojUVplR6wzxkGkjwStFOKTfOnSO8mFKsPalShpc+DU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XzKqc5Np3TJHVigucHmJrOCqKVZSE44Yf5nnVr2r65fVrIjrNo/x2XwqoqalI7ippO7pMhNAHWTp8XjPGJQ7DEywIWIg9Xci7vG9lQews2Aofhb+1dgaVllhZPibk60PGMCXK5wTJHk0npZN18Cw3LmTERv+qEUh2y+oCK+sRQs=
Received: by 10.150.49.15 with SMTP id w15mr2883856ybw.101.1203536699763;
        Wed, 20 Feb 2008 11:44:59 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.189.142])
        by mx.google.com with ESMTPS id d24sm408020nfh.29.2008.02.20.11.44.57
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Feb 2008 11:44:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802191547580.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74540>

Johannes Schindelin wrotr:
 
> I just tried this:
> 
> $ git config rewrite."master.kernel.org:/pub".url \
> 	git://git.kernel.org/pub/
> 
> and it worked.  IOW, the config will look like this:
> 
> [rewrite "master.kernel.org:/pub"]
>         url = git://git.kernel.org/pub/
> 
> So maybe this is easier to grasp?

Perhaps that it is easier to grasp, but imho it is backwards,
as it is inherently 1 -> 1 in <original> -> <rewritten>,
while I think it is more common to have n -> 1, i.e. multiple
URLs (aliases), multiple alternative "spellings" with one
tried way to access repository.

-- 
Jakub Narebski
Poland
