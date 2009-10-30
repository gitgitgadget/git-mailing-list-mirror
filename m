From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured mergetool  option
Date: Fri, 30 Oct 2009 11:35:59 +0100
Message-ID: <200910301135.59831.markus.heidelberg@web.de>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com> <200910300202.02016.markus.heidelberg@web.de> <76718490910292000t7b024b83y68d71b6ff810c15@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ouE-0005Sy-7i
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 11:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071AbZJ3KkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 06:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757069AbZJ3KkS
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 06:40:18 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:59347 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757065AbZJ3KkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 06:40:16 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4F64A13B6DA70;
	Fri, 30 Oct 2009 11:36:02 +0100 (CET)
Received: from [89.59.69.28] (helo=pluto.fritz.box)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N3ops-0006Np-00; Fri, 30 Oct 2009 11:36:00 +0100
User-Agent: KMail/1.9.10
In-Reply-To: <76718490910292000t7b024b83y68d71b6ff810c15@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/4YorhSLUUCT9sL8UFhPjSg/S3c0uzRYQtugx4
	2a1WpdPMfVw7XPLxP4Yn0kiFO5xJ9RbM59IJR0UWENPmwJVcsB
	C7HFIsvLSiP32hZtDzSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131694>

Jay Soffian, 30.10.2009:
> On Thu, Oct 29, 2009 at 9:02 PM, Markus Heidelberg
> <markus.heidelberg@web.de> wrote:
> > He didn't mean p4merge on other platforms, but other merge tools on Mac
> > OS X. What about all the other merge tools already in mergetool--lib?
> > Should they get special handling, too?
> 
> If someone wants to scratch that itch, then yes. The default diff tool
> for OS X has its helper already in /usr/bin (opendiff). p4merge is
> arguably a better merge tool, and it installs as an app bundle in
> /Applications. I'm not sure about the other diff tools, I haven't
> looked.
> 
> > And for Windows we could add C:\Program Files\MergeToolX\tool.exe for
> > every merge tool.
> 
> If it makes those tools easier to use with git, and if someone on
> Windows wants to scratch that itch, then yes, we should.

Another possible problem: the user can change the installation
destination on Windows. What's the behaviour of Mac OS here? Is the
instalation path fixed or changeable?

Markus
