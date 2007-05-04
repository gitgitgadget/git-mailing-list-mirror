From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 22:23:24 +0200
Message-ID: <20070504202324.GB4033@steel.home>
References: <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com> <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net> <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com> <56b7f5510705040153i65ba6260v9fbe7a90e040cab3@mail.gmail.com> <81b0412b0705040217o54d1d028j6e768bdc3eb0bad0@mail.gmail.com> <56b7f5510705040226o14d55b6euda7df1da7ad9b08a@mail.gmail.com> <81b0412b0705040246r5a2726b8g4323cadeacee3aa7@mail.gmail.com> <56b7f5510705040957v4580b6c1xbe767892ada3bcde@mail.gmail.com> <81b0412b0705041017l1ceb419j733e9cf3389e9709@mail.gmail.com> <Pine.LNX.4.64.0705042025130.4015@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 04 22:23:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk4JP-0005VS-Uf
	for gcvg-git@gmane.org; Fri, 04 May 2007 22:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031529AbXEDUX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 16:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031533AbXEDUX2
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 16:23:28 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:48364 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031529AbXEDUX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 16:23:27 -0400
Received: from tigra.home ([195.4.202.37] [195.4.202.37])
	by post.webmailer.de (mrclete mo43) (RZmta 5.8)
	with ESMTP id D04b3bj44GfieF ; Fri, 4 May 2007 22:23:25 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2DEDA277BD;
	Fri,  4 May 2007 22:23:25 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0DD08D171; Fri,  4 May 2007 22:23:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705042025130.4015@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46211>

Johannes Schindelin, Fri, May 04, 2007 21:00:53 +0200:
> Having said that, I think ":./bla/blub" is the most intuitive, and the 
> least breaking.
> 
> You _could_ change the current :/ notation, but _why_?

To use the syntax for full path starting from root of repo.
It looks "most intuitive" for this.
