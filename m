From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: (topgit question) deleting a dependency
Date: Wed, 29 Apr 2009 00:52:54 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngvf976.65c.sitaramc@sitaramc.homelinux.net>
References: <slrngvdgo4.kr7.sitaramc@sitaramc.homelinux.net>
 <20090428094138.GB9415@piper.oerlikon.madduck.net>
 <20090428204018.GA17722@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 02:53:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyy3a-0000x9-KL
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 02:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbZD2AxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2009 20:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbZD2AxK
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 20:53:10 -0400
Received: from main.gmane.org ([80.91.229.2]:58767 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753410AbZD2AxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 20:53:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lyy2u-0000Jo-CO
	for git@vger.kernel.org; Wed, 29 Apr 2009 00:53:08 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 00:53:08 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 00:53:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117840>

On 2009-04-28, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrot=
e:

> On Tue, Apr 28, 2009 at 11:41:38AM +0200, martin f krafft wrote:
>> also sprach Sitaram Chamarty <sitaramc@gmail.com> [2009.04.28.1049 +=
0200]:
>> [...]
>> > I know "tg depend" only has the "add" subcommand right now,
>> > but is there a manual way of getting the effect of a
>> > hypothetical "tg depend remove"?
>>=20
>> No, not yet, see http://bugs.debian.org/505303 for further
>> discussion on the issue.
> But note that you might get some problems after doing that.  See
>
> 	http://thread.gmane.org/gmane.comp.version-control.git/116193/focus=3D=
116205

Hello Uwe,

This is a little beyond my comprehension :(  However, this
is also why I am limiting myself to

  - a single level of dependencies in tg, (master -->
    multiple t/something --> t/all), and

  - no changes of its own in t/all

When any of the t/something graduates to master, t/all will
be blown away (safe, since it has no changes of its own) and
a new t/all created with the new set of dependencies.

I'm pretty sure this will work -- you could say I'm using tg
to automate the "throw-away merge" work flow.

Thanks,

Sitaram
