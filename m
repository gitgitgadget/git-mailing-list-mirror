From: Johan Herland <johan@herland.net>
Subject: Re: error: cannot lock ref 'refs/remotes/origin/*'
Date: Tue, 17 Jun 2008 16:29:06 +0200
Message-ID: <200806171629.06570.johan@herland.net>
References: <1213635227.17814.6.camel@localhost> <alpine.DEB.1.00.0806171140470.6439@racer> <1213712520.6400.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Bock <nbock@lanl.gov>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 16:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8cCP-0002G1-Ue
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 16:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068AbYFQO3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 10:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756098AbYFQO3X
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 10:29:23 -0400
Received: from sam.opera.com ([213.236.208.81]:50995 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754986AbYFQO3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 10:29:22 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m5HET6c1014767
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 17 Jun 2008 14:29:12 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <1213712520.6400.1.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85304>

On Tuesday 17 June 2008, Nicolas Bock wrote:
> This is what I get:
>
> $ git show-ref
> a4995ae293fd95697a643cd3ea45585ecc38a19d refs/heads/ACT
> 3378ccb42c22740b7fcc240ffa0e4f798b8acf1f refs/heads/master
> 78e33155a0ab4ab0acba4c64758681fe99f1c5ca refs/heads/nick
> ef66b3aa74b8c1edb55161e01a99dee7cf9edaa3 refs/remotes/origin/*
> 3378ccb42c22740b7fcc240ffa0e4f798b8acf1f refs/remotes/origin/master
>
> in what sense is this ref "bogus"? Is it syntactically incorrect?

Yes, According to "man git-check-ref-format", asterisk is NOT allowed in 
a ref name.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
