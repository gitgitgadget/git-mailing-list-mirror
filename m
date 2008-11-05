From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use single implementation of export_ok check.
Date: Wed, 5 Nov 2008 23:41:43 +0100
Message-ID: <200811052341.43746.jnareb@gmail.com>
References: <200811060115.57168.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 23:43:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxr5Z-0003Y8-Qo
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 23:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbYKEWls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 17:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbYKEWls
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 17:41:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:17170 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbYKEWlq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 17:41:46 -0500
Received: by nf-out-0910.google.com with SMTP id d3so152654nfc.21
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 14:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=S84epNOc3eLNwFMzAeGJVGt+uVNobuG7JPBGrzG+cAw=;
        b=jmZQBGNJTCLAyCFJ7is366EOHxPJmnnH/1rsLWfie31O/t8/f/NcjQfcxxMy0u0AE0
         9Dz1PhqFqfqJVIykPUQzkCD8u0GQXGN67nVX94SzPJfBY02ktcyyMY06D//4n3LHb4VH
         WLQCYtVASlm8lD172d0psZ1f8V6SIk9hdYuW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BJWYWJTxc/HySHCEjd8WGiVx5a8R7TGJffnDVL2ju0obRw6/bmbEtBjdDTi7damg1b
         ImTl1QcH7zkP4jaKhuPRtd2nbH7C1K3bg30Ypet/p6VQLFc5eIe68lDnY9DkgJ+iWe8v
         7OeXbpyN9NLxdJgJD17CibIYJs1fJKEA2WYkI=
Received: by 10.210.120.17 with SMTP id s17mr1631806ebc.54.1225924905197;
        Wed, 05 Nov 2008 14:41:45 -0800 (PST)
Received: from ?192.168.1.11? (abwq47.neoplus.adsl.tpnet.pl [83.8.240.47])
        by mx.google.com with ESMTPS id 1sm294464nfv.18.2008.11.05.14.41.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 14:41:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811060115.57168.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100196>

Alexander Gavrilov wrote:

> GitWeb source contains a special function that implements the

s/GitWeb/gitweb/

> export_ok check, but validate_project still uses a separate copy
> of essentially the same code.
> 
> This patch makes it use the dedicated function, thus ensuring
> that all checks are done through a single code path.
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

-- 
Jakub Narebski
Poland
