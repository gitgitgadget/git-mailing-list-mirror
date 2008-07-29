From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-svn and svn:externals, was Re: Hackontest ideas?
Date: Tue, 29 Jul 2008 14:28:31 +0200
Message-ID: <200807291428.32072.jnareb@gmail.com>
References: <20080729000103.GH32184@machine.or.cz> <m3myk1t54c.fsf@localhost.localdomain> <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 14:29:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNoKp-0007sN-W2
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 14:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589AbYG2M2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 08:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756534AbYG2M2r
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 08:28:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:32706 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491AbYG2M2q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 08:28:46 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1660926nfc.21
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2asgKqvyEsIqw62vQw08njNnjQgvB9uBm0UDFxzvOeE=;
        b=fp+NnZRdfWtLUvE/5n6uhdjLl7W3QCeBgQy8Xr2YWYf0M2Jn4L5+edUAj9HR/gauk9
         C23EBZg7lxLIbejzl/fJVE1NBehUTANDgQobsIhNL6yYOVIDjTKKrPjwIOv1GzlTSUAw
         3YvlOwX5y3L6uUhKSBGNVGT9QIgHHde0qo61w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qL6SCFgjwmmwjARtm4HiNvraf3xiP70l0zpWjA5T63jLKQh0/bCdi7saxz8OKa4ghL
         okMQ5tWhCcDwrh77jtXa1qEuLpLsAGlDOB69jmSQNAuj58ga5J8NZNxU+A3o49ToTflq
         hIlPyoOay0ox2fhYBWIUu+8PAeR1y+kSjPvo0=
Received: by 10.210.87.14 with SMTP id k14mr7540419ebb.60.1217334525206;
        Tue, 29 Jul 2008 05:28:45 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.244.7])
        by mx.google.com with ESMTPS id y34sm21788825iky.10.2008.07.29.05.28.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jul 2008 05:28:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90624>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 29 Jul 2008, Jakub Narebski wrote:
> 
> >  * handling of svn:externals using submodules
> 
> I doubt that this is easy.  Otherwise, Eric would have done it a long time 
> ago.

Yeah, I guess is too large a project for Hackontest.
 
> The main concern I have is to get the semantics right: AFAICT 
> svn:externals has _no notion_ of "what is current".  It just _always_ 
> fetches the HEAD.  Even if you check out an ancient revision in the 
> "superproject".

If I understand correctly with version 1.5 svn:externals can be
specified using "peg revisions", so they could refer to some specific
revision of 'external', like git submodules.

-- 
Jakub Narebski
Poland
