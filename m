From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a 
	foreign vcs
Date: Wed, 5 Aug 2009 15:15:11 -0700
Message-ID: <fabb9a1e0908051515n7d6cb59ak1be175359df7c3bc@mail.gmail.com>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org> 
	<alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org> 
	<alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de> <fabb9a1e0908051446t63942d21nf71ee0673bb85b8c@mail.gmail.com> 
	<alpine.DEB.1.00.0908052349250.8306@pacific.mpi-cbg.de> <fabb9a1e0908051453y3bb4b2fax2ab17608436510ca@mail.gmail.com> 
	<alpine.DEB.1.00.0908060004300.8306@pacific.mpi-cbg.de> <fabb9a1e0908051505h671ece4ekef8bb887865a8488@mail.gmail.com> 
	<alpine.DEB.1.00.0908060012050.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 00:15:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYolo-0001fJ-NQ
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 00:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbZHEWPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 18:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbZHEWPc
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 18:15:32 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:47335 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbZHEWPb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 18:15:31 -0400
Received: by ey-out-2122.google.com with SMTP id 9so245399eyd.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NtUb76YMEpgY9DF79uL1q1e/UFGk41CkW4tpxuwrZJA=;
        b=A2ZzHG0EXNXZu+brawfecyzgVuFX/DoTwLjC12T8c7V8SG+wd9wq04JKfoh3KKjlXf
         gozlIBaCTPMIiPdkRmA+A+Wlsv68qkJB+woP86xuWIbRc6X3zs7iZf+AvTWiXQVEQbga
         c+edR30mX2M8BP+l8mQkTlg1ZRMPaUkUmfYAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gjKCZla7nmA67eYLYgBPE06a43wNkySbCr/5pFxuPxEsGfED4By6N31+YUJsnNYews
         BLxOzl2TDD4YCEWeXGPA+m9OhDt8e+kDPqOia9Cw3m3gTIRhcOzCCdZQEDgAYW5pPdXS
         mN9ChtzzUjhSdtvA23HPmE5umSc0I5SB6hXCA=
Received: by 10.216.88.71 with SMTP id z49mr22153wee.90.1249510531326; Wed, 05 
	Aug 2009 15:15:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908060012050.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125011>

Heya,

On Wed, Aug 5, 2009 at 15:12, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> No sarcasm needed: the URL svn:http://sverre.ismy.he.ro/ is handled by the
> helper git-remote-svn (not git-remote-svn:http).

Hehe. So how would we store a svn repository at "svn+ssh://something"?

svn:svn+ssh://something ?

-- 
Cheers,

Sverre Rabbelier
