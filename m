From: Olaf Hering <olaf@aepfle.de>
Subject: Re: implement a stable 'Last updated' in Documentation
Date: Tue, 10 Feb 2015 16:17:47 +0100
Message-ID: <20150210151747.GA8965@aepfle.de>
References: <20150126172409.GA15204@aepfle.de>
 <xmqqd25zkeg7.fsf@gitster.dls.corp.google.com>
 <20150128080214.GA18851@aepfle.de>
 <xmqqbnlif6t9.fsf@gitster.dls.corp.google.com>
 <54CB5770.8030503@drmicha.warpmail.net>
 <20150130150758.GA3683@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 16:17:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLCZb-0008EE-E7
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 16:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbbBJPRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 10:17:54 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:35662 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbBJPRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 10:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1423581469; l=644;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=cGEPVyqsiRqr0KBAhqe3dmDcGk3a8tjPb4nAGqJiRqs=;
	b=VI3bAjIiIewxOqffAZsvTehjZCIA6H7Q2VDyOaO+yoEHMqOMBegfqxGTGZ9+kSgcLDD
	8dmicDLNrE4gyZExpw6HJZ3mEIRL5xg0Qc3Hg7a7d6B0AmwzcPca7e162+DdMzaf4iaAm
	FJyiqO8gtE+JafA7cg39ILfVFyB+f24SafQ=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIlSQZelGPTkz+JJHiQM2XCL4FiyQ+n/+A0DGQ==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1087:7e01:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 37.2 AUTH)
	with ESMTPSA id n015bcr1AFHnUsa
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Tue, 10 Feb 2015 16:17:49 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 82BCF50299; Tue, 10 Feb 2015 16:17:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150130150758.GA3683@peff.net>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263631>

On Fri, Jan 30, Jeff King wrote:

> I have 8.6.9-3 installed (it is part of Debian testing/unstable now),
> and confirmed that:
> 
> diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
> index 2c16c53..10c777e 100644
> --- a/Documentation/asciidoc.conf
> +++ b/Documentation/asciidoc.conf
> @@ -21,6 +21,7 @@ tilde=&#126;
>  apostrophe=&#39;
>  backtick=&#96;
>  litdd=&#45;&#45;
> +footer-style=none
>  
>  ifdef::backend-docbook[]
>  [linkgit-inlinemacro]
> 
> drops the "last-updated" footer.

This does not remove "Last updated" from files like
using-merge-subtree.html for me, using asciidoc-8.6.8.

Olaf
