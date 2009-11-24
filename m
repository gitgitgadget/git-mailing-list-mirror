From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to suppress progress percentage in git-push
Date: Tue, 24 Nov 2009 09:13:39 +0800
Message-ID: <20091124011339.GA18003@debian.b2j>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
 <alpine.LFD.2.00.0911231043310.2059@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Nov 24 02:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCjzD-0006xt-3w
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 02:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656AbZKXBNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 20:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757648AbZKXBNw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 20:13:52 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:61689 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757613AbZKXBNv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 20:13:51 -0500
Received: by pwi3 with SMTP id 3so3803615pwi.21
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 17:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6hkvJYvEUYC6lV9oYXg6EuJwm+lWGURnCMuK6MIoa0w=;
        b=s+Oi8gHTT9b+kL+/my4jHkj7GU/gy9AajKWdAuTDscy/JS5yyXxlnYeYop0XsE8Npn
         7EQhhdl2IH9Ia0ZKv3v/9UGENjtdgotwyS5m4Q0XshMW6EtmrlM3+mC9xBXJQ+RyEhP1
         yXFjvgQTJ3Pp/ua88kaSW4y1UHKd7xMYVOcvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EBWzKZpHQH4W5nN6b0NodHxTXPMOkH1jF2Ro7g3nKwke4oH4Ujt5Y0+HJai73z9biT
         rplqQc9YVOHdQ4XjhXa4r5+Hs5AaD9WblZEf5lt46vro9pGii7PWZQOqcLCjIheQ2WK/
         mB2vd5WzS5fPa/SxTf/wWfOnrUz7hgsGUhVuY=
Received: by 10.114.83.17 with SMTP id g17mr10730177wab.38.1259025237202;
        Mon, 23 Nov 2009 17:13:57 -0800 (PST)
Received: from localhost (pcd589021.netvigator.com [218.102.121.21])
        by mx.google.com with ESMTPS id 21sm2923102pxi.0.2009.11.23.17.13.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 17:13:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911231043310.2059@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133551>

On Mon, 23 Nov 2009, Nicolas Pitre wrote:
> Then, during the pack-objects process, there are 3 phases: counting 
> objects, compressing objects, and writing objects.  However in the fetch 

during git-gc it shows yet another progress 

Removing duplicate objects: 100% (256/256), done.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
