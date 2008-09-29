From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: remove PATH_INFO from $my_url and $my_uri
Date: Mon, 29 Sep 2008 15:39:08 +0200
Message-ID: <200809291539.09467.jnareb@gmail.com>
References: <1222693662-27426-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 15:40:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkIzJ-0005Il-0G
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 15:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYI2NjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 09:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbYI2NjQ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 09:39:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:46651 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbYI2NjP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 09:39:15 -0400
Received: by nf-out-0910.google.com with SMTP id d3so649040nfc.21
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DWrcl1hM3OOMn/v1dYymVkTCTtCMG2rgHma+AlfH4Y8=;
        b=Qa26Cgegb1z0fbdTAhc2JrEIftX+4DVnxFWCABtfM11PoPgIzrAmfhb3oMd1rK7TyE
         J25ntqTxmPZ2zcPSqwmLD11CxcCBNppTkxbXv/t+TDtcml8Naec7+Dd8mO74CyQvfPQc
         +ZNr2zFjOJdNLLDwVe9krJ5aargzG67zhYfv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PO7KkLWVi/nELE4ZnZCmF8Ygaq3/ITrRiI7IpouG/VK1FcH4isZcY3AufJZUmZgqZe
         LVLnK5tHuzg87icxzhzZOTB8SWJ2Zd4Tuki9iDXy49c9+VsnGUfCsGAIOJE/bmKai7o9
         HdC9o5t1CcHHmMU2hdKXPHHhD74Y7AcJYAVy4=
Received: by 10.103.2.14 with SMTP id e14mr3703884mui.104.1222695553294;
        Mon, 29 Sep 2008 06:39:13 -0700 (PDT)
Received: from ?192.168.1.11? (abvx193.neoplus.adsl.tpnet.pl [83.8.221.193])
        by mx.google.com with ESMTPS id t10sm473982muh.16.2008.09.29.06.39.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 06:39:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222693662-27426-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97010>

Giuseppe Bilotta wrote:

> This patch fixes PATH_INFO handling by removing the relevant part from
> $my_url and $my_uri, thus making it unnecessary to specify them by hand
> in the gitweb configuration.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

-- 
Jakub Narebski
Poland
