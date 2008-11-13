From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: git integration with monodevelop
Date: Wed, 12 Nov 2008 18:00:01 -0600
Message-ID: <5d46db230811121600p14557d79l5977cd072fd06532@mail.gmail.com>
References: <491AAE6D.8030304@op5.se> <491AB078.6020208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Shawn Pearce" <spearce@spearce.org>,
	"Michael Hutchinson" <m.j.hutchinson@gmail.com>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 13 01:01:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0PeG-0001zB-Cl
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 01:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbYKMAAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 19:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbYKMAAG
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 19:00:06 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:47801 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbYKMAAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 19:00:02 -0500
Received: by qw-out-2122.google.com with SMTP id 3so398101qwe.37
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 16:00:01 -0800 (PST)
Received: by 10.214.78.2 with SMTP id a2mr10472953qab.136.1226534401126;
        Wed, 12 Nov 2008 16:00:01 -0800 (PST)
Received: by 10.214.217.4 with HTTP; Wed, 12 Nov 2008 16:00:01 -0800 (PST)
In-Reply-To: <491AB078.6020208@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100836>

On Wed, Nov 12, 2008 at 4:31 AM, Andreas Ericsson <ae@op5.se> wrote:
> Andreas Ericsson wrote:
>>
>> Recently, I've started learning C#. More for fun than anything else,
>> but one of the mono core devs sniffed me out and said they've been
>> thinking of porting jgit to C# to get a working IDE integration in
>> monodevelop. Currently, the only option available (with IDE
>> integration anyways) to the poor C# devs is either Microsoft's
>> crappy VSS, or the less crappy but still far from fantastic
>> Subversion.
>>
>> So in an effort to learn C#, I've decided to play along with this
>> (hopefully with some help from the MonoDevelop team), but it seems
>> to me that the best place to start is the fledgling libgit2 and link
>> that with git-sharp. The primary reason for this is ofcourse that I
>> think it'd be a terrible waste to have yet another from-scratch
>> implementation of git in a new language (ruby, java, C#, C...). The
>> secondary reason is that it would be neat to have more OSS projects
>> use my favourite scm.
>>
>> Besides, getting something to rely on libgit2 early on is probably
>> the best way to get more people interested in making development of
>> it proceed rapidly.
>>
>> Thoughts anyone?
>>
>> Please reply-to-all as this goes cross-list
>> (currently, Cc ae@op5.se, spearce@spearce.org, git@vger.kernel.org,
>> m.j.hutchinson@gmail.com, in case monodevelop-list uses reply-to
>> header).
>>
>
> Ouch. Scratch monodevelop-list from that Cc list. It appears to be
> members-only (although not listed as such on their list-server).
>

Hi,

I started working on a C# UI a long time ago but I abandoned it due
to lack of interest from others and time constraints.  You are welcome
to take it and build on it if you like.  It wraps the C git binaries and the UI
is separate from the "plumbing".

http://repo.or.cz/w/Widgit.git

-Govind
