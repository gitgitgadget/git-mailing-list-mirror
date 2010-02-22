From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Disable OpenSSL SHA1 implementation by default
Date: Mon, 22 Feb 2010 05:55:21 -0600
Message-ID: <20100222115521.GA3849@progeny.tock>
References: <20100222110814.GA3247@progeny.tock>
 <20100222112326.GA21929@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Robert Shearman <robertshearman@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 14:28:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjWsl-0003nV-6M
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 12:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab0BVLzQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 06:55:16 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43759 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab0BVLzP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 06:55:15 -0500
Received: by gwj19 with SMTP id 19so24446gwj.19
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 03:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wTa7IKd0HFhO4LihrDx7l30cv1bDFNHrovoZIv5HAiw=;
        b=Z7x5UV/NXndAid/WB/O4+u1a1HxCBGhfEqGhgy8gvJQhn0BX+pBQo21E0uZ0PLACTX
         ChLlsfK+DimNjo7hETkLWgsy7tHYeUfImKCBPcc9SI52E1NvaXY1L4+SyS80qpmgtyuL
         VwUZpOl9+bp55f72Dxmcc1i2vRFfjfXjHS+PA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wYqPFfTUNcMfEc7Y/7nSXfCfqF0vvjV/MtXNP9TNYd+gDdnq9EtXlcsYQcAXRV/4Nq
         BdHfhrUb/L+QVzV1S2Lr4/DBLCSXWej+YwJamc7cBkRIdsJ9joJKA+WTVM4NnBynH9kG
         RfUbuS651OR6lD95Cx4Lu9FQeq+k0KXCvB/Oo=
Received: by 10.101.40.1 with SMTP id s1mr5510549anj.222.1266839714661;
        Mon, 22 Feb 2010 03:55:14 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm3290289gxk.10.2010.02.22.03.55.13
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 03:55:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100222112326.GA21929@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140677>

Jeff King wrote:

> What is your definition of "about as fast"? I benchmarked up to a 20%
> slow-down a while back:
>=20
>   http://article.gmane.org/gmane.comp.version-control.git/126995

Thanks for the pointer --- I had missed that.  I=E2=80=99ll run some nu=
mbers
and I=E2=80=99d be glad to see other people=E2=80=99s too (for whatever=
 workloads are
most interesting).  But anyway, I think we should table this patch,
and I=E2=80=99ll write another one that just splits NO_OPENSSL in two w=
ithout
changing any defaults.

Jonathan
