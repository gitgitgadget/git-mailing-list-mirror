From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 00:32:58 +0200
Message-ID: <BANLkTimsWmtXzogjN4bPkhmV8K=y1c4AmA@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <7vwrig9ta7.fsf@alter.siamese.dyndns.org> <BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
 <7vsjt49stq.fsf@alter.siamese.dyndns.org> <BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:38:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFDNH-0008HF-FS
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 00:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760116Ab1D0WiR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 18:38:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36219 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab1D0WiQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 18:38:16 -0400
Received: by pvg12 with SMTP id 12so1442306pvg.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 15:38:15 -0700 (PDT)
Received: by 10.68.48.129 with SMTP id l1mr2823342pbn.112.1303943895813; Wed,
 27 Apr 2011 15:38:15 -0700 (PDT)
Received: by 10.68.55.163 with HTTP; Wed, 27 Apr 2011 15:32:58 -0700 (PDT)
In-Reply-To: <BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172283>

Hi,

Can we please split this debate into the two threads that have arisen?

a) git extensions (the original point)

b) git package manager


Let me give my unrequested opinion:

a) I like it. Mercurial has it. It requires more or less what Jon says
below: let's define a hierarchy of where to place the executables,
documentation, the extenions' porcelain (which IMHO would require one
directory per extension), etc

b) Please no. As a Debian developer, I'd rather see extensions
distributed as source, then I would package them. It's what Debian
(and other distributions) are doing now with Ruby gems, Python eggs,
etc: we provide packages for them so that you do not use gem, etc





On Wed, Apr 27, 2011 at 7:33 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> Hide quoted text -
> On Wed, Apr 27, 2011 at 3:17 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Jon Seymour <jon.seymour@gmail.com> writes:
>>
>>>> So if you have /home/js/bin on your $PATH, you can install your "g=
it-work"
>>>> script as /home/js/bin/git-work, and that should be sufficient.
>>>
>>> Yep, that's a start, but does not a a complete plugin architecture =
make :-)
>>
>> Please explain yourself.
>>
>
> So, I think at a very minimum, a plugin architecture should specify
> the file system layout of packages to be managed by a plugin/package
> manager.
>
> So, where to find scripts, where to find man pages, bash completions,
> configuration help etc.
>
> A slightly more functional architecture would provide support for
> unpacking package archives into a "standard" repository location and
> for removing unwanted plugins.
>
> A plugin architecture might specify a standard way to access
> extensions. (git blah is easy for local use, but what if a plugin
> grabs a "noun" that the core wants to use that "noun" itself in
> future. Perhaps gitx blah would be a better standard way to access
> extensions. But that is an aside, I am sure this question has been
> considered previously).
>
> An even more functional architecture would provide support for a
> global registry of plugins. I understand that git may not want to
> write its own package manager (how many times has that been done),
> but it'd be nice if competing "git package managers" had a standard
> target to deploy to.
>
> My thoughts about this are inspired by how the node project manages
> packages with its npm package manager and also the fact that I have
> several ideas on the boil at the moment that would definitely benefit
> from a standard way to manage these concerns.
>
> jon.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
