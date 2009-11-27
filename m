From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC 2/2] Makefile: automatically compute header 
	dependencies
Date: Fri, 27 Nov 2009 23:57:01 +0100
Message-ID: <fabb9a1e0911271457k31d8addcwbbc8fd34f9aedd8c@mail.gmail.com>
References: <4B0F8825.3040107@viscovery.net> <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302> 
	<20091127174558.GA3461@progeny.tock> <20091127175043.GC3461@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 00:04:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE9ri-0007FB-UA
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 00:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbZK0XE1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 18:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbZK0XE0
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 18:04:26 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:41685 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZK0XE0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 18:04:26 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2009 18:04:26 EST
Received: by vws35 with SMTP id 35so532381vws.4
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 15:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CAKFguSp7ADYA8yNGjygnWjMWdDpEi4t71WXIiisBdE=;
        b=I33vb1iC2lFybnyt0IzbQ/95T0XLCONWwFTYlSWR4gSBLqbBwhlGDPOsUQc4CDwZn8
         vlIYl8aNkfJh5qbKDiN1ktnb8qz90X5JihCZP2wJPSXjpNL9cGcEy6Pee6JJKdc2VqIW
         SF+Lht5sHv83ILwUaJ6TL2bwsNzIccnRh+I/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZcMSW6P/E/oLJJdhWflLMm94TBhNtuA0XqGRJxdYTBeAxVKsiwxDFdDZsZD4307l2p
         jZN9fDyCA3GGLCYZ3noM8/oBl9lcDr+R1cwTQio513St0QGizMveckmjyx6xs2P+hrCN
         Jh8YYEwJMv622tBQcuMNA1l6BRl9McsLcB/9w=
Received: by 10.220.121.144 with SMTP id h16mr1822353vcr.113.1259362641098; 
	Fri, 27 Nov 2009 14:57:21 -0800 (PST)
In-Reply-To: <20091127175043.GC3461@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133942>

Heya,

On Fri, Nov 27, 2009 at 18:50, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Good idea? =A0Bad idea?

Ugh, git/git is already a horror to 'ls', adding another n files...
:(. Which brings me back to "if only git had a seperate src/ and maybe
/build directories" :P.


--=20
Cheers,

Sverre Rabbelier
