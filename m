From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: jgit and ignore
Date: Sun, 1 Mar 2009 09:08:57 -0500
Message-ID: <9e4733910903010608u1777f0d4j843f12551154f962@mail.gmail.com>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com>
	 <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl>
	 <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com>
	 <49AA884D.1050806@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sun Mar 01 15:10:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdmNB-0000Xh-SU
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 15:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbZCAOJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 09:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbZCAOJB
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 09:09:01 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:18851 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbZCAOJA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 09:09:00 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1288463ywh.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 06:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4Utpw3w9SxSIeSklwhuaQvAACk5FsizTctF3KboZ66U=;
        b=G7wM2Ad79Rgbw4Q4QtnE/BNCoaqWtzF1+bUR7ol/E5P5okyUqcWhncBfC5H+QGkfTz
         iFZCxyJMfxrjf91La1EtUReIM+z9HEM85uIJodIxTjXEP+/oud1OPi6BCpNSxNygajik
         M+5f0sU10cEagFG3bT1Ctk1lUSoB0OFM6RZa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WE2LuHqzMZqlWe7ZxxFNjnOw4pHZxEXYxtpdg86bjus0D6JH0SSgqMCUdShyqNN+wZ
         IpnpxZPlxTrpaA2oHs48Z3lYfClJpEkByfjL0ZFs26MgnBVGzMczFlXGgYhHF7f7h3DF
         kAZIegUia3g0W41x0KSESbhTv9URfFgSsfVvM=
Received: by 10.220.97.75 with SMTP id k11mr1433742vcn.39.1235916537935; Sun, 
	01 Mar 2009 06:08:57 -0800 (PST)
In-Reply-To: <49AA884D.1050806@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111845>

On Sun, Mar 1, 2009 at 8:06 AM, Ferry Huberts (Pelagic)
<ferry.huberts@pelagic.nl> wrote:
> Jon Smirl wrote:
>> On Sun, Mar 1, 2009 at 5:11 AM, Ferry Huberts (Pelagic)
>> <ferry.huberts@pelagic.nl> wrote:
>>> Shawn O. Pearce wrote:
>>>> Jon Smirl <jonsmirl@gmail.com> wrote:
>>>>> I'm using jgit in eclipse. Works great for me.
>>>> Yay!
>>>>
>>>>> I have a couple of generated files in my working directory. There
>>>>> doesn't seem to be any UI for ignoring them. Is it there and I just
>>>>> can't find it?
>>>> EGit doesn't (yet) honor the .gitignore files like it should. Someone
>>>> (Ferry i-forget-the-rest-of-his-name) is working on adding ignore
>>>> support and has patches in flight for at least some of it.
>>>>
>>> Ferry i-do-remember-my-name Huberts is working on it :-)
>>>
>>> I have most of it working in a basic form already but am currently
>>> refactoring things to take care of some nasty little details.
>>> Expect something to arrive within (my best guesstimate) about 3 to 4
>>> weeks. after next week I'll be skiing for a week, so no coding then :-)
>>>
>>> For the new functionality:
>>> You don't really need a UI: just add a .gitignore file with a pattern
>>> and the plugin will pick it up and show you what is ignored by means of
>>> a nice little decoration.
>>
>> I expected it to work by right clicking the file and picking
>> team/ignore. This would add the file name .gitignore and automatically
>> add .gitignore to my commit. It would also alter the eclipse filter to
>> make the file disappear in the eclipse browser.
>>
>
> that'll come later, first we need to ignore the same files as git :-)
>
> which eclipse browser?

I have a C/C++ perspective open right now. Navigator is on the left,
editor in the middle, outline on the right. In the navigator there are
several files that should be ignored. I'd like to right click on them
and select team/ignore. When I do that they will be ignored in git and
also disappear from my navigator.

I also don't like how I have a global .git for all of my projects
instead of a .git for each project individually. (Did I select that
when I first installed egit and didn't know what I was doing?) Now I'm
in a mess and can't publish individual projects.

>
> BTW. the plugin will not look at the eclipse filter for ignore files
> once I've finished the implementation. that's the only way to make sure
> that we ignore resources in exactly the same way as git does: git only
> ignores on the basis of .gitignore files, command line options (we do
> not have those for the plugin), and the info/exclude file in the repository.
>



-- 
Jon Smirl
jonsmirl@gmail.com
