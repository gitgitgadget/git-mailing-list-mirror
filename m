From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH updated] git wrapper: DWIM mistyped commands
Date: Sat, 30 Aug 2008 12:12:47 +0200
Message-ID: <81b0412b0808300312h53605ac8p2d60784ca2178a0@mail.gmail.com>
References: <20080828171533.GA6024@blimp.local>
	 <20080828212722.GF6439@steel.home>
	 <237967ef0808290758p2bd1de55idcb9ad9150389b2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 12:14:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZNSs-0005sv-23
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 12:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbYH3KMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 06:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbYH3KMs
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 06:12:48 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:54597 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbYH3KMs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 06:12:48 -0400
Received: by wa-out-1112.google.com with SMTP id j37so712758waf.23
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 03:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VEOs+n39X7zkCZTDLOhqEDDct2ibYW8mjH6mM2xaMPY=;
        b=SfBUS8I0RvjW0BKuwd9FL096/GaryMSNy0bBfJ17B6rBcagPymUs71SgiR2JuSJ01d
         ik9oOT0/z1VeEgXedzPD/BEfSO+FXFeh7SXqTxaqil75pQNDPEa+hs/YODPDNZ9n2don
         uQQ7CHxmnvHkeXm80jzelAu6u4IaRm5FMKjIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jCscRS61036YHj2N3bo1Wi/DYTlmAaB1slCkkQhWhlhR9DVEa8c30NIKL2URhAIs0W
         w/HvXDPIirGy+EeHUpCTfotedshi2mxBB46sGvnbobbNASXjkgNaWJd/hnoh1awNz5Wo
         OdhlrAg548OsixfMhWoxJND9QpmPPUn9bA1EE=
Received: by 10.114.53.1 with SMTP id b1mr3569881waa.53.1220091167418;
        Sat, 30 Aug 2008 03:12:47 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Sat, 30 Aug 2008 03:12:47 -0700 (PDT)
In-Reply-To: <237967ef0808290758p2bd1de55idcb9ad9150389b2b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94372>

2008/8/29 Mikael Magnusson <mikachu@gmail.com>:
> I merged the branch in pu into next, which I think should work, but I get
> these segfaults for some commands... I tried running in gdb but even with

Can't reproduce in master, will try with next later, am busy right now, sorry.

> -g3 I only get nonsense backtraces, not sure why.

Remove -O2 from CFLAGS:

  $ make CFLAGS="-O0 -ggdb"
