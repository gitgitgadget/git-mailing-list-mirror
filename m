From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-blame.el: does not show one-line summary in echo area
Date: Fri, 4 Feb 2011 11:03:09 +0100
Message-ID: <201102041103.10770.jnareb@gmail.com>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <20110204014315.GB28525@elie> <87tygkm8h7.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Xavier Maillard <zedek@gnu.org>,
	Alexandre Julliard <julliard@winehq.org>,
	Martin Nordholts <enselic@gmail.com>,
	Kevin Ryde <user42@zip.com.au>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	Sergei Organov <osv@javad.com>
To: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 04 11:02:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlIUi-0000bp-Cd
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 11:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014Ab1BDKCS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 05:02:18 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:38425 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab1BDKCR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 05:02:17 -0500
Received: by wwi17 with SMTP id 17so144617wwi.1
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 02:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=OR08+ns2Hh4gvQHk0iEo1xDonczbkj+sexjnhS3/cJY=;
        b=k8jzPVGu7NrO4a+7dd0ueB17dV+HAYCLividgRtMBulCHNFUJTgg7oDOtJ9GsSZu3x
         PNTRP/gFHkwQOG/oVbrk86FImvFqRb+TCIVxu2JWL/Gm0E7gUXXkREoMhT8XWG5mmhVE
         0tzzekIvQO/4zRf94CdJclwfMKfEltpIRJXto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pHPBWqeEki5GGHPgHdNIroFETrYMh2czN1AN8LLCJhpfFr79XwZQnNrPNmBWJ9pozC
         wpPdOJLRsvgqYPnMB9JAC0w/pR0LOjbUro7el5pLstabcA2c5k7x3IqxdMMDeRFe/caI
         R+u+uNxqg5D3H2WysTFP9XaUtMY1hLOR3JHW0=
Received: by 10.216.22.131 with SMTP id t3mr10923324wet.2.1296813736383;
        Fri, 04 Feb 2011 02:02:16 -0800 (PST)
Received: from [192.168.1.13] (abvp12.neoplus.adsl.tpnet.pl [83.8.213.12])
        by mx.google.com with ESMTPS id n11sm262505wej.43.2011.02.04.02.02.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Feb 2011 02:02:14 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87tygkm8h7.fsf@krank.kagedal.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166030>

Dnia pi=C4=85tek 4. lutego 2011 10:53, David K=C3=A5gedal napisa=C5=82:

> 3) Showing when you move to a different blame chunk, by showing a
>    one-line summary in the echo area.

There is even some prior art for this to borrow from, namely cperl-mode
shows information about syntax at given point in echo area (minibuffer
area) after some delay.  Just FYI.
--=20
Jakub Narebski
Poland
