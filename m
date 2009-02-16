From: david@lang.hm
Subject: Re: [RFC - draft] List of proposed future changes that are backward
 incompatible
Date: Sun, 15 Feb 2009 16:35:32 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902151622530.14911@asgard.lang.hm>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <m3fxifticm.fsf@localhost.localdomain> <alpine.DEB.1.00.0902160009010.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 00:32:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYqT5-0006kd-Dl
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbZBOXao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbZBOXan
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:30:43 -0500
Received: from mail.lang.hm ([64.81.33.126]:33926 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbZBOXan (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:30:43 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n1FNUYD4019540;
	Sun, 15 Feb 2009 15:30:34 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.00.0902160009010.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110087>

On Mon, 16 Feb 2009, Johannes Schindelin wrote:

> Hi,
>
> On Sun, 15 Feb 2009, Jakub Narebski wrote:
>
>> david@lang.hm writes:
>>
>>> one thing that would help new users is if there was a way to create a
>>> git config file that explicitly listed all the defaults. either as a
>>> sample config, or to expand the existing config file with all the
>>> defaults listed, but commented out.
>>>
>>> I find that having such a config file helps me find config options I
>>> never thought to look for.
>>
>> That is a very good idea... if next to impossible now, I think, as
>> there is (I guess) no single place that stores default values.  But
>> perhaps I am mistaken.

if there isn't, wouldn't it be a good idea to make one?

> Of course, you have to ignore the fact that it would no longer possible to
> update defaults for existing repositories.

not if the defaults are put into the config file commented out.

this way you can see all the options (and default settings), but still 
tell which ones are system defaults and which ones the user has set. I 
have seen several projects that ship a config file that consists almost 
entirely of commented out items.

also, the first option I listed was to create a new file on-command that 
would contain the defaults

> For example, setting something like receive.denyCurrentBranch to a saner
> default would not reach existing repositories.
>
> And you would also have to ignore the fact that sometimes, config
> variables are deprecated, and this _also_ would not reach existing
> repositories.  Of course, the same holds true if you set such a config
> variable manually, but then you are _supposed_ to know the config
> variable, and you are unlikely to learn the name of an obsolete variable.
>
> Do keep in mind, too, that most of the variables are next to useless
> without the proper documentation.

in most cases the variable names are fairly descriptive. even if you have 
to go to the documentation to figure out what to set it to, seeing the 
name can point you to the right thing to search for in the documentation.

> And do you really want to replicate
> Documentation/config.txt in the config file?  If not, how do you want to
> make sure that the two different documentations do not go out of sync?

have one be auto-generated from the other and they won't be out of sync.

also note that I'm suggesting a git-config option that does this. not 
having it set at git-init time, so that users can run it long after the 
repository was created and see the defaults for the current version of 
git.

> Further, it would be much, much harder to see what is _actually_ set.

again, not if the defaults are put in as commented out options

> Summary: I do not like that idea.

I'm not sure the idea you dislike so much is exactly what I proposed.

David Lang
