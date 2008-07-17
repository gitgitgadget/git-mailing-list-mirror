From: Kevin Ballard <kevin@sb.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 13:12:57 -0700
Message-ID: <38486DD8-B4D8-4AAC-9B5F-0A8035D894DD@sb.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <alpine.DEB.1.00.0807161902400.8986@racer> <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com> <alpine.LNX.1.00.0807161605550.19665@iabervon.org> <861w1sn4id.fsf@lola.quinscape.zz> <m3od4wse30.fsf@localhost.localdomain> <86k5fk1ooq.fsf@lola.quinscape.zz> <m3k5fks2et.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:14:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJZrj-00068l-1U
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758879AbYGQUNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 16:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758343AbYGQUNE
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:13:04 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:49893 "EHLO
	randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756873AbYGQUND (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2008 16:13:03 -0400
Received: from [10.100.18.129] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id D5579DE418;
	Thu, 17 Jul 2008 13:13:01 -0700 (PDT)
In-Reply-To: <m3k5fks2et.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88907>

On Jul 17, 2008, at 1:04 PM, Jakub Narebski wrote:

>> Granted, particularly concerning the external property. OTOH, it  
>> makes
>> the equivalent of git submodules rather cheap (and I actually still  
>> have
>> no idea how git submodules properly work and what implications they
>> have).
>
> Git submodules are roughly equivalent to svn:externals with peg
> revisions; I mean here that they refer not to some branch in some
> external repository, but to specific revision.  This is the only sane
> design, as it assures that when checking out some historical revision,
> the state that is checked out will be the same for everybody.
>
> Please take into account however that submodules are quite new
> feature, and while underlying engine is solid, interface (UI) needs
> some polishing (and use cases).

There is one facet of submodules that annoys me, because it prevents  
me from using them as a replacement for svn:externals. Namely, the  
submodule refers to a specific repository, but not a path within that  
repository. I work with svn repos that use svn:externals to peg  
revisions (as is appropriate) but they all refer to various paths  
within the other repositories, and the only way I can deal with that  
is to throw symlinks everywhere.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
