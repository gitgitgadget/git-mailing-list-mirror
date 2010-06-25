From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC 2010 Update] Please try the initial version of the line
 level history browser
Date: Thu, 24 Jun 2010 20:45:50 -0500
Message-ID: <20100625014550.GA5077@burratino>
References: <AANLkTimRGZziLnffQXmzYnNhhE3dE_5Hsp1mxAEmBiIk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 03:46:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORxzp-0006n1-12
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 03:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab0FYBqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 21:46:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43974 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab0FYBqI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 21:46:08 -0400
Received: by iwn41 with SMTP id 41so1455848iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 18:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7GCYnojjr9g8po8iXdji/tNhn0nDhtQkwLyjorX3Cr0=;
        b=D8+bs4ArzUaoBk04x49ae/ljgFMUf9b+zvbx1QV83DVPdIevAsXfvkhLuFbckAZUgD
         TVcJqjb8rQDHUHJlVGsG9Uxdm2ygHJV4UTZxL0ABhqgL5jlaDsrtMvZ0XW7hXryiyyW7
         5643tnJpn6wZdfhs1Fabcco0bSHVzvFBBfHK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qEUSpq5t6ykEwLvY8zftrWxvDEAE5ZR7ETFfSWPDRXVJwXHCe/NnchUFPPJgr+kmjA
         4rVrQlGad+cZERwOcSh8VTkMxqQ4XYQyZVxmEzS1aksSF1blPdWRH7oe2J1kSCP/5Emi
         a4qE4Y9WfE5zGOabbAN0qApWdw4g1mTC1JX8w=
Received: by 10.231.32.129 with SMTP id c1mr11866520ibd.112.1277430364497;
        Thu, 24 Jun 2010 18:46:04 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u6sm44059826ibu.0.2010.06.24.18.46.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 18:46:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimRGZziLnffQXmzYnNhhE3dE_5Hsp1mxAEmBiIk@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149661>

Hi Bo,

Bo Yang wrote:

> ssh://repo.or.cz/srv/git/line.git   phrase2

For those without ssh access, it seems the place to look is

 git://repo.or.cz/line.git diff-range
 http://repo.or.cz/r/line.git diff-range

> And finally, my future plans are:
> 1. Fix some memory leaks of this verion.
> 2. Collect advice of this version and improve it.
> 3. Start to prepare this version to list and submit patches.

Looking forward to it!

Thanks,
Jonathan
