From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git doesn't save capitalization change in file names.
Date: Tue, 12 Jan 2016 09:02:21 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601120900380.2964@virtualbox>
References: <CAMkNX-K=GQ6LkZv2PS5Pfs+v2bN1ozi9P5ZN4Z60Ba-3JtuRkg@mail.gmail.com> <CAH5451=-RkyYs3UJHUvvYHSrNODzW4dmAQDHU_Jo-Wf4Oa7Dew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Daniil S <ds98s3a@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 09:02:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aItuN-0003rh-Os
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 09:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759706AbcALICY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 03:02:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:50240 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758017AbcALICX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 03:02:23 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LsChr-1aBvwg3S2R-013w1n; Tue, 12 Jan 2016 09:02:21
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAH5451=-RkyYs3UJHUvvYHSrNODzW4dmAQDHU_Jo-Wf4Oa7Dew@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:eGrtV+NA7Uz5qyGNxqUB2ZxvS1fom3THSQPFwh9MJdqjYj8vppZ
 xwJdv84W9dOTgxQYKbvUbXDqN7qNsrRp+cZIDOEPk6y9OBugUyyP8NaccePdJD3eks32HH6
 SZHsswyTpb8Kn6NANlHDAFvovQWJ0hEsouw+OeQ7Zl1J3pGfT1apJqcpV3S5+LCQrr0d3Rx
 a9K3kjb3rGRPdHcCD+gwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Uickjcm6Ac8=:v2XzkNxw+LhlAOmhcSHv9G
 X2/0wuD0iYRIU3eh4kbcttvC62cHhRRmi56Wv2PVjD+2sU52tezXDxn7rfbmshMziQD5nZHUK
 I/iNKZiqBf5gI8pMN+SHtfNc3sqBxyhzQHJeYWFqpiD/Dd1N768yto15GxE7cwlcgfznEPKsQ
 7SpLDPRpK0BWhJUF5JYcPCpruA2yq4rysKdQsA9bshSZdKUePR8nxiKwea2wp1GDi9bq87WYl
 P3TqLgskL+I6MgB/4w1d2XHz94DijbJkFFmkR9qzyr5gHxHI7PvkosRmicIU54fUWO2emJ7rc
 2amYB503uaDazHDfoayh6NwGPf4gMFWQfeXjyv9lK8kuktdvjT8t10k7ICgXkMcVih5gYKzcX
 pi8l7Q2Hyt5MTjQaz/x8kLFdU61atbz6DyuXrtNMKulV3oQI+n8h/vjEewR09RU9niBgzmIvP
 FSHsmgEZxe3Jmc4CTRk9incJp2LOpxZgclxADy3nPD1KbCnbPuaISh7Cq0vFRI21ZykHjcYHn
 P79sODY/3pNiOJfN9Qm1qKqqbsHyio4MpyFSRliaaNEIG9OYlmT4hqoKwDjQh/7sl1z/Rr1G4
 3cy6by0UljBXeNClDX6bXYs9rFLUbpGSs9yFNKiXzSEomAmRLe4fe8OhQSsMHlJKgoeSapHyR
 34qEqh6KnQRdKXb1049vj61Ti5v4Hdy/iRv25fptv7BB/NhyFm9LY7NGXJrLIbeT1Y0GCi9Ig
 C2HeJx5BYLG+f61ZaAWcnE1G3h1QfKRVsxjlZc+LGBb10YdxJEwszTd4uCN7rwgoj53JX+lM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283776>

Hi,

On Tue, 12 Jan 2016, Andrew Ardill wrote:

> On 12 January 2016 at 13:06, Daniil S <ds98s3a@gmail.com> wrote:
> >
> > So I've now encountered this with both GitHub and BitBucket, Windows
> > and Linux versions, so I'm fairly sure it's git's fault.

I highly doubt that the Linux variety of Git displays this problem, unless
it is run on a case-insensitive file system.

> > Example: if file named "Pathfinding.java" was renamed to
> > "PathFinding.java" and that change is then committed, filename won't
> > change in repository.
> 
> This actually comes down to the file system you use, as git itself does
> keep track of the capitalisation of file names; if the file system is
> case insensitive (Mac OSX being the typical example) then you can run
> into weird issues when files change case.
> 
> For example, the following two search results:
> 
> https://stackoverflow.com/questions/10523849/changing-capitalization-of-filenames-in-git
> 
> https://ocroquette.wordpress.com/2014/07/08/git-capitalization-of-file-names-and-name-conflicts/

I'd like to offer the most common work-around:

git mv Pathfinding.java Pathfinding.java.rename
git mv Pathfinding.java.rename PathFinding.java

Ciao,
Johannes
