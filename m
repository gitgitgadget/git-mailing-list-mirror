From: Kevin Ballard <kevin@sb.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 14:10:11 -0700
Message-ID: <E2027B3B-CF7F-48C2-84C4-3A10131926E1@sb.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <20080717202609.GA32184@machine.or.cz> <57BAA376-10A4-4E3F-BB8E-37B46E8C49D3@sb.org> <200807172303.19339.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 23:11:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJaks-00011O-BL
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 23:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759699AbYGQVKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 17:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759549AbYGQVKP
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 17:10:15 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:45543 "EHLO
	randymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756791AbYGQVKN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 17:10:13 -0400
Received: from [10.100.18.129] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a3.g.dreamhost.com (Postfix) with ESMTP id 765D4185DB4;
	Thu, 17 Jul 2008 14:10:12 -0700 (PDT)
In-Reply-To: <200807172303.19339.jnareb@gmail.com>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88922>

On Jul 17, 2008, at 2:03 PM, Jakub Narebski wrote:

> Dnia czwartek 17. lipca 2008 22:40, Kevin Ballard napisa=C5=82:
>> On Jul 17, 2008, at 1:26 PM, Petr Baudis wrote:
>>> On Thu, Jul 17, 2008 at 01:12:57PM -0700, Kevin Ballard wrote:
>
>>>> There is one facet of submodules that annoys me, because it
>>>> prevents me from using them as a replacement for svn:externals.
>>>> Namely, the submodule refers to a specific repository, but not
>>>> a path within that repository.  I work with svn repos that use
>>>> svn:externals to peg revisions (as is appropriate) but they all
>>>> refer to various paths within the other repositories, and the
>>>> only way I can deal with that is to throw symlinks everywhere.
>>>
>>> Actually, is this a big problem? Git can track symlinks and without
>>> adding support for overall partial checkouts, adding this would fee=
l
>>> like too huge a hack to me.
>>>
>>> Also, when converting to a different VCS, it might be sensible to
>>> adjust
>>> your modules setup a bit as well - the requirement to include only
>>> particular subdirectory of a submodule sounds rather strange to me.
>>
>> The problem is right now I maintain a bunch of git-svn mirrors of
>> internal svn repos, but the company isn't willing to switch to git.
>> And we use subtree externals links to do things like pull in the
>> models from one rails app into another, or pull in various
>> subdirectories of the "support" repository.
>
> I think the correct solution would be to make 'models' separate
> repository... or create interim repository containing only changes
> to 'models', and having 'models' as its top directory.

That would require significantly more work to deal with than using =20
symlinks like I described, since the company is not willing to adjust =20
anything to help with my git usage (as I'm the only git user here).

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
