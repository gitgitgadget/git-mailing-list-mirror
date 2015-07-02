From: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] Documentation/i18n.txt: clarify character encoding
 support
Date: Thu, 02 Jul 2015 07:25:07 +0200
Message-ID: <5594CB33.7020108@web.de>
References: <557C9161.6020703@gmail.com>	<xmqqmw01ltid.fsf@gitster.dls.corp.google.com>	<557EA421.5050706@gmail.com> <xmqqr3pa5aix.fsf@gitster.dls.corp.google.com> <55943B37.40101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 07:25:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAX02-0004dE-FB
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 07:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbbGBFZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 01:25:22 -0400
Received: from mout.web.de ([212.227.15.14]:64146 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbbGBFZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 01:25:20 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MNg5K-1Z8t600U6k-0079e6; Thu, 02 Jul 2015 07:25:14
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <55943B37.40101@gmail.com>
X-Provags-ID: V03:K0:jGDCTxsQUXpkT4pM/f92kAWudr569/RZcMmdr3rEdaHrnc3kbfr
 4zMXIlY2FlBCjFz1UXf+hXh632Ke5kb/yTGi4kSG8mla/PpxEZSRV01wkbpY+DqNKPVHTT1
 eshzN9Q7shi2NWTTgaDGlQBf9Xzq230NtLRgWR1K42WPo4Lii1+a62ZKNG1Nwi0cdGGZBji
 vWq0fZ2tt67vRPomZzyfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c57Z/MVhwgU=:k4Vq1Ee2X2e8SEHCqH+yUy
 uxDjT16op/42ZZQr6+QIwHOVD+uX1KBRH2y3NkjRcuegw2eMIuReDxqbSK+dIzfBUaCa+9CTA
 +ezurDLG7AdjfMFH2M8k4JY3+Z/JIAG7FLgMvxVshrywUhKBehRLT/UZGPgacBK14Py4lNOZv
 32gmIYC3ELHWwG9urJiqltBhHzHMLYwe5h7SqhRDvLhcCQuXadgFVF3gmcS5fE9ojg8nEHARw
 B5TNwK/oxSKx4VudtCxkrGc/ZiG5C4yvQWKRpVMm0DbwndVwnqxmikld0Gh+6VrkRznLevdHW
 ixYebytxz843g+3zja6hI2P63HkzWLIG1GUD/m1bo1i3RnLKnqb3kr94LYn0ZLV1VTUaPFcTJ
 5FCfeRVOkyyIWIK+dqYGjR98geQYT+LiMdetFy2mV6p0CpTdQ2fwUA+e0DeJG0dcqJwcdC+O5
 c1KW/NHa2T63hPZ2k7KbgYVb2Jhk2En0kk319kUx3flFwRbCV1C59kLITTQCbGnq2q9eFrgZC
 wQsgUjLRbdDrkjzyPZZpBXSYm/2ZO8sd77zCvGbTtfejfoJ8dqhEL1Qe2b/9n/eHFSPwPYHf+
 HifhZE6SBf6cYTUArM9rpdtl90ArB49xAPHjY98ht1XLuXeU8tjErEyoXF5GauMvrZZkKIAtx
 DjqHXyq4/tg0Y7GoM2KIB12WU0p9GtxGGK7+8qBk6w4jgRaTu38CgGt6ivgx0D0V8la0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273211>

On 07/01/2015 09:10 PM, Karsten Blees wrote:
>
> Of course, it would be nice to hear other opinions as well - this
> probably shouldn't be a discussion between the two of us :-)
>
> Karsten
>
I like this paragraf from your previous mail, I think it can go
into i18n.txt "as is":

ISO-8859-x file names may be fine if you won't ever need to:
- use git-web, JGit, gitk, git-gui...
- exchange repos with "normal" (UTF-8) Unices, Mac and Windows systems
- publish your work on a git hosting service (and expect file and
   ref names to show up correctly in the web interface)
- store the repo on Unicode-based file systems (JFS, Joliet, UDF,
   exFat, NTFS, HFS+, CIFS...)
