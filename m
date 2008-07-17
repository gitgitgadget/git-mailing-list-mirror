From: Kevin Ballard <kevin@sb.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 13:40:56 -0700
Message-ID: <57BAA376-10A4-4E3F-BB8E-37B46E8C49D3@sb.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <alpine.DEB.1.00.0807161902400.8986@racer> <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com> <alpine.LNX.1.00.0807161605550.19665@iabervon.org> <861w1sn4id.fsf@lola.quinscape.zz> <m3od4wse30.fsf@localhost.localdomain> <86k5fk1ooq.fsf@lola.quinscape.zz> <m3k5fks2et.fsf@localhost.localdomain> <38486DD8-B4D8-4AAC-9B5F-0A8035D894DD@sb.org> <20080717202609.GA32184@machine.or.cz>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:42:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJaIc-0007KT-5Z
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759716AbYGQUk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 16:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759431AbYGQUk7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:40:59 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:59730 "EHLO
	randymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759716AbYGQUk7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2008 16:40:59 -0400
Received: from [10.100.18.129] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a4.g.dreamhost.com (Postfix) with ESMTP id 21E0719589C;
	Thu, 17 Jul 2008 13:40:58 -0700 (PDT)
In-Reply-To: <20080717202609.GA32184@machine.or.cz>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88912>

On Jul 17, 2008, at 1:26 PM, Petr Baudis wrote:

> On Thu, Jul 17, 2008 at 01:12:57PM -0700, Kevin Ballard wrote:
>> There is one facet of submodules that annoys me, because it  
>> prevents me
>> from using them as a replacement for svn:externals. Namely, the  
>> submodule
>> refers to a specific repository, but not a path within that  
>> repository. I
>> work with svn repos that use svn:externals to peg revisions (as is
>> appropriate) but they all refer to various paths within the other
>> repositories, and the only way I can deal with that is to throw  
>> symlinks
>> everywhere.
>
> Actually, is this a big problem? Git can track symlinks and without
> adding support for overall partial checkouts, adding this would feel
> like too huge a hack to me.
>
> Also, when converting to a different VCS, it might be sensible to  
> adjust
> your modules setup a bit as well - the requirement to include only
> particular subdirectory of a submodule sounds rather strange to me.

The problem is right now I maintain a bunch of git-svn mirrors of  
internal svn repos, but the company isn't willing to switch to git.  
And we use subtree externals links to do things like pull in the  
models from one rails app into another, or pull in various  
subdirectories of the "support" repository.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
