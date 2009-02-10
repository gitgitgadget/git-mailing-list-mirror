From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: RFH: spawning pager takes long time when when unconnected from 
	network
Date: Tue, 10 Feb 2009 11:34:47 -0500
Message-ID: <76718490902100834j7f1f61aaibdefe8416091b3fb@mail.gmail.com>
References: <loom.20090210T015515-886@post.gmane.org>
	 <4991337B.2010102@viscovery.net>
	 <loom.20090210T085859-630@post.gmane.org>
	 <alpine.DEB.1.00.0902101124160.10279@pacific.mpi-cbg.de>
	 <279b37b20902100253v3cfd8e45kefa6da7de2ea4a4b@mail.gmail.com>
	 <20090210110729.GC12089@coredump.intra.peff.net>
	 <279b37b20902100355r44985270x50ff8cb8a072868d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible+git@gmail.com>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:36:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWvaq-0002xo-Dj
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbZBJQeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 11:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbZBJQet
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 11:34:49 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:40637 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbZBJQet (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 11:34:49 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2341100rvb.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X6s0DV9zWLdPAmu22L5Vu3XBv8jtywzYYJKwjuypbcQ=;
        b=UglAMhjFX5DhcLIFYzSUZiYRBWVIsXsMwc5Hk702ueB8X+oxol94rv8i+QtHPUPPEA
         9Z8MYS00sDpGqK98opDXWSsaiNLeGqIZ/NbLSBQq9qM3ZmvafsJ0bdOCltq2+itJWUOW
         a1UVqG9Ub9EtvhnVaB0FneHsn1DIOt8j9LZX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SroiEq8DprISMvbXbT0Pw/lQ8sHqLtVGdiJiofukXJlPBLKnDwD9KZqy++OPl+LFg2
         AmwtIe9P1c6Il+MhzpQhR2AA0K+320XLQs086nxS7+YSDOB76n5rPDVsAAFZ4yYg0O9S
         dQVBd1wAPFDboeOSvmvuyRZ3DDSz9AeAiOIJU=
Received: by 10.140.144.1 with SMTP id r1mr4745036rvd.271.1234283687824; Tue, 
	10 Feb 2009 08:34:47 -0800 (PST)
In-Reply-To: <279b37b20902100355r44985270x50ff8cb8a072868d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109267>

On Tue, Feb 10, 2009 at 6:55 AM, Eric Raible <raible@gmail.com> wrote:
> My shell is the standard vanilla msysgit shell, with no customizations.
> It does of course seem that something is touching the network, but I
> have no idea what that might be.  Nothing in my path, that's for sure.

If you plug into the network, but statically assign yourself a bogus
IP so that you don't get anywhere, does the same thing happen? If so,
then perhaps you can sniff your network interface to see what the
traffic is.

j.
