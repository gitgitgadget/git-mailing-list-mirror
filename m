From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2ter 2/2] gitweb: clean up gitweb_check_feature() calls
Date: Sat, 29 Nov 2008 23:38:27 +0100
Message-ID: <200811292338.28156.jnareb@gmail.com>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com> <7viqq6yxqu.fsf@gitster.siamese.dyndns.org> <200811292337.00380.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 23:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6YTc-0007TQ-Je
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 23:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbYK2Wic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 17:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752873AbYK2Wic
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 17:38:32 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:57953 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbYK2Wib (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 17:38:31 -0500
Received: by ey-out-2122.google.com with SMTP id 6so818047eyi.37
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 14:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=G91OumoGr60CClnm71BFPOV7ktoNiebIbwpVk6xBdlU=;
        b=e08J6OWoqyjsl5Ch1R/dm9tWTrgrkZjVNihWBpt2zEdxwL7Y29q3qm+iaV8QOizsLU
         ZOGqPqnboH5+VuGp6w9eC4J8Y8kJbI5Gfdw5WJnz9b5DY5GUqP0krjS8Hcref6QgGbsR
         CtiXmwj/WD8eZWTzN6bzAYVquii/al7VaMB54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LojFb3Wo6uPxgel/9LZt4I4SCMqFZbSuMwnzo/Wt+1vGL65OV9xcpgbZnjP/QEVaxa
         KxGRlFMBQBQVNSAgeH8xGB+eYsq6d4deCzZ0ux69GjK7k7HHF5F5hO6QToUk+xutU49S
         KEjuYCEwQED83463SSCZ6E/fZ4E39ue3QlvhU=
Received: by 10.210.65.17 with SMTP id n17mr5409554eba.76.1227998310299;
        Sat, 29 Nov 2008 14:38:30 -0800 (PST)
Received: from ?192.168.1.11? (abvs96.neoplus.adsl.tpnet.pl [83.8.216.96])
        by mx.google.com with ESMTPS id 20sm7937374eyk.59.2008.11.29.14.38.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 14:38:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811292337.00380.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101933>

Jakub Narebski wrote:

> 
> Well, I think now that it would be best to split this series into
> _two_ patches: first Junio's patch fixing (!) gitweb_check_feature()
> calls, second original v1 Guiseppe's renaming gitweb_check_feature()
> to gitweb_get_feature(), and adding gitweb_check_feature(), and using
> gitweb_get_feature() only where needed; optionally fixing "style".

It means: first fixup patch, then futureproof patch.

-- 
Jakub Narebski
Poland
