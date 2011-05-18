From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: Re: Windows permissions with repository on a network share
Date: Wed, 18 May 2011 12:10:34 +0200
Message-ID: <4DD39B1A.2030401@brefemail.com>
References: <iqu417$qnj$1@dough.gmane.org> <BANLkTikb4Q9ZmG-ToaV5LXLzfrcBu58PUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 12:12:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMdkA-0004RU-ON
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 12:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879Ab1ERKMg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 06:12:36 -0400
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:58660 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620Ab1ERKMf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 06:12:35 -0400
X-WhiteListed: mail was accepted with no delay
X-WhiteListed: mail was accepted with no delay
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id BF75D3925A
	for <git@vger.kernel.org>; Wed, 18 May 2011 12:11:03 +0200 (CEST)
X-Originating-IP: 217.70.178.129
Received: from mfilter12-d.gandi.net (mfilter12-d.gandi.net [217.70.178.129])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 34BF0A808B;
	Wed, 18 May 2011 12:10:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter12-d.mgt.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter12-d.gandi.net (mfilter12-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id F310Jf6eSu3F; Wed, 18 May 2011 12:10:33 +0200 (CEST)
X-Originating-IP: 92.103.70.98
Received: from [172.25.72.8] (unknown [92.103.70.98])
	(Authenticated sender: jl-principal@jay-el-soft.net)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C2257A808F;
	Wed, 18 May 2011 12:10:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; fr; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <BANLkTikb4Q9ZmG-ToaV5LXLzfrcBu58PUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173869>

Le 18/05/2011 10:52, Sitaram Chamarty a =C3=A9crit :
> On Tue, May 17, 2011 at 8:55 PM, Jerome Lovy
> <t2a2e9z8ncbs9qg@brefemail.com>  wrote:
>> Hello,
>>
>> Did anyone experiment with Windows permissions for a Git repository =
located
>> on a Windows network share?
>>
>> Is it a sensible scheme in order to have a central repository with A=
CLs
>> (notably some group can read/write, some other group can only read) =
without
>> the need to set up a dedicated server (ala Gitolite) ?
>> (Assuming a Windows network share infrastructure is already in place=
=2E..)
>
> I don't know about Windows but any OS/file-system level ACL system
> that has more granularity than the usual user/group/other, ought to
> work fine.
>
> The only thing gitolite can add is branch-level permissions, which it
> doesn't sound like you need.
>
> [Of course, I like to think that the config file in gitolite is a muc=
h
> cleaner way of setting, reviewing, changing, and tracking changes of,
> permissions, but I'm biased ;-)]

In this respect, Gitolite has a good point indeed with the auditing=20
possibility, thanks to change tracking.
