From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Tue, 1 Feb 2011 05:22:02 -0600
Message-ID: <20110201112202.GC10165@elie>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <20110201014807.GA2722@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101312238170.8580@xanadu.home>
 <201102011342.06910.trast@student.ethz.ch>
 <20110201111429.GA10165@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 01 21:21:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkMjE-00066Z-8T
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 21:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab1BAUVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 15:21:25 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:65000 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab1BAUVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 15:21:25 -0500
Received: by wwi17 with SMTP id 17so5203575wwi.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 12:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WSrZjovwOK6hNI8usDYLvAvSRQ87SG4IsF8BlVyD8DM=;
        b=NGJtmfkjA1sUgNTHt0aTO0XdxNLznKOwSQrHb9HsKbfdVLbPttGRoifRzOb0XC2Alj
         SINRjsNtY8M0DEXQvrGDPjVepk3Yl/kS0UXTMvych4x61bKB9QsCP2cc9WblVtUQz7+t
         AZijNpbXf+4oFUkNf8G1Ga/3bB00D4U6qLOuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yFwwHdNNB20TDFvlvIXbRkUEr9Y7RFVUfh6+F3CdvDtboBAYZomj7NGuf6v0bUs0dH
         zodAhxq2NapvKOnitMiwCMeVzScxu4OUQ3xjy47ABzJjuv/C2xJhNi75lA6ClztjdTOt
         wByA+0eK9pMbLcT5c9sDPMsLzvOj7C9ZSMdAM=
Received: by 10.216.169.71 with SMTP id m49mr7943784wel.4.1296591683845;
        Tue, 01 Feb 2011 12:21:23 -0800 (PST)
Received: from elie (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id f52sm11671046wes.35.2011.02.01.12.21.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 12:21:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110201111429.GA10165@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165851>

Jonathan Nieder wrote:

> 	mkdir output
> 	cd output
> 	echo COMPUTE_HEADER_DIRECTORIES=1 >config.mak
> 	make -f ../Makefile GIT_SRC=$(pwd)/../ -j2

Erm, COMPUTE_HEADER_DEPENDENCIES.  Anyway, if someone wants to make
setting GIT_SRC take care of making the directories automatically, I
wouldn't mind. ;-)
