From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 19:10:55 +0200
Message-ID: <4720CE1F.3030902@op5.se>
References: <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <471FBF29.8030802@op5.se> <Pine.LNX.4.64.0710242315310.25221@racer.site> <47204ECA.7040309@op5.se> <Pine.LNX.4.64.0710251108330.25221@racer.site> <47206EC3.5000002@op5.se> <Pine.LNX.4.64.0710251232370.25221@racer.site> <4720903E.1070103@op5.se> <20071025145132.GA31196@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 19:11:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il6El-0001Z8-An
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 19:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbXJYRLA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2007 13:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbXJYRLA
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 13:11:00 -0400
Received: from mail.op5.se ([193.201.96.20]:45081 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbXJYRK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 13:10:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B4E471730719;
	Thu, 25 Oct 2007 19:11:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lqGclcXaCnbw; Thu, 25 Oct 2007 19:11:06 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 932BF17306F3;
	Thu, 25 Oct 2007 19:11:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071025145132.GA31196@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62337>

Karl Hasselstr=F6m wrote:
> On 2007-10-25 14:46:54 +0200, Andreas Ericsson wrote:
>=20
>> error: The branch 'next' is not a strict subset of your current
>> HEAD. If you are sure you want to delete it, run 'git branch -D
>> next'.
>>
>> So you want me to tell all the developers they should use "git
>> branch -D maint" instead, so they can bypass the built-in security
>> checks? No thanks.
>=20
> Maybe the solution here is to let "git branch -d" succeed if the
> branch is a subset of HEAD or the branch it is tracking? That way,
> deleting would succeed if upstream has all your commits.
>=20

Deleting branches sitting on a ref reachable from any other locally
checked out branch certainly works. Since this is done to protect
commits from being pruned, and prune honors remote tracking branches
when deciding which commits are unreachable, I see no harm in letting
branches pointing to commits reachable from any remote tracking branch
be deleted.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
