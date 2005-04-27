From: Petr Baudis <pasky@ucw.cz>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 21:39:03 +0200
Message-ID: <20050427193903.GG22956@pasky.ji.cz>
References: <426F2671.1080105@zytor.com> <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org> <426FD3EE.5000404@zytor.com> <20050427183239.GE19011@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 21:34:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQsIG-0005Hf-5i
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 21:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVD0TjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 15:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVD0TjI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 15:39:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56232 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261976AbVD0TjF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 15:39:05 -0400
Received: (qmail 406 invoked by uid 2001); 27 Apr 2005 19:39:03 -0000
To: Dave Jones <davej@redhat.com>
Content-Disposition: inline
In-Reply-To: <20050427183239.GE19011@redhat.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 27, 2005 at 08:32:40PM CEST, I got a letter
where Dave Jones <davej@redhat.com> told me that...
> That actually broke one of my first git scripts when one of the
> changelog texts started a line with 'tree '.  I hacked around it
> by making my script only grep in the 'head -n4' lines, but this
> seems somewhat fragile having to make assumptions that the field
> I want to see is in the first 4 lines.

The tree field is now always at the first line, but generally the header
part is variable-sized; you have multiple parent lines in case of
merges.

Just stop reading at the first newline.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
