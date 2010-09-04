From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] vcs-svn: Avoid %z in format string
Date: Sat, 4 Sep 2010 17:50:56 +0530
Message-ID: <20100904122053.GC32397@kytes>
References: <1283586214-31204-2-git-send-email-artagnon@gmail.com>
 <1283601539-4477-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 14:23:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orrm3-00013D-45
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 14:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab0IDMXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 08:23:07 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45087 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab0IDMXD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 08:23:03 -0400
Received: by pxi10 with SMTP id 10so434254pxi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Mny0l4a6/dNMHNd9mWQimvRSktZX8DdSLB0f3R0Sebg=;
        b=flA9G5hBlACk9Ucs2p06bbW4ctKGaImXnI0r5I6PEo1VgDHxp6dte9HH+szbMhmJU/
         AJ+ugK46EePn2sINV8Nx7Or1hj5xgOTfITk+qRwEAH+upBMNqfxWym330G+3Phs0ssTL
         R4/M5Di2yysauszHlOh2YtCLJH7yg0Sv4T/7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NP/TATFMmAokpEur0Bf2q18jm3eyHwcShdB+e/7j33fpMqp0mJ0Rf7X5z8ntbVtGpI
         5DRU+/SuBN7ZOaxjkalqQrDRXrxp8mCJtpsrwzcuAVJH7+yMtyGEOAusTgvqKYVEVtcw
         XXNmlghWqKqyUUAT6c1FL2WIrjATfzYZbq3Yo=
Received: by 10.114.112.15 with SMTP id k15mr841171wac.183.1283602983068;
        Sat, 04 Sep 2010 05:23:03 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id r37sm6024776wak.11.2010.09.04.05.22.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 05:23:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283601539-4477-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155321>

Hi David,

David Barr writes:
> In the spirit of v1.6.4-rc0~124 (MinGW: Fix compiler warning in
> merge-recursive, 2009-05-23), use a 64-bit integer instead.

Squashed. Thanks much :)

-- Ram
