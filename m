From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] http-push: update tests
Date: Sat, 17 Jan 2009 22:15:35 +0100
Message-ID: <200901172215.37109.jnareb@gmail.com>
References: <be6fef0d0901161859qbea135bwe89e48caaa69a77c@mail.gmail.com> <m3zlhpy981.fsf@localhost.localdomain> <be6fef0d0901171300t44b60aedm801f6f18d88b654b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ray Chuan" <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 22:17:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOIXR-0002Zi-Cf
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 22:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232AbZAQVPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 16:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756785AbZAQVPl
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 16:15:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:6561 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784AbZAQVPk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 16:15:40 -0500
Received: by ug-out-1314.google.com with SMTP id 39so113674ugf.37
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 13:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=98yGGqZS0ALPr1wN7spsI53kDp2//+QzAZC68sNfcoo=;
        b=jDtmJmpFfL+y9JKqCqsB0zLyvTRdSv6Cltz+hNuP8e6t0mihOzOLmcIsRmU/ZUMgN4
         2vAhswT++VFq54lPtNvPzD898Z1VqNPxM+yO3gRquP/8gnGr28v5fUj4HI2lg5bu8AF7
         oO7uOc88vhOMR0P8P1DbniKVfNRbuEMrmrFjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=moYg5Mvds3TxnLWrdzbm3fHCnsIuBTYTHnAs0IvSpj5kcala3OLnKkCX2OhojZhIqG
         v+7wDHfK0jhvvahTHKyTdQWTrObswCjJnyoxEB4lYikhc3Z8CtKZHa0nLF++DAZ+6g+6
         4b1AWYLyC6YFIGM3ekefTG/AZgF+uPvfKbHMg=
Received: by 10.67.115.3 with SMTP id s3mr908012ugm.0.1232226938826;
        Sat, 17 Jan 2009 13:15:38 -0800 (PST)
Received: from ?192.168.1.11? (abwy228.neoplus.adsl.tpnet.pl [83.8.248.228])
        by mx.google.com with ESMTPS id k1sm5431227ugf.3.2009.01.17.13.15.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Jan 2009 13:15:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <be6fef0d0901171300t44b60aedm801f6f18d88b654b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106106>

Ray Chuan wrote:

> Subject: [PATCH 3/3] http-push: update tests
>
> change tests to expect success.

Minor nit: I would use here

Subject: [PATCH 3/3] http-push: change tests to expect success

-- 
Jakub Narebski
Poland
