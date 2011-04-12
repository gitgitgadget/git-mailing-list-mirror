From: Andres Freund <andres@anarazel.de>
Subject: Re: git-svn dying unceremoniously
Date: Tue, 12 Apr 2011 08:50:46 +0200
Message-ID: <201104120850.47331.andres@anarazel.de>
References: <m2fwpov47e.wl%dave@boostpro.com> <20110412021202.GA17114@elie>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Dave Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 09:01:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9XbE-0000dn-Qj
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 09:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab1DLHBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 03:01:08 -0400
Received: from mail.anarazel.de ([217.115.131.40]:34587 "EHLO mail.anarazel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754215Ab1DLHBH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 03:01:07 -0400
X-Greylist: delayed 613 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Apr 2011 03:01:07 EDT
Received: by mail.anarazel.de (Postfix, from userid 108)
	id 2899644800A; Tue, 12 Apr 2011 08:50:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from anarazel.de (e178250029.adsl.alicedsl.de [85.178.250.29])
	(Authenticated sender: andres@anarazel.de)
	by mail.anarazel.de (Postfix) with ESMTPSA id D784A448004;
	Tue, 12 Apr 2011 08:50:48 +0200 (CEST)
Received: by anarazel.de (Postfix, from userid 1000)
	id B2B4B1C0076; Tue, 12 Apr 2011 08:50:47 +0200 (CEST)
User-Agent: KMail/1.13.5 (Linux/2.6.38-rc7-andres-00142-g212e349; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20110412021202.GA17114@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171374>

Hi,

On Tuesday 12 April 2011 04:12:24 Jonathan Nieder wrote:
> See
> http://thread.gmane.org/gmane.comp.version-control.git/134936/focus=134940
> and the surrounding thread for hints.
I hit that again some days ago and after stracing I started dumping the 
network transfer. For me it looks like the server simply closes the 
connection. Seemingly always directly after a tls key renegotiation... I 
didn't dig further so far.

Andres
