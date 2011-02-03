From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Narrow clone (Re: features from GitSurvey 2010)
Date: Thu, 3 Feb 2011 15:33:15 -0600
Message-ID: <20110203213315.GD16391@elie>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino>
 <201102011451.17456.jnareb@gmail.com>
 <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
 <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com>
 <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com>
 <alpine.LFD.2.00.1102011647000.8580@xanadu.home>
 <FE2BDD68-9CFA-4CBB-9F66-32BE6CF3E174@adacore.com>
 <20110203173835.GC30341@elie>
 <5E0364BF-35CD-4797-BBAF-98A54D1F7F6E@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 22:33:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl6nu-0000sb-Bv
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 22:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab1BCVdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 16:33:21 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41647 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1BCVdV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 16:33:21 -0500
Received: by vxb37 with SMTP id 37so468142vxb.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 13:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2iJ0PdA9yVEZ20pHLvRm62iZwTFZI3bmeVs0jbN2qAE=;
        b=xErRq84xznxuhZoEi488ycTgaCAzhpDXlce5qXkNOjFGwIK/l+NbCmEvo1eAlGyU3Y
         AT/tku6kS2ZhaE365sZp6XGYrtk66Pl+O8kYQlhYquTf9dfzQDEgPZZQI43MhjZm8OhC
         BOuTVWp2XcFAjbzbi1nnytPvRJ4BfejqF7ANI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JmE/3DHfCypefifl47OaRgjuPg9ozUXsPkwysaAQDhBxeIuP5o4jYZ8LSZoxHJi2mQ
         TOY5bm2HL+ZP5da5qpWalqxAwGK6KTRaGx5NUQNrQUfnlFcNvHYijeNeqU3NCcQCPuPO
         U2ZhtJqZ5Va3AIs3i9x27i07TPxk8yVHDGTnc=
Received: by 10.220.202.73 with SMTP id fd9mr2936359vcb.8.1296768800299;
        Thu, 03 Feb 2011 13:33:20 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id c4sm549945vcc.6.2011.02.03.13.33.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Feb 2011 13:33:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5E0364BF-35CD-4797-BBAF-98A54D1F7F6E@adacore.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166000>

Geert Bosch wrote:

>                                           Some would rather
> spend 30+ days of CPU time to import an entire SVN repository with
> branch forests straight into git than considering organization.
> Of course the resulting git repository will be less than useful.
> And that's where the narrow clone comes in handy...

Right, narrow clone gives them an excuse to do it.  Ergo we should
not have narrow clone. ;-)
