From: Kevin Ballard <kevin@sb.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 13:42:01 -0700
Message-ID: <D217A1F1-ED15-4380-9A2E-9EBB4478D95B@sb.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <m3k5fks2et.fsf@localhost.localdomain> <38486DD8-B4D8-4AAC-9B5F-0A8035D894DD@sb.org> <200807172234.19146.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:43:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJaJd-0007lc-SM
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759431AbYGQUmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 16:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758713AbYGQUmF
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:42:05 -0400
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:53475 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755980AbYGQUmE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2008 16:42:04 -0400
Received: from [10.100.18.129] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 6C96A18DBAA;
	Thu, 17 Jul 2008 13:42:02 -0700 (PDT)
In-Reply-To: <200807172234.19146.jnareb@gmail.com>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88913>

On Jul 17, 2008, at 1:34 PM, Jakub Narebski wrote:

> On Thu, 17 July 2008, Kevin Ballard wrote:
>> On Jul 17, 2008, at 1:04 PM, Jakub Narebski wrote:
>>
>>> Git submodules are roughly equivalent to svn:externals with peg
>>> revisions; I mean here that they refer not to some branch in some
>>> external repository, but to specific revision.  This is the only  
>>> sane
>>> design, as it assures that when checking out some historical  
>>> revision,
>>> the state that is checked out will be the same for everybody.
>>>
>>> Please take into account however that submodules are quite new
>>> feature, and while underlying engine is solid, interface (UI) needs
>>> some polishing (and use cases).
>>
>> There is one facet of submodules that annoys me, because it prevents
>> me from using them as a replacement for svn:externals. Namely, the
>> submodule refers to a specific repository, but not a path within that
>> repository. I work with svn repos that use svn:externals to peg
>> revisions (as is appropriate) but they all refer to various paths
>> within the other repositories, and the only way I can deal with that
>> is to throw symlinks everywhere.
>
> I don't quite understand.  At the lowest, "gitlink" level submodule
> entry is just having _commit_ object in place of directory.  And of
> course this commit object refers to top tree (top directory) in
> a subproject.
>
> If you have subproject B with the following file structure
>
>  B/foo
>  B/bar/baz
>
> and you have (super)project A, which contains B as subproject at path
> sub-b, and has some files itself, the directory sytucture would look
> like this:
>
>  A/quux
>  A/sub-b/foo
>  A/sub-b/bar/baz
>
>
> What you want, I guess, is some a bit weird for me mixture of  
> submodule
> and partial (subtree) checkout... and the latter is not implemented  
> yet
> (I say "yet" because there was some preliminary implementation of
> subtree checkout on git mailing list).

It seems you understand what I'm saying. The only way I can mimic it  
is to make the submodules actually live in some hidden directory .foo  
and then scatter symlinks everywhere.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
