From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tracking branch history
Date: Sat, 13 May 2006 08:20:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605130815550.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
 <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org> <20060513034051.GA21586@spearce.org>
 <7vody2v7yr.fsf@assigned-by-dhcp.cox.net> <20060513071753.GA21998@spearce.org>
 <20060513074328.GB21998@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 17:20:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fevum-0001ni-17
	for gcvg-git@gmane.org; Sat, 13 May 2006 17:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWEMPUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 11:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWEMPUN
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 11:20:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751293AbWEMPUM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 May 2006 11:20:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4DFK6tH004255
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 May 2006 08:20:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4DFK5Wb015800;
	Sat, 13 May 2006 08:20:05 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060513074328.GB21998@spearce.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19938>



On Sat, 13 May 2006, Shawn Pearce wrote:
> 
> Forget my last patch.  This one automatically creates the log file
> by looking for a config value of 'core.logRefUpdates=true'.

Looks better.

I actually disagree with Junio - I think the logging the name made sense. 
If you have a shared repo with multiple people pushing to the same branch, 
it's interesting to see who does the pushing.

I also think it might be good to save the oldsha1 value. Yes, it _should_ 
always be the previous sha1 logged, but it's interesting to see in case it 
isn't (ie the ref was updated some other way), and it's also interesting 
for the first entry after logging has been enabled.

Hmm?

		Linue
