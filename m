From: Mathias Weber <mweb@gmx.ch>
Subject: Re: [PATCH] tag: add --author option
Date: Tue, 27 Mar 2012 23:11:52 +0200
Message-ID: <4F722D18.50502@gmx.ch>
References: <4F71E415.9030800@gmx.ch> <4F71F902.8090200@in.waw.pl> <4F7223D0.5000801@gmx.ch> <7vr4wdhilj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 23:12:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCdgK-0006xt-5a
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 23:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479Ab2C0VLv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 17:11:51 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:53241 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753633Ab2C0VLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 17:11:51 -0400
Received: (qmail invoked by alias); 27 Mar 2012 21:11:49 -0000
Received: from 214-171.5-85.cust.bluewin.ch (EHLO [192.168.12.190]) [85.5.171.214]
  by mail.gmx.net (mp041) with SMTP; 27 Mar 2012 23:11:49 +0200
X-Authenticated: #1340516
X-Provags-ID: V01U2FsdGVkX18aZ3gJuHMaL0UyyIHzfdFGB76v/IPlP893Hy7TP2
	NbD1F5/UmqVWYx
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120310 Thunderbird/11.0
In-Reply-To: <7vr4wdhilj.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194087>

On 27.03.2012 22:52, Junio C Hamano wrote:
> Mathias Weber <mweb@gmx.ch> writes:
>=20
>> On 27.03.2012 19:29, Zbigniew J=C4=99drzejewski-Szmek wrote:
>>> On 03/27/2012 06:00 PM, Mathias Weber wrote:
>>>>
>>>> The tag command does not support the --author option as the
>>>> commit command. This adds the --author option to create
>>>> annotated tags with a different author.
>>>
>>> Consistency is good.
>>
>> It would be good but during the rework of the patch I realized that =
for
>> the tag the committer is and should be used and not the author.
>> Therefore it is fine that this option isn't available. I'm sorry
>> bothering you.
>=20
> I would have thought that being able to lie about "tagger " would be
> equivalent to lying about --author of the commit.  What am I missing?
>=20
> Not that I am enthused by the idea of having to add another option.  =
I
> would be perfectly happy if we did not add such a flag.  It is just I=
 do
> not understand the reasoning behind the retraction.
>=20

Yes this was what I first though as well but isn't the tagger similar t=
o
the committer? With the --author option we change only the author of a
commit and not the committer. To change the committer you have to
provide the env variable GIT_COMMITTER_NAME and GIT_COMMITER_EMAIL or
change the config file. I haven't found a option to change the
committer. I think the tagger is about the same as the committer. It
make sens to have a committer and an author for a commit and this might
not even be the same person but for a tag there is only the tagger.
Which is the person how makes the tag.

Mathias
