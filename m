From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] WinGit: include html pages from official git.git's html branch
Date: Sun, 30 Sep 2007 10:19:52 +0200
Message-ID: <D4E42E0D-99CB-4F4E-AC89-CD94DA061FDC@zib.de>
References: <A835C8E8-8EC5-43B7-9252-8709214DE7AD@zib.de> <11910819531200-git-send-email-prohaska@zib.de> <11910819542185-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0709292149280.28395@racer.site> <7vr6khjf22.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709300022080.28395@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 10:19:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibu1o-0001Yv-AG
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 10:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbXI3ITp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 04:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbXI3ITp
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 04:19:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:38114 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbXI3ITo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 04:19:44 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8U8IH6J020901;
	Sun, 30 Sep 2007 10:19:41 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db10737.pool.einsundeins.de [77.177.7.55])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8U8IGnF009711
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 30 Sep 2007 10:18:16 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0709300022080.28395@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59529>


On Sep 30, 2007, at 1:23 AM, Johannes Schindelin wrote:

> Hi,
>
> On Sat, 29 Sep 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> On Sat, 29 Sep 2007, Steffen Prohaska wrote:
>>>
>>>> It is assumed that a matching version of the html documentation is
>>>> available as the HEAD of /doc/git/html/.git. If not an error  
>>>> will be
>>>> reported.
>>>>
>>>> This patch doesn't include a mechanism to fetch the html pages to
>>>> /doc/git/html/.git. You should manually clone them. Maybe this  
>>>> could
>>>> handled as a submodule of msysgit?
>>>
>>> I'd rather handle it as in git.git, as another branch, and not check
>>> it out in /git/html/, but rather use "git read-tree
>>> --prefix=/tmp/WinGit/share/git/html origin/html", or some such.
>>
>> This is starting to smell like an opportunity to use the gitlink  
>> stuff,
>> isn't it?
>
> I'd agree that we could have a submodule in /doc/git/html/.  This way,
> even users of msysGit and GitMe would benefit.

And we could completely tag a WinGit release. The version of the
html docs included would be defined by the submodule's head in
/doc/git/html. This is what I had in mind when submitting the
patch. Maybe I didn't express this clearly.

I do not yet understand submodules sufficiently. Therefore I didn't
add a patch that actually sets up the submodule in /doc/git/html.
Maybe I'll do so later today.

	Steffen
