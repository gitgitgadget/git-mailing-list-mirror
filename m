From: Kevin Daudt <me@ikke.info>
Subject: Re: How to include just some subdirectory excluding all envelop tree
Date: Mon, 7 Mar 2016 22:06:09 +0100
Message-ID: <20160307210608.GA29312@ikke.info>
References: <56DDD020.2050101@ip-5.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olga Pshenichnikova <olga@ip-5.ru>
X-From: git-owner@vger.kernel.org Mon Mar 07 22:06:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad2M3-0005na-W3
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 22:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbcCGVGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 16:06:13 -0500
Received: from ikke.info ([178.21.113.177]:48162 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbcCGVGL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 16:06:11 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id 138472D8007; Mon,  7 Mar 2016 22:06:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56DDD020.2050101@ip-5.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288400>

On Mon, Mar 07, 2016 at 10:01:52PM +0300, Olga Pshenichnikova wrote:
> I have some tree structure:
> 
> /a
> /a/a
> /a/b
> ..
> /a/z
> /b
> .. (thousands of folders)
> /z
> 
> How can I control just /a/a folder?
> What exclude file should be?
> 
> The way we use now is:
> 
> /a/*
> /b/
> .. (thousands of folders)
> /z/
> !/a/a
> 
> But it is very not nice looking and hard for maintenance...

Don't know your usecase, but isn't it easier to just create the repository
in /a/a? Then you won't have to exlude anything.

If you must, you can just use something like:

 *
 !/a
 /a/*
 !/a/a
