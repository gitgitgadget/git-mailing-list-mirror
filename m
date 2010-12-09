From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t9010 fails when no svn is available
Date: Thu, 9 Dec 2010 14:09:40 +0530
Message-ID: <20101209083938.GC21446@kytes>
References: <7vmxofh1x4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 09:39:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQc1p-0007r0-Tj
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 09:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab0LIIi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 03:38:59 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61755 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab0LIIi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 03:38:59 -0500
Received: by ywl5 with SMTP id 5so1217459ywl.19
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 00:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NpXtYCqkPP/wut0UknuuVQttI9Aajct1sfdDjquYCuA=;
        b=oZBK6lc8mjH0hTMLMWgrpSL5gJ6qnTLxwIaNxdadMX9ZLA2ZGlweygkk8Y5WCvBiJS
         2m1mSQ4bLTC5MzW3S/tH4feLjfMXIxiU42SOWdb02eFYTTLi1qEInfjHWfXsSmcsfn+S
         cw0j5bzXsqn6sn5Ek5soydm4E1FT5auQFEEOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q1E4FVZVGsyPi3HPzXpctUDtOnw3CJCpvQQJfTTu4Gj7ec0IGTCyjvn3FV6Bqdx9HO
         ZFVvvrucrTVvBEZDEAH4GmtBUIx2ahG2d8bevypnW/rt8du8dQUPUJc+E7/JacrglTaF
         AG+PYumwFWAFh7rrxfOTqe5PwdSlhYYPMI5GE=
Received: by 10.146.168.13 with SMTP id q13mr13581903yae.36.1291883938490;
        Thu, 09 Dec 2010 00:38:58 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id i2sm1002150yha.25.2010.12.09.00.38.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 00:38:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vmxofh1x4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163274>

Junio C Hamano writes:
> Running test t9010 without svn currently errors out for no good reason.
> 
> The test uses "svnadmin" without checking if svn is available.  This was a
> regression introduced by b0ad24b (t9010 (svn-fe): Eliminate dependency on
> svn perl bindings, 2010-10-10) when it stopped including ./lib-git-svn.sh
> that had the safety.
> 
> This should fix it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Right. Thanks for catching this.

-- Ram
