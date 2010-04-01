From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 5/6] gitweb: add documentation to INSTALL regarding gitweb.js
Date: Thu, 1 Apr 2010 13:46:53 +0200
Message-ID: <201004011346.54530.jnareb@gmail.com>
References: <4BB430FD.3050306@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Apr 01 13:47:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxIrj-00049R-Rc
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 13:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611Ab0DALrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 07:47:09 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:10158 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549Ab0DALrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 07:47:05 -0400
Received: by qw-out-2122.google.com with SMTP id 8so351504qwh.37
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NApzQ974qOddq06vpmuv6xsUOKcEUM3VZ74B/0/z+4Y=;
        b=DdosuBnAJZlCtCWpxB7Z3eas4Nte8lMWFMc2wOq+k7Qc7r9yG9D6ABsnsb4KVLfk/p
         EvOMu1JktUKI4DE4y64+3SI7qhgtRDYGhrrbDRdAPq8DH2U0DTdyJjgdCgldlt2JmO8M
         ShBqtcqNA66YMONMhkgnfsUOIG5NbPuHTYRLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sYYDwviZTOJG8y7gw4TKAt/qcWsfM7FUcYNhCxYg6ZrOer6+LReAh12Y+ecS5M1ABO
         iijahlbiAIgbnpNSru+Vj5D8mZ/xZM0FM7RLXANlQwUiPUMDFS9uZma4+lYDN0Jo+bs2
         a0bDuqTvNtxfOIeLhcpW6on7YLtp2BzZnd4GE=
Received: by 10.229.217.130 with SMTP id hm2mr1151711qcb.59.1270122424750;
        Thu, 01 Apr 2010 04:47:04 -0700 (PDT)
Received: from [192.168.1.13] ([72.14.241.40])
        by mx.google.com with ESMTPS id 20sm3973201qyk.12.2010.04.01.04.47.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Apr 2010 04:47:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BB430FD.3050306@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143726>

On Thu, 1 Apr 2010, Mark Rada wrote:

> This patch updates gitweb/INSTALL to mention gitweb.js, including
> JavaScript minification support.
> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>

Thanks for this writeup.

For what it is worth:
Acked-by: Jakub Narebski <jnareb@gmail.com>
 
> ---
> 
> Changes since v4:
> 	- Compacted the point about minification into CSS
> 	  point about minification

Nice to have differences from previous version described in 
comments...

> 
>  gitweb/INSTALL |   23 +++++++++++++----------
>  1 files changed, 13 insertions(+), 10 deletions(-)

This change migh have been a bit smaller without accompanying
rewrapping of affected paragraphs, but on the other hand it would
leave gitweb/INSTALL less readable.
 

> @@ -79,13 +81,14 @@ Build example
>    we want to display are under /home/local/scm, you can do
>  
>  	make GITWEB_PROJECTROOT="/home/local/scm" \
> +             GITWEB_JS="/gitweb/gitweb.js" \

Minor nit: other lines use TAB + 5 x SPACE, so it should read:

  +	     GITWEB_JS="/gitweb/gitweb.js" \

   -----^^^^^

>  	     GITWEB_CSS="/gitweb/gitweb.css" \
>  	     GITWEB_LOGO="/gitweb/git-logo.png" \
>  	     GITWEB_FAVICON="/gitweb/git-favicon.png" \
>  	     bindir=/usr/local/bin \
>  	     gitweb/gitweb.cgi

-- 
Jakub Narebski
Poland
