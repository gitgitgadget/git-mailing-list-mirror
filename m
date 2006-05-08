From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 7 May 2006 17:55:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605071751050.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <BAYC1-PASMTP08D42DA222BA9843352CC1AEA80@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: proski@gnu.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 02:55:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcu2D-0001jw-Ln
	for gcvg-git@gmane.org; Mon, 08 May 2006 02:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWEHAzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 20:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWEHAzc
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 20:55:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40110 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbWEHAzc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 20:55:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k480tPtH023123
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 May 2006 17:55:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k480tPCT030483;
	Sun, 7 May 2006 17:55:25 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08D42DA222BA9843352CC1AEA80@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19736>



On Sun, 7 May 2006, sean wrote:
> 
> Having magic sections that prepend "branch." seems a bit suspect;
> why not just be explicit:
> 
>   [branch.Origin]
>       URL = ...
>       fetch = master

Exactly because section (and key) names are normally not case sensitive.

Even the documentation actually talks about "core.fileMode" and "[imap] 
Folders". 

		Linus
