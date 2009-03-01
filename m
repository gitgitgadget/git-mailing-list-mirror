From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: jgit and ignore
Date: Sun, 01 Mar 2009 14:06:21 +0100
Message-ID: <49AA884D.1050806@pelagic.nl>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com>	 <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl> <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 14:07:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdlOa-00019c-Md
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 14:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbZCANGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 08:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbZCANGY
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 08:06:24 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:32797 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752662AbZCANGY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 08:06:24 -0500
Received: from [192.168.0.101] (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 68C7758BDBA;
	Sun,  1 Mar 2009 14:06:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111841>

Jon Smirl wrote:
> On Sun, Mar 1, 2009 at 5:11 AM, Ferry Huberts (Pelagic)
> <ferry.huberts@pelagic.nl> wrote:
>> Shawn O. Pearce wrote:
>>> Jon Smirl <jonsmirl@gmail.com> wrote:
>>>> I'm using jgit in eclipse. Works great for me.
>>> Yay!
>>>
>>>> I have a couple of generated files in my working directory. There
>>>> doesn't seem to be any UI for ignoring them. Is it there and I just
>>>> can't find it?
>>> EGit doesn't (yet) honor the .gitignore files like it should. Someone
>>> (Ferry i-forget-the-rest-of-his-name) is working on adding ignore
>>> support and has patches in flight for at least some of it.
>>>
>> Ferry i-do-remember-my-name Huberts is working on it :-)
>>
>> I have most of it working in a basic form already but am currently
>> refactoring things to take care of some nasty little details.
>> Expect something to arrive within (my best guesstimate) about 3 to 4
>> weeks. after next week I'll be skiing for a week, so no coding then :-)
>>
>> For the new functionality:
>> You don't really need a UI: just add a .gitignore file with a pattern
>> and the plugin will pick it up and show you what is ignored by means of
>> a nice little decoration.
> 
> I expected it to work by right clicking the file and picking
> team/ignore. This would add the file name .gitignore and automatically
> add .gitignore to my commit. It would also alter the eclipse filter to
> make the file disappear in the eclipse browser.
> 

that'll come later, first we need to ignore the same files as git :-)

which eclipse browser?

BTW. the plugin will not look at the eclipse filter for ignore files
once I've finished the implementation. that's the only way to make sure
that we ignore resources in exactly the same way as git does: git only
ignores on the basis of .gitignore files, command line options (we do
not have those for the plugin), and the info/exclude file in the repository.
