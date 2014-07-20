From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Sun, 20 Jul 2014 17:25:46 +0200
Message-ID: <53CBDF7A.5040509@web.de>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com> <20140717221056.GO12427@google.com> <53CA0E59.5030103@web.de> <20140719170623.GA29072@google.com> <53CB5D64.9060801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 17:26:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8t04-0004Ja-Px
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 17:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbaGTP0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 11:26:05 -0400
Received: from mout.web.de ([212.227.15.14]:59252 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbaGTP0C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 11:26:02 -0400
Received: from [192.168.1.87] ([91.141.0.96]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MBH5Z-1XIXW91DGP-00AF1w; Sun, 20 Jul 2014 17:26:00
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.6.0
In-Reply-To: <53CB5D64.9060801@web.de>
X-Provags-ID: V03:K0:GB55YGuq2S5rGo8Eq1jKTplkXvTEOGuEvuDlEuLUUBe4AuTKWwv
 P316qDICtL9RUmOl97gYxHBexoR2MSkjmH6wxPeMNJGSjegZ1mrLc4eCX88KRx2HBcPMjvD
 tATYTAcDGGkOkoqy7RFqMfUvXzjRSmfeUETM0iNevgdEgzZm5HmfJk5WCJdu6WyU0+rxG8F
 jHtH2mPZoUZZuc4M8LsiQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253929>

On 07/20/2014 08:10 AM, Torsten B=F6gershausen wrote:
> On 07/19/2014 07:06 PM, Jonathan Nieder wrote:
>> Torsten B=F6gershausen wrote:
>>
>>> Jonathan, (I'm good in searching, but bad in finding)
>>> could you point out where the source code for the git package for
>>> debian is ?
>>>
>>> I recently learned about mDNS, and will probably do some tests
>>> and experiments later, and would like to test the lookup feature
>>> of "0010".
>> Thanks.  It's at git://git.debian.org/~jrnieder-guest/git branch
>> release+patches and mirrored at http://repo.or.cz/r/git/debian
I probably need to correct myself:
Donwloaded your branch, compiled and tested.
On my test system the lookup timed out after 1.9 sec for DNS,
and 5 seconds for MDNS (the lookup failed in both cases)

I'm not sure any more how to improve things here, and
the question remains why Kyle has 15 seconds timeout ?

Would it be possible to run wireshark, and give us an example
of the URL's you have been using ?
