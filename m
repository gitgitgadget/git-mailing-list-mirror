From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Fri, 21 Dec 2007 10:47:45 +0000
Message-ID: <57518fd10712210247s2fcbbf61ke67bbdc0f5ffe70b@mail.gmail.com>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
	 <20071219184457.GC3015@steel.home>
	 <57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>
	 <4769A7FB.1070904@lsrfire.ath.cx>
	 <57518fd10712200244o656c7f44j426cc71c89515de3@mail.gmail.com>
	 <476A5DFF.40803@lsrfire.ath.cx>
	 <57518fd10712200508x4b15f9acy10aed83a3cebeba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 11:48:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5fQI-0000S4-HO
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 11:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbXLUKrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Dec 2007 05:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbXLUKrr
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 05:47:47 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:23863 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbXLUKrq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2007 05:47:46 -0500
Received: by rv-out-0910.google.com with SMTP id k20so290135rvb.1
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 02:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=ghAAsccEccibdFhlB0wUGsStR/7pF9syY3Av9MegJ94=;
        b=JTZN4NKqxfHPJ0xQRIYmA8ZFslzBvJasFD075yMgIBSgrHcKyuY/QiQt8nK1CHBZ8XxQFf0iDInVx1YICzGANZSmgHpzyjgqfzOw4MxaThbkDwX2oD+Zi6whCJ5lovFA+ej0tZjRskXSjFahCmIFIhI3cUkITW2zu8duVkT+0u4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=rr4IQXtubO5rRDrIVO1p1VvLyFzLQCu3sU5MLhtSVGV9gVLLTVD2Q4XbReAiPCzC5xmUeQyuuYWGpU70FdD0gIoZ2WMQvV101QGnwl+DFI4goaDPoaBN0rqXpr34VcgCHL06vO50Y1AZj4z8ZMBIuU6AopFJSkMLcWjBoRONc94=
Received: by 10.140.207.2 with SMTP id e2mr616619rvg.271.1198234065600;
        Fri, 21 Dec 2007 02:47:45 -0800 (PST)
Received: by 10.140.134.14 with HTTP; Fri, 21 Dec 2007 02:47:45 -0800 (PST)
In-Reply-To: <57518fd10712200508x4b15f9acy10aed83a3cebeba@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: c0df46aa5c6a9ef9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69054>

Has anyone actually managed to reproduce my problem?  I've got
multiple repos here that show the problem in several commits, made by
different people.  However, I can't actually come up with a way to
reproduce it at will...

I'd really like to see Ren=E9's patch accepted as it seems to magically
fix all my problems, but it's a bit hard to justify if I'm the only
one that's seeing these broken commit messages.
