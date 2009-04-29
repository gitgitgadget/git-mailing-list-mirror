From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: (topgit question) deleting a dependency
Date: Wed, 29 Apr 2009 12:15:50 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngvgh7m.isk.sitaramc@sitaramc.homelinux.net>
References: <slrngvdgo4.kr7.sitaramc@sitaramc.homelinux.net>
 <20090428094138.GB9415@piper.oerlikon.madduck.net>
 <20090428204018.GA17722@pengutronix.de>
 <slrngvf976.65c.sitaramc@sitaramc.homelinux.net>
 <20090429082410.GB18521@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 14:16:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz8i1-00063o-W4
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 14:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645AbZD2MQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 08:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbZD2MQI
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 08:16:08 -0400
Received: from main.gmane.org ([80.91.229.2]:47836 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbZD2MQH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 08:16:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lz8hp-00037V-Cf
	for git@vger.kernel.org; Wed, 29 Apr 2009 12:16:05 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 12:16:05 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 12:16:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117878>

On 2009-04-29, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrot=
e:
> Hello Sitaram,
>
> [mmh, your mail didn't have me in the addressees, wonder why.]

Sorry - I'm using gmane over slrn (NNTP) from a work server!
Slrn splits the "nntp post" and sends it to gmane, which is
quite happy to post on behalf of sitaramc@gmail.com (my
personal address) but slrn then tries to deliver the "cc"
part using my local (work) mailer, with my work email
address as the "From".  I'm explicitly cc-ing you now, so to
you the email will appear to come from my work address.
Sorry about that!

>> This is a little beyond my comprehension :(  However, this
>> is also why I am limiting myself to
>>=20
>>   - a single level of dependencies in tg, (master -->
>>     multiple t/something --> t/all), and
>>=20
>>   - no changes of its own in t/all
>>=20
>> When any of the t/something graduates to master, t/all will
>> be blown away (safe, since it has no changes of its own) and

> What makes you think it will "be blown away"?  Or alternatively, what=
 do

My mistake.  I meant that I will blow it away myself, and
create a new one with the same name except it's list of deps
will exclude the one that graduated.

> you mean saying that?  I often use the same approach and I never had =
the
> feeling anything is blown away.  If upstream uses your t/something pa=
tch
> it just merges into t/something making it empty without changing the

How?  When I update master from upstream and then tg update
on t/all?

> corresponding tree (assuming master contains no other changes).  Then
> when t/something is merged into t/all nothing happens, because
> t/something's tree didn't change.
>
> So the only thing is that t/all depends on an empty tg-branch.

Regards,

Sitaram
