From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Thu, 19 Jul 2007 09:30:56 +0200
Message-ID: <200707190930.57019.jnareb@gmail.com>
References: <571532.59758.qm@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matt McCutchen <hashproduct@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Thu Jul 19 09:25:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBQNm-0007d0-In
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 09:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933326AbXGSHYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 03:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762371AbXGSHYY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 03:24:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:41215 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757591AbXGSHYX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 03:24:23 -0400
Received: by ug-out-1314.google.com with SMTP id j3so357228ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 00:24:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R59yX08HSeyMqG+hyBqmBry807VOn3Cxq6hfUTWc/MZRCGq9yBNvWDo0QuoCpNcE2ZT1tLq7IGnyK7BVf31Tb6kHD5XuhHHk81/dys1tnwydhIrP69sACS0rzDt1ljlw/N6SW1tAdAKcee+u4conXAXZOFm6jFyVd0z2OFa8BQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hsW3Fu0iZIbUM+DB8u+Sb47P82rDdTggIw7cmoDDdC3bqZE3J4uLigVnttWZfY0I0OAs2DWHYOeJaHAxJPr2QMUmZ40hMmupvgGNc06Cw5Yo20O37oiBh+p1faxFPoVjvDYOxpm7OsLdUKivT9Dp3LNoHOjVCJ0XVH2hGIiggXA=
Received: by 10.86.74.15 with SMTP id w15mr1704334fga.1184829861509;
        Thu, 19 Jul 2007 00:24:21 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id p38sm3708948fke.2007.07.19.00.24.19
        (version=SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 00:24:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <571532.59758.qm@web31813.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52948>

Luben Tuikov wrote:

> I wouldn't mind an improvement in the snapshot area of gitweb.
> I wasn't really happy with the snapshot feature as it was originally
> implemented, as it would generate a tar file with ".tar.bz2"
> name extension, but the file was NOT bz2, and I had to always
> manually rename, bz2, and rename back.

This was a *bug*, but it is now corrected (in 9aa17573). Gitweb used 
Content-Encoding, which is meant for _transparent_ compression.

-- 
Jakub Narebski
Poland
