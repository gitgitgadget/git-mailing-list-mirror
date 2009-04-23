From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [EGit PATCH] IgnoreAction to add to .gitignore files
Date: Thu, 23 Apr 2009 22:48:45 +0200
Message-ID: <49F0D42D.3070405@pelagic.nl>
References: <20090423115042.743E6D9CDC@apple.int.bandlem.com> <200904232119.36707.robin.rosenberg@dewire.com> <49F0CCF4.20808@pelagic.nl> <200904232226.22240.robin.rosenberg@dewire.com> <480EAB35-0032-42E9-B6C1-6712A7EB7ED1@bandlem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Alex Blewitt <alex@bandlem.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:50:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx5sC-0006wB-Uy
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 22:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbZDWUsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 16:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbZDWUsr
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 16:48:47 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:40173 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752941AbZDWUsq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 16:48:46 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 7291958BD9F;
	Thu, 23 Apr 2009 22:48:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <480EAB35-0032-42E9-B6C1-6712A7EB7ED1@bandlem.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117384>

Alex Blewitt wrote:
> On 23 Apr 2009, at 21:26, Robin Rosenberg wrote:
> 
>> torsdag 23 april 2009 22:17:56 skrev "Ferry Huberts (Pelagic)"
>> <ferry.huberts@pelagic.nl>:
>>> while we're on the subject...
>>> how about also adding the reverse: when a file is ignored then add it to
>>> the .gitignore file for 'un-ignoring' (the '!' pattern)
>>
>> I'm not convinced each and everything should have a menu entry. Advanced
>> use of .gitignore should have a .gitignore editor. When we have that the
>> option could perhaps launch the editor automatically if it recognized
>> no-trivial ignore rules. For trivial cases it would just append to the
>> file.
> 

which is my idea as well.

> I don't know of any other SCM that allows you to un-ignore files in the
> way that Git does; my guess is that most people wouldn't miss it if it
> weren't there. A .gitignore customised editor is probably overkill too -
> after all, you can just open it up in a text editor and make changes
> yourself. I've amended a few .cvsignore files in my time manually, but I
> wouldn't want to overcomplicate the menu for that.
> 

just thought it would be an easy thing to do. still think that.
an ignore editor can be nice. the gui would be kind of critical in
making it comprehensible though.

btw. the argument that no other SCM does this is kind of BS. git does
many things no other SCM does, and I also know of other SCMs that do
things that git can't do...
