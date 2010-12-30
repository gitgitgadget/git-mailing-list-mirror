From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: rebase parents, or tracking upstream but removing
 non-distributable bits
Date: Thu, 30 Dec 2010 14:58:47 -0600
Message-ID: <20101230205847.GA29012@burratino>
References: <ord3ojb0yy.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexandre Oliva <lxoliva@fsfla.org>
X-From: git-owner@vger.kernel.org Thu Dec 30 21:59:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYPaW-0005Zz-Ft
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 21:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab0L3U7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 15:59:00 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56515 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab0L3U7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 15:59:00 -0500
Received: by vws16 with SMTP id 16so4545174vws.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 12:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PhJp9pZDCAXll38akxowU0u8j8SUQ8dkJ4BN4ozxxd0=;
        b=eRcPNTx3UUzfDMgskx8NpvY4Awn/ihcEw/cmofO9JOPbrbWVFfX3AeqGAlB1Ge7fCe
         tmbyc87/E1YLSfuWbJj8C1a2LIWkbqsA17ABcZ2AaxSnkl0p/DvZgdZY4H7WR8KCW8+U
         w84YyHiCdkHOIpvgIJp21MYh3/y58gTq/8JtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ASjCzjrKYJh0Ko6m7bWi8JLS++H0fUmZGxgkRBuv5V2qY3FWISkdPUl7Sz2kSYGNM8
         vf2597c+7lIkTrZ8yTyutGrNRHEcvPq2N//wAacj9e9SnRKe2Q7dAdRA9aTnoEvWG4Ce
         psL7CYC6rnWBsUZlzs8oS2l2Al7bGIWxX3z4A=
Received: by 10.220.183.4 with SMTP id ce4mr4893231vcb.132.1293742739256;
        Thu, 30 Dec 2010 12:58:59 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id u4sm3440658vch.12.2010.12.30.12.58.54
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Dec 2010 12:58:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ord3ojb0yy.fsf@livre.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164363>

Alexandre Oliva wrote:

> Now, it looks like I might be able to pull from upstream if I maintain
> manually a graft file that named each upstream commit as an additional
> parent of the corresponding local rebase commit that brought it into my
> rewritten tree.  Workable, maybe, but this wouldn't help third parties
> that used my public repository.

Have you looked into "git replace"?
