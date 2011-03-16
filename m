From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] valgrind: ignore SSE-based strlen invalid reads
Date: Wed, 16 Mar 2011 06:25:47 -0500
Message-ID: <20110316112547.GA15739@elie>
References: <20110316095632.GA8277@elie>
 <1300272453-25891-1-git-send-email-cmn@elego.de>
 <20110316105214.GB8277@elie>
 <1300273819.7214.12.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:25:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzorW-0004zf-96
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab1CPLZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 07:25:54 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35634 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab1CPLZx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 07:25:53 -0400
Received: by mail-gy0-f174.google.com with SMTP id 1so603585gyf.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9RgPUfXC3C/k2OupsTGQGP2OdRmKcJVanWa6/iqgsuE=;
        b=xzz0oDLWsNQzrePj3jr15zGI7eFVirlPmW4SCsjOVN4kKsTzxYS19o8Fku2ePJzqsw
         MCh4MFyH61W7bm1mN+66Xyv9L8PBg4REeMMx5A0AHKw7P0mozgUqxnsm4zZWSwR5nHF9
         yNddITRIvZAvbjoaBFacp850UWulwGna2QJWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=K1rbMF+0nMmfh83mR+cOYQuZV1JdGmVO8SR5DzZOazcaFMrcDyQS1sH6X4+WzYFvFF
         qwAKXcdhPKsmW8221xeMIrKRs3S86Y1hDLIxV11DBfnzhunkSgnbVW7hWkenDnpuIy5R
         1ChGR4ei1ODmXSM/QsSnSti603mhfI1FWCNPY=
Received: by 10.236.125.226 with SMTP id z62mr585722yhh.24.1300274752773;
        Wed, 16 Mar 2011 04:25:52 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id k29sm553862yhk.14.2011.03.16.04.25.51
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 04:25:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300273819.7214.12.camel@bee.lab.cmartin.tk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169139>

Carlos Mart=C3=ADn Nieto wrote:

>  I think 3.6.1 doesn't need it, as Debian's 1:3.5.0+3.6.0svn20100609-=
1
> version is reportedly fixed.

Ah, nice.  A phrase like "some versions of valgrind before 3.6.1"
would be fine with me fwiw. :)

Sorry for the fuss.
Jonathan
