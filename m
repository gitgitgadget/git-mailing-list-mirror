From: Christopher Faylor <me@cgf.cx>
Subject: Re: windows problems summary
Date: Thu, 2 Mar 2006 10:23:29 -0500
Message-ID: <20060302152329.GH2781@trixie.casa.cgf.cx>
References: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 02 16:24:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEpeO-0001ep-MT
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 16:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWCBPXa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 10:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWCBPXa
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 10:23:30 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:955 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1751429AbWCBPX3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 10:23:29 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 393055A800C; Thu,  2 Mar 2006 10:23:29 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17079>

On Thu, Mar 02, 2006 at 03:49:24PM +0100, Alex Riesen wrote:
>This is just to summarize all the problems which make porting to that
>thing so boring. Maybe if we have them all on one page, it'd be easier
>to locate the workarounds (it can be one thread, for example).
>
>1. opened and mmaped files can't be removed or renamed
>  (caused workaround with reading index in memory)
>2. command can safely contain only one argument
>  (breaks and complicates passing things between processes)
>3. no fork
>  (slows down and complicates passing things between processes)
>4. non-unix permissions model
>  (breaks x-attr)
>5. real slow filesystems and caching
>  (makes everything slow. I noticed I'm trying to avoid git status!).
>  Caused workaround with manual checkout)
>6. real slow program startup
>  (makes everything slow, eventually may cause everything being put
>  in one super-executable, just to avoid spawning new processes,
>  with all associated problems. Makes scripting harder)
>
>I hope this message can be a start of a big porting thread,
>even though it is only about windows at the moment.

Are we *really* contemplating porting git to native Windows?

I guess I missed that memo.

cgf
