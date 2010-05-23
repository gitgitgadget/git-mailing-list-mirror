From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 GSoC] git-instaweb: Configure it to work with new gitweb structure
Date: Sun, 23 May 2010 11:54:59 +0200
Message-ID: <201005231155.00819.jnareb@gmail.com>
References: <1274599968-3749-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Eric Wong <normalperson@yhbt.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun May 23 11:55:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG7tw-00022w-Lo
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 11:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab0EWJzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 05:55:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:7407 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab0EWJzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 05:55:11 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1563757fga.1
        for <git@vger.kernel.org>; Sun, 23 May 2010 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iKxhlqVN58MFU4+nqKyF6OmAT3OKka1tYRpyDMTyodA=;
        b=JNcAuIUw5v8zavfYY4bBdYUwJbKxn7BZXEk5OGAlFDrk9eXTyE5nSkZilfLOUGbQtq
         PXdV800xjQV8kbY9ChdcI3753467HH2BtZhl9CWVAQUJ8LY3ci5Aqxorq38fCPsg+wSx
         nX/fXL3wRWZqBXf9bxCXI0MpmEbnuCRh9iIg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AfSgGDq/JHIlhpv+5nK32GoGp1vJNcP7xmR7Z8hMAOhi05dsYbXUhiphacMLQ8tpFY
         kPfFRhfHNByttK66m8TPT/AILOr8gz55XICjy/SotVThGxWd47Oaqs7UCsUOzPiHJo11
         2Zu1uKEo0+boKmW3JJLij47k9ZBo6in+FDs2M=
Received: by 10.86.124.8 with SMTP id w8mr6541921fgc.8.1274608509729;
        Sun, 23 May 2010 02:55:09 -0700 (PDT)
Received: from [192.168.1.15] (abwr31.neoplus.adsl.tpnet.pl [83.8.241.31])
        by mx.google.com with ESMTPS id b17sm4057257fka.13.2010.05.23.02.55.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 02:55:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1274599968-3749-1-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147567>

On Sun, 23 May 2010, Pavan Kumar Sunkara wrote:

> git-instaweb in its current form (re)creates gitweb.cgi and
> (some of) required static files in $GIT_DIR/gitweb/ directory.
> Splitting gitweb would make it difficult for git-instaweb to
> continue with this method.
> 
> Use the instaweb.gitwebdir config variable to point git-instaweb script
> to a global directory which contains gitweb files as server root
> and the httpd.conf along with server logs and pid go into
> '$(GIT_DIR)/gitweb' directory.
> 
> While at it, change apache2 configuration to use the same access log
> and error log files as the rest of web servers supported by
> git-instaweb.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

For what it is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

But I think more important would be ACK from Eric Wong, author and
maintainer of git-instaweb.  I guess that because it is preparatory
work, only related to the main stated goal of your GSoC 2010, you
don't need "signoff" from mentor(s) (in the form of Mentored-by:)...

-- 
Jakub Narebski
Poland
