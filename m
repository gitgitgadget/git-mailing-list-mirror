From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 12:50:51 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125175051.GD32394@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
 <20121125051809.GA3670@thyrsus.com>
 <CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com>
 <20121125095429.GB22279@thyrsus.com>
 <CAMP44s1cG=5D9DppHmB9CpgkgdEzM72KhQ1Q-kWrrDo8ST+r_g@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 18:53:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcgO7-0003WY-4c
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 18:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab2KYRvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 12:51:44 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:43277
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab2KYRvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 12:51:43 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id E82AF4065F; Sun, 25 Nov 2012 12:50:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s1cG=5D9DppHmB9CpgkgdEzM72KhQ1Q-kWrrDo8ST+r_g@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210379>

Felipe Contreras <felipe.contreras@gmail.com>:
> Not according to ohloh:
> 
> 1) shell 33%
> 2) tcl 9%
> 3) perl 9.7%
> 
> 4) python 1.8%

Look in the Makefile - all that tcl code is buried in gitk.  We're
very, very lucky the author did such a good job, because it's a
potentially serious headache; who can maintain it?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
