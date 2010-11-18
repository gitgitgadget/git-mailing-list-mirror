From: Alejandro Riveira =?iso-8859-1?q?Fern=E1ndez?= 
	<ariveira@gmail.com>
Subject: Re: groff .ft command use in asciidoc
Date: Thu, 18 Nov 2010 17:47:19 +0000 (UTC)
Message-ID: <ic3or7$dfi$1@dough.gmane.org>
References: <20101117095233.GA23817@basil.fritz.box>
	<20101117101516.GA12416@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 18:47:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ8aE-000500-ET
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758134Ab0KRRri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 12:47:38 -0500
Received: from lo.gmane.org ([80.91.229.12]:52290 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755048Ab0KRRrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 12:47:37 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PJ8a7-0004t2-1S
	for git@vger.kernel.org; Thu, 18 Nov 2010 18:47:35 +0100
Received: from 81.38.65.156 ([81.38.65.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 18:47:35 +0100
Received: from ariveira by 81.38.65.156 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 18:47:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 81.38.65.156
User-Agent: Pan/0.133 (House of Butterflies)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161693>

On Wed, 17 Nov 2010 04:15:16 -0600, Jonathan Nieder wrote:


> 
> This is in my opinion a bug: unless you use ASCIIDOC_NO_ROFF, git's
> asciidoc.conf will include raw roff directives in the docbook markup it
> generates.  And then docbook will escape the periods, producing the
> output you see.
> 
> The workaround is very simple: set ASCIIDOC_NO_ROFF to nonempty when you
> build documentation.

 I use make quick-install-man which, afaik, installs man pages 
"prerendered" from the man branch and i see the same artifact.
 
 So can those man pages be rendered with this workaraound?
 
 Thanks



> Hope that helps,
> Jonathan
