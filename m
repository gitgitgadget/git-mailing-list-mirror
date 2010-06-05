From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Resurrecting : git-gui: use textconv filter
Date: Sat, 5 Jun 2010 10:38:21 +0200
Message-ID: <20100605083821.GB1151@localhost>
References: <32937075d59e3275bb0762764a101607@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 05 10:39:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKouk-00008q-HS
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 10:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596Ab0FEIja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 04:39:30 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:28958 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932571Ab0FEIj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 04:39:28 -0400
Received: by ey-out-2122.google.com with SMTP id 25so132328eya.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i99t6BtpBEgzoFCck20W6buD0jAMmmMBjuVzVXPGYPE=;
        b=ZKpFGpygmUCOB//gg6RYgzv1J6Z8l9ux4JelJwRM/0laisMCkWoX586+m+0N+r+G2P
         /rP0DWn3rDA1w1LYI+FHh5QlAtLjLxq+8fvwpItPKE9Y6AwWJ/SHUi8D+IONjh7nrZu+
         1lwJPRLPHKSQUJUnAZNrWakXQS+xvsJoZ49XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=SEPxOk+RE5fd6+OAeKTZUY7SntnkPyYs1aFvqRDQZZOC5c4RxdgTgPlNVOW/ewn6O/
         mRLTEg3Q4D4vzdfmwm3Xa0+fpmb/1c2CSKT3uztSoHt5FnIzQPaVGsKguL/QSL7ED0Zp
         ha0STbuw3n7oe8vqglVeeSkXnv5/RDAvH4RME=
Received: by 10.213.35.18 with SMTP id n18mr6951850ebd.10.1275727166976;
        Sat, 05 Jun 2010 01:39:26 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 16sm1219573ewy.7.2010.06.05.01.39.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 01:39:26 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OKotZ-0000g4-Qs; Sat, 05 Jun 2010 10:38:21 +0200
Content-Disposition: inline
In-Reply-To: <32937075d59e3275bb0762764a101607@ensimag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148461>

On Sat, Jun 05, 2010 at 12:21:35AM +0200, Cl=E9ment Poulain wrote:
> After proposing a patch adding textconv support to "git blame"
> (http://thread.gmane.org/gmane.comp.version-control.git/148310), we a=
re now
> looking to have git-gui use it. Clemens Buchacher (Cc-ed) sent us a p=
atch
> he made a while ago:
> http://thread.gmane.org/gmane.comp.version-control.git/145015.
> There's no answer to the thread, and as a part of our work is based o=
n it,
> we would like it to be submitted to you again.

A month back, Shawn told me he was too busy to work on git-gui. But
you can simply add my patch to your series, and send it all in
together. You should Cc Shawn, since he is the maintainer of
git-gui.

By the way, if you link to a message on the mailing list, it's
useful to provide the Message-ID like this.

 http://mid.gmane.org/20100415193944.GA5848@localhost

That way the message can also be found in other archives. You can
get the Message-ID by appending /raw to the non-threaded message
link.

 http://article.gmane.org/gmane.comp.version-control.git/145015/raw

Regards,
Clemens
