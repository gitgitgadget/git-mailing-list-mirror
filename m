From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Fri, 14 May 2010 20:43:30 +0200
Message-ID: <201005142043.31468.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <20100514153636.GB17443@screwed.box> <201005141958.16469.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Fri May 14 20:44:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCzs0-00029J-7N
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 20:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757671Ab0ENSoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 14:44:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:37146 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921Ab0ENSoS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 14:44:18 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1803766fga.1
        for <git@vger.kernel.org>; Fri, 14 May 2010 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DFWE6NYNiVt0qD+Q8Td8EQissNnwfxOxV8DmExWWqpo=;
        b=n24bVn47jM0z855rTlz1QoMoYcTiI8HaWH3k7RkS2QTLVNCwqKChitoz3MsMKpyx8L
         73PHoH9DYqnkwP9jWnTie8PK1JYF/DND3uA9s/Edwb1F7pqgI5cmd0YJwM1HoxC7yOtb
         Llp7JrPturvQswoQZMkKD313n802lbVZiQEYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UpGidzDN2oVunTokjddsnP21haPcr9ywWZpLKQ6FfyGKR7Y1fuqluvju630pHcFims
         GWr3fdX+QHx04wkPJyI2nA+ly8LaOM0Lub1//lwE+/AznDsqFiV4BiYsPeG+q5Nyuc42
         VvxFUJyv/hNtq5YQwAwsgoghCvGcyCTidkmx8=
Received: by 10.87.2.15 with SMTP id e15mr3400499fgi.23.1273862618821;
        Fri, 14 May 2010 11:43:38 -0700 (PDT)
Received: from [192.168.1.13] (abvn155.neoplus.adsl.tpnet.pl [83.8.211.155])
        by mx.google.com with ESMTPS id y15sm3803194fkd.38.2010.05.14.11.43.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 11:43:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201005141958.16469.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147110>

On Fri, 14 May 2010, Jakub Narebski wrote:

> Girocco is shell scripts, not Perl either, see
> http://repo.or.cz/w/girocco.git/tree

I'm sorry, I stand corrected: the CGI scripts in Girocco are in Perl.

-- 
Jakub Narebski
Poland
