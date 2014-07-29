From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: "error: Tweaking file descriptors doesn't work with this MSVCRT.dll"
 on wine
Date: Tue, 29 Jul 2014 15:28:29 +0200
Message-ID: <53D7A17D.5010206@redhat.com>
References: <CACsJy8DFvTHieQc-nZL2h7JbQYc4Qkbx+Ouc297VpNeU=kNaoQ@mail.gmail.com> <53D73F7D.1010902@web.de> <53D7917B.8060100@redhat.com> <CACsJy8Att+O7fF-2mMjqkfm75yXihfJNWutGDAqUkZs34pKLGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:28:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7Rf-00039w-HD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbaG2N1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:27:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46798 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737AbaG2N1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:27:43 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6TDRgPx014892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2014 09:27:42 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.33.193.1])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s6TDRe5n025880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 29 Jul 2014 09:27:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <CACsJy8Att+O7fF-2mMjqkfm75yXihfJNWutGDAqUkZs34pKLGw@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254432>

On 07/29/2014 03:05 PM, Duy Nguyen wrote:
> On Tue, Jul 29, 2014 at 7:20 PM, Michael Stefaniuc <mstefani@redhat.c=
om> wrote:
>> On 07/29/2014 08:30 AM, Torsten B=C3=B6gershausen wrote:
>>> On 07/28/2014 12:39 PM, Duy Nguyen wrote:
>>>> I know wine is kind of second citizen but is there a cheap trick t=
o
>>>> make it work on wine? Reverting fcd428f (Win32: fix broken pipe
>>>> detection - 2012-03-01) could result in conflicts in compat that I=
'm
>>>> not comfortable resolving. I don't have Windows at home. Wine is t=
he
>>>> only option for me (or if somebody has a modern.ie image for KVM, =
or a
>>>> simple recipe to make one, that'd be great). "Fix wine" is not rea=
lly
>>>> an option.
>> Why is fixing Wine not an option? The guy working on MSVCRT in Wine =
is
>> very responsive; all that is needed is just a bug in
>> https://bugs.winehq.org/ and he'll look at it. Or give me more detai=
ls
>> and I'll create the bug entry.
>=20
> Not an option as in "_I_ will be working on it". I don't suppose lots
> of people use git on wine to be worth the trouble, but then again
> making wine msvcrt more compatible is probably a good thing so I'll
> open a bug for wine.
Thanks! This is actually a very important use case for Wine:
Making it easy for OSS developers to test the Windows builds of their
software without having to use Windows.

bye
	michael
