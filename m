From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 GSoC] git-instaweb: Configure it to work with new gitweb structure
Date: Tue, 25 May 2010 03:34:19 +0200
Message-ID: <201005250334.21138.jnareb@gmail.com>
References: <1274599968-3749-1-git-send-email-pavan.sss1991@gmail.com> <201005241155.30653.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>, Petr Baudis <pasky@suse.cz>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 25 03:32:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGj0S-0002bB-Db
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 03:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757245Ab0EYBc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 21:32:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63959 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab0EYBc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 21:32:26 -0400
Received: by fxm5 with SMTP id 5so2792882fxm.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TOBmCuXXsNHQDC6kljcsfwdcTXLeV4yl3PpKGKGhaJg=;
        b=sLd/xBr+5vu1zu4WoN32mSDXmy+fBJrQfYezpgkOAHByHbgTKDW47VYxjMKQJhZSW6
         yQxwc9DF5h4qSi5ZPjVvum0xqdfamskH7DDThATzP1mrrYqveLCATagtV7BWeBfm/9r+
         KVX8r7Z3f/jid2yHzTB2RdwdxfVZ23QdzDuwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VU6/lMmzWDDRKpnKI1MzIpsXNojwIoWDL7v/qDT0+SntYQMZGc4G45LP8ctvEe+tsZ
         Ov6ccGqN/Od9pmXtq/VaJulaN9Un3qpB5y6TpbU+tAcxgVeKZNUFUbk/8r4hbTLE9qZa
         eVPDkkJZxKAgqjzvCb9s7E6hnBC9wSo0m4xSM=
Received: by 10.223.56.206 with SMTP id z14mr5309986fag.97.1274751144923;
        Mon, 24 May 2010 18:32:24 -0700 (PDT)
Received: from [192.168.1.15] (abvf124.neoplus.adsl.tpnet.pl [83.8.203.124])
        by mx.google.com with ESMTPS id 2sm22271850fav.1.2010.05.24.18.32.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 18:32:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201005241155.30653.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147656>

On Mon, 24 May 2010, Christian Couder wrote:

> And I think that it would be better if the web server logs would be in a 
> directory with the web server name. For example 
> "$fqgitdir/gitweb/$httpd/access.log" instead of "$fqgitdir/gitweb/access.log". 
> But it would be nice if you make these changes (as well as the apache2 
> configuration changes) in another patch.

You probably meant "$fqgitdir/gitweb/$httpd_only/access.log", and not
"$fqgitdir/gitweb/$httpd/access.log" ($httpd_only in place of $httpd),
because $httpd might be 'apache2 -f' in the case of 'apache2', or in
the future "$fqgitdir/gitweb/gitweb.psgi" in the case of 'plackup'.

Just FYI
-- 
Jakub Narebski
Poland
