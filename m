From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Adding files to a git-archive when it is generated, and whats the 
	best way to find out what branch a commit is on?
Date: Wed, 29 Jul 2009 11:33:04 +0200
Message-ID: <adf1fd3d0907290233y78514f98h89a2fca7bf68b4f2@mail.gmail.com>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
	 <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com>
	 <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 11:33:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW5XD-0004FC-05
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 11:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbZG2JdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 05:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZG2JdI
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 05:33:08 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:44406 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbZG2JdH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 05:33:07 -0400
Received: by ewy26 with SMTP id 26so673732ewy.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 02:33:04 -0700 (PDT)
Received: by 10.216.52.76 with SMTP id d54mr2368718wec.119.1248859984550; Wed, 
	29 Jul 2009 02:33:04 -0700 (PDT)
In-Reply-To: <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124337>

2009/7/29 demerphq <demerphq@gmail.com>:
> 2009/7/29 Santi B=E9jar <santi@agolina.net>:
>> 2009/7/29 demerphq <demerphq@gmail.com>:
>>> Another question is whether anyone has any advice on the best way t=
o
>>> find out the "best" branch an arbitrary commit is on. Where best ca=
n
>>> be flexibly definied to handle commits that are reachable from
>>> multiple branches. =A0I have hacked a solution involving git-log an=
d
>>> grep, but it performs quite poorly. I was wondering if there is a
>>> better solution.
>>
>> The "best" tag is easy: git describe commit. For branches I think yo=
u
>> could use "git name-ref --refs=3Drefs/heads/* commit", because git
>> describe does not have a --branches flag.
>
> Dang, I guess this is from a newer release than mine. So now i have a=
n
> excuse to upgrade.

No, it is quite old (the --refs flag since the v1.5.1). If the problem
is that you don't find the "git name-ref" command is because it is
"git name-rev", oops.

Santi
