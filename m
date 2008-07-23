From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Wed, 23 Jul 2008 21:22:38 +0200
Message-ID: <200807232122.38471.robin.rosenberg.lists@dewire.com>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <alpine.DEB.1.00.0807231817460.8986@racer> <488772BC.80207@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjwT-0007dw-SU
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbYGWTXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYGWTXF
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:23:05 -0400
Received: from av12-2-sn2.hy.skanova.net ([81.228.8.186]:46855 "EHLO
	av12-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYGWTXE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:23:04 -0400
Received: by av12-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 68D23380C4; Wed, 23 Jul 2008 21:23:02 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 2B52A37F78; Wed, 23 Jul 2008 21:23:02 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 4860637E44;
	Wed, 23 Jul 2008 21:23:01 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <488772BC.80207@workspacewhiz.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89751>

onsdagen den 23 juli 2008 20.04.44 skrev Joshua Jensen:
> ----- Original Message -----
> From: Johannes Schindelin
> Date: 7/23/2008 11:22 AM
> > On msys we do that.  A few users decided they know better and switched it 
> > off.  Me for example.  But I wouldn't do something as stupid as editing a 
> > file with an editor that tries to be helpful and adds CR/LFs.
> >   
> There are certain file formats, such as a Visual Studio .sln file, that 
> MUST be CRLF.  When a .sln file is not CRLF, Visual Studio refuses to 
> read it.  I want to be able to set into the committed .gitattributes 
> file the list of files that must be translated to the proper format 
> regardless of the autocrlf setting.  An example is below:
> 
> *.bat crlf
> *.def crlf
> *.dsp crlf
> *.dsw crlf
> *.rc crlf
> *.sln crlf
> *.vcproj crlf
> *.vcp crlf
> *.vcw crlf

Wouldn't  "*bat -crlf " etc be good for these, and thus store CRLF in the repo.

-- robin
