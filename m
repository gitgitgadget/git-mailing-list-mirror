From: Lanoxx <lanoxx@gmx.net>
Subject: Re: Git to use XDG Base Directory Standard
Date: Thu, 23 Aug 2012 09:22:36 +0200
Message-ID: <5035DA3C.4030404@gmx.net>
References: <50355044.7040201@gmx.net> <871uiy8uuw.fsf@centaur.cmartin.tk> <CAJDDKr6Jh0c9W1coQLOqrQKW-X7CCF9t_Nr2pW-7ivh0Ae9xrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 09:22:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Rkf-0008Vx-Jp
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 09:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933265Ab2HWHWo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Aug 2012 03:22:44 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:40065 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933213Ab2HWHWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 03:22:42 -0400
Received: (qmail invoked by alias); 23 Aug 2012 07:22:40 -0000
Received: from chello084112131062.3.11.vie.surfer.at (EHLO [192.168.0.22]) [84.112.131.62]
  by mail.gmx.net (mp070) with SMTP; 23 Aug 2012 09:22:40 +0200
X-Authenticated: #2691801
X-Provags-ID: V01U2FsdGVkX1+e9t5OH3eeegavbA+lSDasLzuDRxuQTlSMbunU3J
	NnVIhz0fZVRHyI
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <CAJDDKr6Jh0c9W1coQLOqrQKW-X7CCF9t_Nr2pW-7ivh0Ae9xrw@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204113>


On 23/08/12 04:57, David Aguilar wrote:
> On Wed, Aug 22, 2012 at 2:44 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.=
de> wrote:
>> Lanoxx <lanoxx@gmx.net> writes:
>>
>>> Hi,
>>>
>>> Git and Gitk are currently using the ~/.gitconfig and ~/.gitk files=
 in
>>> the $HOME directory. It would be nice to use the XDG Base Directory
>>> standard for the location instead, see [1] and [2]. Are there any
>>> plans regarding this standard?
>> Git does this starting at 1.7.12. See the release notes, e.g. at
>> https://github.com/git/git/blob/master/Documentation/RelNotes/1.7.12=
=2Etxt#L18-23
>>
>>     cmn
> I do not recall whether gitk learned about it (I don't think so).
>
> Like all big sweeping changes, these were done in a
> backwards-compatible way that will allow users to switch over when
> they are ready.  If you are interested in attacking this from the git=
k
> angle then you will want to follow a similar strategy.

I just checked it, the code is in=20
https://github.com/git/git/blob/master/gitk-git/gitk:2710 and following=
=2E=20
Currently it still saves it to ~/.gitk-new and then renames it to ~/.gi=
tk

Unfortunately I do not know Tcl/Tk so I can't provide a patch. But if=20
someone could provide a patch that would be really nice.
