From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for
 /etc/gitweb.conf (WIP)
Date: Tue, 7 Jun 2011 08:44:04 -0500
Message-ID: <20110607134404.GA12730@elie>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
 <1307382271-7677-5-git-send-email-jnareb@gmail.com>
 <20110606221236.GD30588@elie>
 <1307451658.12283.39.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 15:44:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTwZw-0007Km-P5
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 15:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab1FGNoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 09:44:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53777 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab1FGNoO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 09:44:14 -0400
Received: by gyd10 with SMTP id 10so1935487gyd.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=a/cJfrJPFUzS5EwayJUa5pBV55U91a4kTUvatF+wvO0=;
        b=Gsa9DLc+Gv53fPUKCCyxNLx2baoViZSPpHfpYLMjEMORsH0cO4twUlE1Lc7Qfh1zmo
         4Shr0TIfRKXz+5a88GKgMNa3VNS3qrcTT1AbN/PD3EZSgMOcczAsyIYYtLZthVqxHq2j
         s4zvkrJ3R+SpfoafLb8Rgmz0GA9OLSSvJs1Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lds/49f5+2I8PKERyptHAUdYtQ57wpHB++1/xb5htq/T/DSBswO+vELw0VN1ZGliOP
         RqTy9iVq3UQac76Yu3K06EhfNp8IjZ+g56GoNBIVkYB850FwgurWrzlfqwp/Hro3a6Qp
         B5GxB/jqniKvCqaKkhho4LnggwZBsccBh9VCA=
Received: by 10.43.132.66 with SMTP id ht2mr10768195icc.339.1307454253304;
        Tue, 07 Jun 2011 06:44:13 -0700 (PDT)
Received: from elie (adsl-68-255-98-24.dsl.chcgil.sbcglobal.net [68.255.98.24])
        by mx.google.com with ESMTPS id e1sm3657197icv.8.2011.06.07.06.44.10
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 06:44:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307451658.12283.39.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175203>

Hi,

Drew Northup wrote:
> On Mon, 2011-06-06 at 17:12 -0500, Jonathan Nieder wrote:

>> Micronit: a single line like
>>
>> 	SYNOPSIS
>> 	--------
>> 	$GITWEBDIR/gitweb_config.perl, /etc/gitweb.conf
>>
>> might fit better with the pattern established by gitattributes(5) an=
d
>> its kin.
>
> I thought that's how I had originally put it.

I take that as a "yes, it would work better".

To save others the trouble of digging previous rounds up for
comparison:

 - the original: http://thread.gmane.org/gmane.comp.version-control.git=
/173422
 - v2: http://thread.gmane.org/gmane.comp.version-control.git/174700/fo=
cus=3D174701
 - v3: http://thread.gmane.org/gmane.comp.version-control.git/175140/fo=
cus=3D175145

The original had one line but it didn't mention
$GITWEBDIR/gitweb_config.perl.  So we are slowly converging.

[...]
>>> +The configuration file is used to override the default settings th=
at
>>> +were built into gitweb at the time 'gitweb.cgi' script was generat=
ed.
>>> +
>>> +While one could just alter the configuration settings in the gitwe=
b
>>> +CGI itself, those changes would be lost upon upgrade.
>>
>> What if I upgrade using RCS "merge"? :)  So maybe:
>>
>> 	s/one could just alter/one can alter/
>> 	s/would be lost/could be lost/
>>
>> to clarify that (1) editing the CGI script is allowed and fine but (=
2)
>> it might be a pain to keep those changes.
>
> The point of this was originally if you were a mere mortal then upgra=
des
> of the gitweb CGI would flush all of the settings you just spent a we=
ek
> getting right down the drain. That's the point of the stronger langua=
ge.
> It's meant to be a solid "If you do it that way you can expect it to
> hurt" message.

Sorry, I suppose I was unclear.  All I meant is that as a na=C3=AFve
reader, I found myself losing trust with "those changes would be lost
upon upgrade".  Oddly enough, by contrast something like:

	While it would be possible to change the gitweb CGI directly
	instead, DON'T DO THAT!  Your changes would be lost on upgrade!

would have worked fine for me, since there are enough cues to know I
am reading hyperbole rather than an explanation of mechanism.

Anyway, it was just how I read it, and it's likely my proposed change
would have made it worse in some other way.

>>> Configuration
>>> +settings might also be placed into a file in the same directory as=
 the
>>> +CGI script with the default name 'gitweb_config.perl' -- allowing
>>> +one to have multiple gitweb instances with different configuration=
s by
>>> +the use of symlinks.
>>
>> Might also in addition to what? =20
>
> This comment is nonsensical, please clarify it.

I found the sentence starting with "Configuration settings" hard to
understand because the "also" didn't have an obvious antecedent.
Therefore I proposed some alternative phrasing:

>> Continuing the thought from before:
>>
>> 	So gitweb allows settings to be placed in a separate file named
>> 	'gitweb_config.perl' in the same directory as the CGI script.
>> 	This also allows one to set up multiple gitweb instances with
>> 	different configurations by using symlinks to a common gitweb.cgi
>> 	script.
>
> How is this any different from what I wrote?

I'm starting to sense annoyance.  Please feel free to ignore my
comments if you think they're unhelpful; they're meant as a gift, not
demands.

Anyway, the difference is in phrasing.  Saying "So" is meant to make
the relationship to the previous sentence clearer: we are explaining
the purpose of the configuration file, by contrasting it with editing
the CGI script directly.  The next sentence is a separate thought, so
I thought it might be clearer to put it in a separate sentence.

>>> +DISCUSSION
>>> +----------
>>
>> First, as a general thought, by the time I get this far I start
>> thinking, "so where's the list of possible settings?".  But there ar=
e
>> certainly some more basic pieces of information to cover before then
>> (like the global configuration file), so I think this part is in the
>> right place.  It just could benefit from being a little shorter.
>
> I used resolv.conf(5) as the model here. I realized that without a
> little introduction most of the settings and the way they are applied
> didn't make a heck of a lot of sense if you've never seen them before=
=2E

Yes, I think the general structure is good.

>>> +The location of system-wide gitweb configuration file is defined a=
t compile
>>> +time using the configuration value `GITWEB_CONFIG_SYSTEM` and defa=
ults to
>>> +'/etc/gitweb.conf'.  The name of the per-instance configuration fi=
le is
>>> +defined in gitweb by `GITWEB_CONFIG`, and defaults to 'gitweb_conf=
ig.perl'
>>> +(relative path means located in the same directory gitweb is insta=
lled).
>>
>> Maybe:
>>
>> 	In addition to the per-instance configuration file, there can
>> 	be a system-wide configuration file to act as a fallback when
>> 	the per-instance configuration file does not exist.
>>
>> 	The system-wide configuration file is named /etc/gitweb.conf
>> 	by default.  Filenames for the system-wide and per-instance
>> 	configuration variables can be overridden at compile time and
>> 	run time; see the FILES section for details.
>
> This is the manpage for the system wide configuration file. If you'd
> like to scrap this effort in favor of something else please speak up.

Huh?

>>> +*NOTE:* If per-instance configuration file ('gitweb_config.perl') =
exists,
>>> +then system-wide configuration file ('/etc/gitweb.conf') is _not u=
sed at
>>> +all_!!!
>>
>> Over the top. :)  I think the best way to document this is to contra=
st
>> it with /etc/gitweb-common.conf once the latter exists.
>
> If we were to change gitweb to handle configuration files like the re=
st
> of git (and in fact like most things we deal with daily, where settin=
gs
> are overridden one by one) then this section becomes moot. Until or
> unless that becomes the case it is important to loudly make note of i=
t.=20

Does using three exclamation marks and italics make it clearer?

Previously there was no manpage documenting this at all, so I think
explaining it is already a big and good step.  If this needs to be
so prominent that people just skimming through will notice it, then
I'd suggest putting it in the DESCRIPTION section higher up.  But I'm
not the one writing this; others are free to disagree.

>>> +The syntax of the configuration files is that of Perl, as these fi=
les are
[...]
>>> +page for more information.
>>
>> Duplicates DESCRIPTION.
>
> Perhaps it does, but not everybody is a Perl coder. It was that way i=
n
> the text I started from and I saw little point in changing it.

No, the paragraph is actually repeated from the DESCRIPTION section.

[...]
>>> +The default configuration with no configuration file at all may wo=
rk
>>> +perfectly well for some installations.  Still, a configuration fil=
e is
>>> +useful for customizing or tweaking the behavior of gitweb in many =
ways, and
>>> +some optional features will not be present unless explicitly enabl=
ed using
>>> +the configurable `%features` variable (see also "Configuring gitwe=
b
>>> +features" section below).
>>
>> I suppose this is based on the text
>>=20
>> 	The most notable thing that is not configurable at compile time are=
 the
>> 	optional features, stored in the '%features' variable.
>>=20
>> I'd suggest removing the paragraph.
>
> The motivation for this paragraph was actually the innumerable tutori=
als
> out there which tell people to mangle the CGI directly because:
> (1) There didn't seem to be a standard documented configuration file
> (2) There wasn't an appropriate place to shove %features settings tha=
t
> the author could find.
> (3) It really needed to be said that you might not actually have to m=
ess
> with anything.
>
> Apparently you think that clearing these misconceptions up is a usele=
ss
> exercise, or at least it sounds a lot like it.

What?  I wrote exactly what I was thinking, which was that I thought th=
is
paragraph was based on the text I quoted from gitweb/INSTALL and that
contrasting the run-time and compile-time configuration as that
paragraph did didn't seem very important for the installed manpage
(since the reader might not have been involved in the installation at
all).

If the point was actually to say "Contrary to popular belief, you can
set %features in the configuration file instead of hard-coding it in
the CGI script itself", why not say that directly?

[...]
> I cannot keep up with this pace of patching right now.

No problem.  For what it's worth, I skipped a couple of rounds of
reading, too; I suppose they came quickly.  Does that mean you don't
want to be cc-ed on later incarnations of the patch, or would you like
to stay notified?

It seems my review was not very useful; sorry about that.  Thanks for
some clarifications.

Ciao,
Jonathan
