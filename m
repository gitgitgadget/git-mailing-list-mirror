From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Fri, 18 Mar 2016 16:57:07 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603181656160.4690@virtualbox>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com> <1457548582-28302-19-git-send-email-dturner@twopensource.com> <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com> <alpine.DEB.2.20.1603151517590.4690@virtualbox>
 <1458151880.9385.1.camel@twopensource.com> <alpine.DEB.2.20.1603161923380.4690@virtualbox> <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com> <alpine.DEB.2.20.1603171536420.4690@virtualbox> <CACsJy8Dx4=igm3YVYkTDdRSxevDo2xRij9P5m7VPxkVrq3oq8Q@mail.gmail.com>
 <alpine.DEB.2.20.1603180815160.4690@virtualbox> <CACsJy8Bu6QyYmJpPHpEgDx5djt=9XjXzckzJKL_mx8yHeyHdCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 16:57:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agwm5-00005N-LJ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 16:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756804AbcCRP5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 11:57:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:51854 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755949AbcCRP5M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 11:57:12 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LcnRD-1Zym8J0kSd-00k6Mc; Fri, 18 Mar 2016 16:57:08
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8Bu6QyYmJpPHpEgDx5djt=9XjXzckzJKL_mx8yHeyHdCA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:iNAOltpMdwdo9uxNRFlSFUJHrKXixtR5LJ7/z1ra97x3KoSTSNG
 TOk9eMh5IECeZ+3urYSlkTNO7edhLtZzi+Cy55ljJbw0dhth2ziEr1ZnAuUdVwNnxQM3uPR
 SEjevXxLZBDuegBH/3HUciTDjcjrqYna0tYMBICfWlcB8Z2uV5JpTcPiUc+xxlf3HMEi6dZ
 9qwQu09P1KHOv6qELW7LA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:76p3iTBjEaI=:u1MGKmaSVEHGKwNphE4XAZ
 vxZz/xCaKCNmye4vyQ5/133SbDPmFx5d0cZdj4KVze8v96hqxoo/CjE3bqUDBc3uydC2qBGwL
 1zJSHltNsXTajX3E34wEh9k9XKzLGZhxQik/lJkBJ4fREKN89HhkERCP54MfBshR5AYmSdIHb
 jFiLcNZL92xZauKIVFHNdfLgsmkVUYeJmSEY7ZmcdMBKh9KG1UFf+zRLAPcrH+oe6D4eAoTbx
 v2O6aVKgBc+iaiGHDG0lbntyimL00TMPEdenlTgzHXsRvIgbQH8yoRU30tbY1ch7UilUSQrUN
 BQxB4amUBa/kHD1WbJLfWWlsLQmc4BjSEnyD/zRguy/RN5vXpWhxBLB42cybUp6clv+xHAWvH
 /Y+8ZTpuwNnrz9vc9SnkJ8GQMyjV2Nkp4gu4PCPeAP16psLMB+bR1n59VTqYSlbmnEE/KY3oZ
 5phSPQisOoHJcbYOLWePUcOxQOTchxZC2V6FdUXcloCmKuecyJSDQzLnYGW2ajkOCgcByB7Cl
 m5tDB8GRp5sc6MchZHU/zGKOcVvJP8dfi3/iNV1BYRJuV9ALkKTJRtPjCyo9cPaHh54HaEpUy
 6uKCZugDqS4V8ptpCM1yXTlKEMxi5oAUG+ZQ+/QJUvUm9QSX4W1ashrtyzYWGXBFrlJMaYGa1
 2NVv54Jsr63u5LqncEWS6VNBjzqTdolA226YkKIe8slQPuA29Qd4II/1WzGwCuEDJKsesfjHu
 jxQkXWxrxE+iyTtjdWb/OrU0wuJJh6el4ns+iMriloAZU1Rwox4pmGM6WvH7C8YXzA7S/PMN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289228>

Hi Duy,

On Fri, 18 Mar 2016, Duy Nguyen wrote:

> On Fri, Mar 18, 2016 at 2:17 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 18 Mar 2016, Duy Nguyen wrote:
> >
> >> > Well, the way I read the code it is possible that:
> >> >
> >> > 1. Git process 1 starts, reading the index
> >> > 2. Git process 2 starts, poking the index-helper
> >> > 3. The index-helper updates the .pid file (why not set a bit in the shared
> >> >    memory?) with a prefix "W"
> >> > 4. Git process 2 reads the .pid file and waits for the "W" to go away
> >> >    (what if index-helper is not fast enough to write the "W"?)
> >> > 5. Git process 1 access the index, happily oblivious that it is being
> >> >    updated and the data is in an inconsistent state
> >>
> >> No, if process 1 reads the index file, then that file will remain
> >> consistent/unchanged all the time. index-helper is not allowed to
> >> touch that file at all.
> >>
> >> The process 2 gets the index content from shm (cached by the index
> >> helper), verifies that it's good (with the signature at the end of the
> >> shm). If watchman is used, process 2 can also read the list of
> >> modified files from another shm, combine it with the in-core index,
> >> then write it down the normal way. Only then process 1 (or process 3)
> >> can see the new index content from the file.
> >
> > So how do you deal with releasing the shared memory instances that are
> > essentially created for every index update?
> 
> When index-helper reads the index file and realizes the file has been
> updated (based on trailing SHA-1), it unlink()s the old shm and
> prepares new shm. If no process is accessing old shm, it's gone. If
> not, it stays until nobody elses uses it. shm on Windows behaves the
> same way, I believe.

Ah. On Windows, you do not even have to unlink: once the last user's gone,
the shared memory's gone, too.

Ciao,
Dscho
