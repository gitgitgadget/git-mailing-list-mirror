From: David Brown <git@davidb.org>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 10:53:19 -0800
Message-ID: <20081115185318.GC22714@linode.davidb.org>
References: <491DE6CC.6060201@op5.se> <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org> <491EA1CC.9020605@op5.se> <3af572ac0811150228k291b8850idc34cb474f455aa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 19:54:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1QHz-0001z6-2J
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 19:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbYKOSxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 13:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbYKOSxU
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 13:53:20 -0500
Received: from linode.davidb.org ([72.14.176.16]:38292 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbYKOSxT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 13:53:19 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1L1QGl-00062Y-2S; Sat, 15 Nov 2008 10:53:19 -0800
Content-Disposition: inline
In-Reply-To: <3af572ac0811150228k291b8850idc34cb474f455aa7@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101085>

On Sat, Nov 15, 2008 at 11:28:39AM +0100, Pau Garcia i Quiles wrote:
>> Shawn posted the exact text. The spirit of that license is that anyone can
>> use an unmodified version of the library for whatever they want, but it's
>> illegal to link non-GPL software to an altered version of the library. That
>> is, the git community will get all changes back while other projects can
>> use the official version of the library without having to worry about
>> licensing issues. EvilCompany cannot make changes to the library and then
>> link non-GPL'd software to their changed version. They can do that if they
>> send their library changes upstream and then only use them once they're
>> considered "official" though.
>
>Do you mean if I write a patch to libgit2, send it upstream and make
>it public on my website but it is not accepted upstream, I cannot link
>my modified libgit2 version (i. e. libgit2 + my patch) to my non-GPL
>software? It looks insane to me: I wrote the patch and made it public
>but you guys did not accept it!

The license is not clear on this, at all.  Since under the GPLv2, you
are allowed to make a derivative work, and distribute that, you are
then basing your binary off of your particular distribution.  The
license does not have a notion of an "official" version.  So, it might
be satisfied as long as you base it off of something that is
distributed.

But, yes, it is vaguely worded and unclear in it's intent.

David
