From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit-tree: simplify parsing of option -S using
 skip_prefix()
Date: Tue, 23 Dec 2014 18:06:13 -0800
Message-ID: <20141224020613.GB29365@google.com>
References: <549A0643.8090202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 24 03:06:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3bLC-0002L2-5J
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 03:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbaLXCGR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2014 21:06:17 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:46221 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaLXCGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 21:06:17 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so6770777iga.9
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 18:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qdgj/OyxCR8s5DS/sQ/+I7vLCIluPe5QiefYYv1xMqo=;
        b=XA2aoGoyn80gyYA5p4IdNpqBCih2hk2PWGFj0ozfSgjOLB5rXVLPiMHDygcssTlwft
         3/4UhOlT965FIGjZApepD9hOiJ3qDTr1qVUrVHe9Vgu6aSbxS5dugMp4EbFIQb4bcVsB
         dCRkUQIQ3GZAnagXy5YGLAPleYJ+UTcwEcjhU0lRNcnBXFbDgUzl1KhIhVkD/IuVblDb
         azfrAfZWv24AF8dvi7uso2Eo/TTKQUp2gPNQky8S26ulHgqy4n6j61mcYZW0f6V3SX8x
         +fJVUctEYZ8Qbk19MHbNGvCCiDOqdy3u3vC1rPia5tjERWiOrLjmPh7wMHG1gUPQtTMB
         3IrQ==
X-Received: by 10.107.156.67 with SMTP id f64mr29428237ioe.9.1419386776458;
        Tue, 23 Dec 2014 18:06:16 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f575:2fb0:789a:eca0])
        by mx.google.com with ESMTPSA id q196sm10720578ioe.5.2014.12.23.18.06.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Dec 2014 18:06:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <549A0643.8090202@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261787>

Ren=E9 Scharfe wrote:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/commit-tree.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
