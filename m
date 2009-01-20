From: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
Subject: Re: Newbie Query
Date: Tue, 20 Jan 2009 22:46:47 +0100
Message-ID: <49764647.1080606@morey-chaisemartin.com>
References: <20090120191952.GA25322@uts.thewillards.local> <3f4fd2640901201217x22262655w115cc2a25e32865e@mail.gmail.com> <49763D2B.1000607@morey-chaisemartin.com> <200901201534.16571.bss@iguanasuicide.net>
Reply-To: devel@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 23:15:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPOsT-0004TH-63
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 23:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbZATWN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 17:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbZATWN6
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 17:13:58 -0500
Received: from 42.mail-out.ovh.net ([213.251.189.42]:44930 "HELO
	42.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752661AbZATWN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 17:13:58 -0500
Received: (qmail 22029 invoked by uid 503); 20 Jan 2009 21:47:06 -0000
Received: from gw2.ovh.net (HELO mail242.ha.ovh.net) (213.251.189.202)
  by 42.mail-out.ovh.net with SMTP; 20 Jan 2009 21:47:05 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 20 Jan 2009 21:46:50 -0000
Received: from agrenoble-152-1-95-122.w86-200.abo.wanadoo.fr (HELO ?192.168.10.200?) (devel@morey-chaisemartin.com@86.200.202.122)
  by ns0.ovh.net with SMTP; 20 Jan 2009 21:46:49 -0000
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <200901201534.16571.bss@iguanasuicide.net>
X-Enigmail-Version: 0.95.7
X-Ovh-Tracer-Id: 5064579257868209721
X-Ovh-Remote: 86.200.202.122 (agrenoble-152-1-95-122.w86-200.abo.wanadoo.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.501396/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106529>

Boyd Stephen Smith Jr. a =E9crit :
> On Tuesday 2009 January 20 15:07:55 Nicolas Morey-Chaisemartin wrote:
>  =20
>> I did the rookie mistkae on the central server to create the main
>> reposity in non-bare mode. So i need to checkout the HEAD revision e=
ach
>> time I push.
>> Is there a cleaner way to convert a non-bare git repo into a bare re=
po
>> than cloning it?
>> My repo have a lot of remote branch registered, and cloning them to =
a
>> new bare repo mean I'll have to add all those remote branches again
>> (except if there is another trick here I don't know about).
>>    =20
>
> Well, if you can make sure no one is pushing into the repo for a bit:=
 clone it=20
> and replace the original with a symlink to new, bare one.  Your clien=
ts will=20
> be able to use the same URL, so they should be happy.  (I haven't tri=
ed this,=20
> but it should work.)
>  =20
Well I know there are solutions to convert it to a bare repo.
I was just wondering if there was a "clean" one which really converts
the repo to a bare one and not create a copy which is bare.
I don't know how bare/non-bare is managed but I guess both types of rep=
o
are not differing by much, so it'd be great to have a function to
convert from one to another.
