From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/WIP] Starting work on a man page for /etc/gitweb.conf
Date: Thu, 12 May 2011 20:17:51 +0200
Message-ID: <201105122017.52373.jnareb@gmail.com>
References: <1305141664.30104.11.camel@drew-northup.unet.maine.edu> <201105121701.26547.jnareb@gmail.com> <4DCC17BE.7000005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 20:17:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKaSU-0000Nt-LZ
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 20:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575Ab1ELSRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 14:17:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37538 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab1ELSRw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 14:17:52 -0400
Received: by fxm17 with SMTP id 17so1271350fxm.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=DfnLNC0dTZc6ILz9N737zOqruib6DJ1597Vz9k/gMCE=;
        b=M2+Ve9/Ge3s4i2eoY4RAJeedwL7vr9aqoQX167vKpEVMIH8GuAQMsC0Er3DdSOkic/
         WV30axaFdj6QIh4H48tnFajh6mIbaMBJsQ0qYrblJ0v3npoJJhgc4HaxyiXXiNgWoBjJ
         cbpoNhVWKJnVn+NIUkohUV8cZUH0wnHKIvUfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=x0ib/iCCBR3F8YKy5VCum3oB8b2ScGCuHw2nNvmetakFP1kk+z2nNJKoDb/+Qn3drF
         Zyo6XHreM5TRCAFu7b09jH58NynLupI8NcTmzUg4NtwNzNNAgpMXNeYA+1qZavawKH4O
         SavjkMqeQ1Ri1GQ9wMLtWRgwRKvJ2TwJGwFmo=
Received: by 10.223.77.92 with SMTP id f28mr619259fak.37.1305224271786;
        Thu, 12 May 2011 11:17:51 -0700 (PDT)
Received: from [192.168.1.13] (abvl88.neoplus.adsl.tpnet.pl [83.8.209.88])
        by mx.google.com with ESMTPS id t15sm567172fau.24.2011.05.12.11.17.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 May 2011 11:17:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DCC17BE.7000005@kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173491>

On Thu, 12 May 2011, J.H. wrote:

> Beyond that I've no real issue that haven't already been brought up, but
> I do want to make sure that the ultimate plan here is to add the scripts
> that generate this vs. the final output, right?  I mean we already have
> 2 places this documentation lives (in gitweb.perl and README), I'm not
> sure we need a 3rd place to update the documentation at by hand.  Just
> asking.

I think the ultimate goal is to move _documentation_ out of gitweb/README
(and some from gitweb/INSTALL) to gitweb.txt (or gitweb.pod) and
gitweb.conf.txt manpages... so that gitweb/README would be of size of
other README's (with sole exception of t/README, which is special case),
i.e. up to around 2,300 lines, and not 23,000 lines (10 times more).

-- 
Jakub Narebski
Poland
