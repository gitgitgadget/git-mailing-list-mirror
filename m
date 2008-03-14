From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 11:39:10 +0100
Message-ID: <87iqzpfv3l.fsf@lysator.liu.se>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com> <57518fd10803140251v425a0fa3ud11687a5043806cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 11:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja7K4-0007Og-Kc
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 11:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbYCNKi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 06:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbYCNKi5
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 06:38:57 -0400
Received: from main.gmane.org ([80.91.229.2]:50330 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbYCNKi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 06:38:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ja7JK-0006jz-Ta
	for git@vger.kernel.org; Fri, 14 Mar 2008 10:38:50 +0000
Received: from 79.138.151.59.bredband.tre.se ([79.138.151.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 10:38:50 +0000
Received: from davidk by 79.138.151.59.bredband.tre.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 10:38:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 79.138.151.59.bredband.tre.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:JneHuopKm/ZfyrtXAKGG0u7fN/g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77202>

"Jonathan del Strother" <maillist@steelskies.com> writes:

> On Fri, Mar 14, 2008 at 9:46 AM, Geoff Russell
> <geoffrey.russell@gmail.com> wrote:
>> This should be simple! I have a series of commits:
>>
>>            1---2---3---4---5
>>
>>  I want to go back to 3 but not branch, so I want
>>
>>            1---2---3---4---5---3
>>
>>  ?
>>
>>          git checkout 3...
>>
>>  gets me the commit on a detached head, but I don't know how to put =
this back
>>  as the HEAD.
>
>
> Two options.  Either rewrite history, nuking commits 4 & 5 :
>   git reset --hard 3
>
> or publicly reverse the changes introduced by 5 & 4 :
>   git revert 5
>   git revert 4

The revert can be done by resetting to the tree in 3:

  git checkout 3 -- .
  git commit -m "reset to 3"

--=20
David K=C3=A5gedal
