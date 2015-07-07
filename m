From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: undocumented =?UTF-8?Q?core=2EsharedRepository=3D=32=20set=20?=
 =?UTF-8?Q?by=20git=20init=20--shared=3Dworld?=
Date: Tue, 07 Jul 2015 13:32:13 +0200
Organization: gmx
Message-ID: <b1139f60dde3533e12d13e4b0f6584f2@www.dscho.org>
References: <20150706192547.GA15396@kitenet.net>
 <b9f56a351da062698ad629d77d3752b7@www.dscho.org>
 <20150707091044.GC18226@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Joey Hess <id@joeyh.name>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jul 07 13:34:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCR94-0004E3-Ua
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 13:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876AbbGGLef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 07:34:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:55917 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756773AbbGGLed (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 07:34:33 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lb4vZ-1YjNo73Sx7-00kejh; Tue, 07 Jul 2015 13:32:14
 +0200
In-Reply-To: <20150707091044.GC18226@serenity.lan>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:DpLgbS2LGIqLXvXgMibIo3hm1RGWP6CDRynjHlIykUdj7J6QjZS
 lj1+kMjDsH69Yg4NsBGSqzm5eM+z98nGfls1QC9pFq+Bwzqfi51JtPdZ8MmUy31dntsaW5M
 nJaLFgpe5h/3K0C1DiJUJMTrN6gghDdRkHbQCH0eoLqs4HIDwwAZyYZHDvGSwaY0jBAy5/K
 2SpE9tm0HqBZF2ZGQO9fQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cg4kmpeNamw=:7Cw43OpWaVhIge2o+YI0s6
 DmoudR2ww5DbsvgbDvl80QlNJ4sl7AWeRb7MdEOYCmWPOJzHLzqdWtlk920QoSJVplj+I9cOb
 1VntvLIO02K+66NpYTS19O6Ubz8c20pYRACMPK6BVJcfVGB9I4TrKXuYR9WnFqv6Kkk05i4/B
 Fe9tkVjy8k23a3bvZUXSw9UNcrOVLH+/EKHEYUtmylfoFKz7h5THavn2h5v+wEOBJLns4mAl2
 ZoGnlTZ509CWOYQs2GSwot1mZ6KlZn41s2HDCzt+4o2tuxrSdAn9d8V/fecgsEraNWT9Pwxnd
 hRi8qLI107UydIMp+I+yzNnpwT6uUiOxgzgoZ9kIFiEtahTwXwIG+4ZvAtakzyhSzwJ/ERIVK
 B5/7LaVFdiKXD40HHAFIzuhNzgWCik9ldSZ+tqP1FUBx5Dz9XtYPHO/IeAwI07fHiw+aP8m9r
 wS5joaXDLrHLKCt97l/vc7Iu2e9DoROLOfon3BlbdDnRMDwLOWma9ua4d+s0MhX3Zkb9UNvVA
 Sq2QSZ39a0YvvQNDDsbwrgPzv7LAr65qi2VyvqEpL9DC4ihcWrRDSDD77b5eppU0wCTUFsdxH
 Z1AnpViRRhhW4kiSn4H+cETJqbVXE2RYMPtGk55c0OajuUX+cWC/QEuwQMiuibqI9yDEF8iQ+
 pdqom/OapGleZdhe/n/9v+F5eK499L4UGJ7v2B/3wg4cqqTt0voSNUrKN67gjKfAn5xA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273496>

Hi John,

On 2015-07-07 11:10, John Keeping wrote:
> On Tue, Jul 07, 2015 at 10:14:28AM +0200, Johannes Schindelin wrote:
>> Hi Joey,
>>
>> On 2015-07-06 21:25, Joey Hess wrote:
>> > joey@darkstar:~/tmp>git init --shared=world testrepo
>> > Initialized empty shared Git repository in /home/joey/tmp/testrepo/.git/
>> > joey@darkstar:~/tmp>grep shared testrepo/.git/config
>> > 	sharedrepository = 2
>> >
>> > This magic value of 2 seems to be undocumented, as is the magic value of 1
>> > that's equvilant to "group".
>> >
>> > I think it would be better to have git init put in "world" or "group" and not
>> > these magic values. Anyway, I suppose they ought to be documented too.
>>
>> The rationale can be found here:
>> https://github.com/git/git/blob/v2.4.5/builtin/init-db.c#L413-L418
>>
>> 		/* We do not spell "group" and such, so that
>> 		 * the configuration can be read by older version
>> 		 * of git. Note, we use octal numbers for new share modes,
>> 		 * and compatibility values for PERM_GROUP and
>> 		 * PERM_EVERYBODY.
>> 		 */
>>
>> I am sympathetic to your wish, of course, and I am sure that you
>> understand why we cannot simply break other people's setups to satisfy
>> it.
> 
> That comment was added in 94df250 (shared repository: optionally allow
> reading to "others"., 2006-06-09) which was in 1.4.1.  I suspect that is
> now sufficiently old that it no longer matters.

I understand your point of view. With my maintainer hat on I have to say, though, that things like that require a major version change. Users tend to appreciate such a careful maintenance.

Ciao,
Johannes
