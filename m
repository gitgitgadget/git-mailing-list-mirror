From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: libgit2 status
Date: Thu, 18 Oct 2012 21:42:56 -0300
Message-ID: <CACnwZYe6BZVuqCCPho5+3dy=rzKqDv1A8uGAvhLm2JPO9b2LMw@mail.gmail.com>
References: <87a9xkqtfg.fsf@waller.obbligato.org>
	<5038A148.4020003@op5.se>
	<7vharpv77n.fsf@alter.siamese.dyndns.org>
	<nnglih0jotj.fsf@transit.us.cray.com>
	<7vfw78s1kd.fsf@alter.siamese.dyndns.org>
	<nngsjb8i30w.fsf@transit.us.cray.com>
	<7v6284qfw8.fsf@alter.siamese.dyndns.org>
	<20120827214027.GA511@vidovic>
	<nngr4qqhp7x.fsf@transit.us.cray.com>
	<7vvcg2zwvq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, dag@cray.com,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Andreas Ericsson <ae@op5.se>, greened@obbligato.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 02:43:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TP0gA-0001JP-9a
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 02:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792Ab2JSAm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 20:42:59 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:62446 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab2JSAm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 20:42:58 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so6238239lag.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 17:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gk/u+smWwmaE626J+AcexTxyrUf076e4XAuwP37Uo2c=;
        b=T59SdPJ7MkfId8zinGr4/G8hEzsr+TqM3+B68pN6aL+9vIFF55A9Q3mn0HYiBcDmV2
         uH4Ee1FJpXbIbdXes7qjeF5beVQIXKoImJRYb3TT1daHwVUHWoF3QNQ2ODXPSbP9/K3+
         1nJahgu3nEbb3lLCoGPiP+7lhXWSxcl/ef9cp0fu0VDp9Uv8Ym5caqBP0Yb22DBZC+9U
         nC73junyoQHikWxqzIfl7RD4t15LdYT47nYWTZRvEOFGWyxsafSa72A7mfeHgoJ9Zovt
         PurCsXmMeB06TuTIy8eVmU6ZWToeFRn9nKy4u+v4hdlC0zOPrru4W93XDRaiesEynECD
         kPSw==
Received: by 10.152.148.226 with SMTP id tv2mr19674417lab.34.1350607376261;
 Thu, 18 Oct 2012 17:42:56 -0700 (PDT)
Received: by 10.112.116.35 with HTTP; Thu, 18 Oct 2012 17:42:56 -0700 (PDT)
In-Reply-To: <7vvcg2zwvq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208035>

Just an addendum, the libfication would come from within the core git
developers, i.e, they start making the git library inside git itself.
The git project would provide the API, not an external project.

With some structure like:

include/git.h
src/git.c

...

whatever.

And doing the way Jeff did with argv_array for example and with rigid
style guide defining how new APIs should be written. Just my 2 cents.
Don't take it to seriously.
