From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git --version
Date: Wed, 31 May 2006 13:16:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605311311480.24646@g5.osdl.org>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com> 
 <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>  <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
  <4d8e3fd30605311220t17d319efyd5234dd4eb74fc96@mail.gmail.com> 
 <Pine.LNX.4.64.0605311224360.24646@g5.osdl.org> 
 <4d8e3fd30605311230h53981e57x8a417b176bedba86@mail.gmail.com> 
 <Pine.LNX.4.64.0605311233030.24646@g5.osdl.org> 
 <4d8e3fd30605311243q5a93a7a9l827c55827817602f@mail.gmail.com> 
 <4d8e3fd30605311249l6ba4ff74l72778ffe60462263@mail.gmail.com> 
 <4d8e3fd30605311256o67e45d06ve0efeff65fcf4851@mail.gmail.com>
 <4d8e3fd30605311308j6a784635g91e2721258f53c9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 22:16:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlX7Y-00039K-CD
	for gcvg-git@gmane.org; Wed, 31 May 2006 22:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWEaUQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 16:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWEaUQk
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 16:16:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12486 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751580AbWEaUQj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 16:16:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4VKGS2g005629
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 31 May 2006 13:16:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4VKGOA1004876;
	Wed, 31 May 2006 13:16:26 -0700
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
In-Reply-To: <4d8e3fd30605311308j6a784635g91e2721258f53c9f@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21091>



On Wed, 31 May 2006, Paolo Ciarrocchi wrote:
> 
> Don't know whay $PATH are different

See ENVIRONMENT in the sudo man-page:

        PATH                   Set to a sane value if sudo was configured with
                               the --with-secure-path option

so apparently your distro builds sudo with "--with-secure-path".

		Linus
