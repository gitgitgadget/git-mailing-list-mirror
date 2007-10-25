From: Andreas Ericsson <ae@op5.se>
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 22:23:42 +0200
Message-ID: <4720FB4E.3030300@op5.se>
References: <86oden6z97.fsf@blue.stonehenge.com> <20071025150107.GB31196@diana.vm.bytemark.co.uk> <alpine.LFD.0.9999.0710251344220.22100@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 22:24:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il9FF-0002Uu-PZ
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 22:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbXJYUXr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2007 16:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbXJYUXr
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 16:23:47 -0400
Received: from mail.op5.se ([193.201.96.20]:46839 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbXJYUXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 16:23:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 570001730725;
	Thu, 25 Oct 2007 22:23:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3EfNHDLNsjuy; Thu, 25 Oct 2007 22:23:20 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 943321730723;
	Thu, 25 Oct 2007 22:23:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <alpine.LFD.0.9999.0710251344220.22100@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62369>

Nicolas Pitre wrote:
> On Thu, 25 Oct 2007, Karl Hasselstr=F6m wrote:
>=20
>> On 2007-10-25 07:32:36 -0700, Randal L. Schwartz wrote:
>>
>>> And when are we gonna get "fast forward only" for git-merge?
>> I'd like that too. For cases when I know I don't have to do a merge,
>> and want git to yell at me if I'm mistaken. For example, in a
>> repository that tracks an upstream so I can build the latest version=
,
>> but where I don't normally do any development.
>=20
> Isn't that called a remote branch that gets updated with "git fetch' =
?
> You can even trick Git into not using the refs/remotes/ namespace for=
=20
> them if you wish.
>=20

You'd lose the ability to do "git diff origin/master" while disconnecte=
d
though. It's quite valuable.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
