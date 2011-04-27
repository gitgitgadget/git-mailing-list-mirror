From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 01:36:15 +1000
Message-ID: <BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:36:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF6mt-0003xN-Oa
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 17:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826Ab1D0PgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 11:36:18 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50304 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab1D0PgR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 11:36:17 -0400
Received: by ewy4 with SMTP id 4so551001ewy.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wKqq3yvgNgsmakgUFDgSaMEURDeWKjHCjcOFyONr/Fk=;
        b=R4okPeABpwqT4BTaS2bKW2vdKZbp15MyUOvvCGLWGmmezKBqvdd6PV4gZl9vizj38A
         /LCI5SPFuwbMA8OsPV/A+FRE4UsVHNh7OfUPM3g235094S62KAIaoHvcpRQGdLnVdES2
         likbmnL8ZbVGzf9nzcMlIbrAKb8aP4wjfruIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tHjE0qczW2VPInWI99tU+BGbWl8KhGN2M+d0c+lmpAy5fQO7QcnnnObxWoM+rUWUVg
         5buG0WN8n2Wz0CDworL/KK7pJOJ0Bbd0YabYwClveR600zKWJ9tEZqh5ebyNDS4hmasg
         6VE3rP+sMg6DpZlwnCPiT3WdufcTRXMHLl0uM=
Received: by 10.14.52.65 with SMTP id d41mr1088825eec.85.1303918575963; Wed,
 27 Apr 2011 08:36:15 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 08:36:15 -0700 (PDT)
In-Reply-To: <4DB82D90.6060200@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172240>

On Thu, Apr 28, 2011 at 12:52 AM, Andreas Ericsson <ae@op5.se> wrote:
> On 04/27/2011 02:50 PM, Jon Seymour wrote:
>> On Wednesday, April 27, 2011, Andreas Ericsson =C2=A0wrote:
>>> On 04/27/2011 05:36 AM, Jon Seymour wrote:
>>>> Has anyone ever given consideration to git supporting a plugin
>>>> architecture for git extensions?
>>>>
>>>> The idea would be to provide a consistent way to install, and addr=
ess
>>>> extensions to the core git functionality in a manner that does not
>>>> require the extension to actually be integrated into the git core.
>>>>
>>>
>>
>>> Horrible idea. There are already as many package managers as there
>>> are packages without us throwing another one into the mix.
>>>
>>
>> I agree that there are too many package managers. But do you know
>> what? There isn't a single package manager that reliably works acros=
s
>> platform. apt-get? great. Except you need something else for Mac,
>> cywgin, or, um Fedora. Brew? Fine then you only need to worry about
>> Linux and cygwin. Cygwin? ...
>>
>> The platform for my extension is git. Not Mac. Not Debian. Not Fedor=
a.
>> Not cygwin. git.
>>
>> The lowest common denominator across these environments is, um, git.
>>
>
> You're utterly horribly wrong. It'll work well enough for scripted
> languages but when you start mixing in compiler requirements and
> whatnot the scheme falls apart. Quickly. Binary packages are popular
> for (very good) reasons: They are simple, fast and there's a
> reasonable chance they've been tested fairly well with the rest of
> the system so nothing breaks horribly once you install it.
> Perl, Ruby, Python and PHP all have their own extension installers.
> That makes perfect sense since the same code runs unchanged on all
> platforms (with some few exceptions).
>

Yeah, but that's when you delegate to a OS-specific package manager.

Concens. Separated. Good principle, that.

>> I challenge the sceptIcs to specify a one line command script that
>> works across all possible environment that is more succinct than:
>>
>> =C2=A0 =C2=A0 git pm install gitwork
>>
>
> That's not the point. Mac users supposedly already know about brew.
> Fedora users already know about yum. Cygwin users... well, I have
> no idea what they know about, but whatever it is, it's fairly safe
> to assume they already know about it. That means they'll turn to
> that familiar tool for managing packages when they want to install
> something new. What you're proposing would force users on *all*
> systems to have to learn a new one.
>
>> It shouldn't be too hard. A tar command here, an enviroment =C2=A0va=
riable
>> edit there. Perhaps a curl command or a browser download.
>>
>
> And what you get in the end is a f*cking mess of spaghetti shell
> code that works worse than the existing package managers.
>

I guess that really depends on who you ask to write the shell script.

Most package managers have fairly straight forward interfaces.

   brew install blah
   apt-get install blah
   git clone git://github.com/blah/blah

There is no reason why some with a modicum of shell scripting nous
could not whip together
a simple meta interface for platform-specific package managers that
knows how to:

* read a specification from a git config file
* apply that specification to the task of invoking a platform specific
package manager.

Some one really smart could probably do it in an extensible way that
coped with the concept that different OS-platforms have different
package managers.

Most of this pasta can be cooked once, by the person who writes
gpm/git-pm. Sauce would be extra, of course.

> And you're right. It's not too hard, so long as every extension
> manager maintains some short list of requirements in the proper
> format, which current package maintainers will have to learn if
> they want some modules to be part of the "default" system install,
> the way a whole bunch of Perl modules are.
>
>> You have 4 words. Knock yourself out.
>>
>
> make install

>
> Made it in 2. What you described is what the user does to get
> new extensions. What I described below is what developers have
> to do to make their extensions easy to install *without* a
> package manager even if the distro the user is on doesn't ship
> that particular extension.
>

Again, there is a package called gitwork, available. It is available
as a tarball. Somewhere.
Install it.

* look up the url (google, might help)
* dowload it with your favourite download tool (browser, curl)
* unpack it
* install its dependencies, if required
* configure it
* buiild it

Your two words only specified the very last step. I needed 6 bullet
points merely to explain the details you omitted.

>
> So the complete description would be
>
> =C2=A0git clone git://somerepo/gitworks
> =C2=A0cd gitworks
> =C2=A0make install

Still more than 4 words.

jon.
