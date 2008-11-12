From: Miguel de Icaza <miguel@ximian.com>
Subject: Re: [MonoDevelop] git integration with monodevelop
Date: Wed, 12 Nov 2008 14:48:08 -0500
Organization: Novell.
Message-ID: <1226519288.4483.176.camel@erandi.site>
References: <491AAE6D.8030304@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>,
	monodevelop-list@lists.ximian.com,
	Michael Hutchinson <m.j.hutchinson@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 12 20:50:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Ljq-0005mc-J9
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 20:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbYKLTtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 14:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752916AbYKLTtj
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 14:49:39 -0500
Received: from victor.provo.novell.com ([137.65.250.26]:60453 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbYKLTti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 14:49:38 -0500
Received: from [164.99.121.39] (prv-ext-foundry1.gns.novell.com [137.65.251.240])
	by victor.provo.novell.com with ESMTP (TLS encrypted); Wed, 12 Nov 2008 12:49:26 -0700
In-Reply-To: <491AAE6D.8030304@op5.se>
X-Mailer: Evolution 2.22.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100810>

Hello,

> So in an effort to learn C#, I've decided to play along with this
> (hopefully with some help from the MonoDevelop team), but it seems
> to me that the best place to start is the fledgling libgit2 and link
> that with git-sharp. The primary reason for this is ofcourse that I
> think it'd be a terrible waste to have yet another from-scratch
> implementation of git in a new language (ruby, java, C#, C...). The
> secondary reason is that it would be neat to have more OSS projects
> use my favourite scm.
> 
> Besides, getting something to rely on libgit2 early on is probably
> the best way to get more people interested in making development of
> it proceed rapidly.
> 
> Thoughts anyone?

We would still like to see a port of jgit to C# as a fully managed
implementation, one that does not make P/Invoke calls into C code can
run on the sandboxed versions of .NET (Like the one available in
SecondLife, Unity3D, Silverlight and Mesh).

Miguel.
