From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Wed, 20 Feb 2013 01:20:33 -0500
Message-ID: <51246B31.6000605@mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu> <7v7gqkgvxe.fsf@alter.siamese.dyndns.org> <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com> <508E0FAC.5050600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 20 07:28:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U83AF-0006zx-2l
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 07:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934753Ab3BTG16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Feb 2013 01:27:58 -0500
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:52539 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934071Ab3BTG15 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2013 01:27:57 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2013 01:27:57 EST
X-AuditID: 12074425-b7fec6d000007584-80-51246bc0b359
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 53.34.30084.0CB64215; Wed, 20 Feb 2013 01:22:56 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id r1K6Mtrc012943;
	Wed, 20 Feb 2013 01:22:55 -0500
Received: from [18.101.24.237] (VPN-18-101-24-237.MIT.EDU [18.101.24.237])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r1K6Mo3D028704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 20 Feb 2013 01:22:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130105 Thunderbird/17.0.2
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <508E0FAC.5050600@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixG6nrnsgWyXQ4OoxBYsNS9cwWxx584TZ
	outKN5NFQ+8VZosnc+8yWzybvJHd4ugpC4u2qVtYLH609DBbrH93ldmBy6O1v5vN4017L6PH
	zll32T0evupi93jWu4fR48L2k8weFy8pe3zeJBfAEcVlk5Kak1mWWqRvl8CV0X/0LHtBC3vF
	ruWBDYz3WbsYOTgkBEwkHj1X7GLkBDLFJC7cW88GYgsJ7GOUWLlEvYuRC8jeyChxdtE0dojE
	cSaJu/vdQWxeATWJB793gcVZBFQlFnSvZwGx2YDiczdMBouLCoRJPHoM0csrIChxcuYTsBo+
	AS2JXycXgS0TEdCW+LZxB1icWaCJWeLV+moQW1jAV+Lq8XlMEEdcZpR4d2kjK0iCU0BH4uyc
	10wQDWYSXVu7GCFseYnmrbOZJzAKzUKybxaSsllIyhYwMq9ilE3JrdLNTczMKU5N1i1OTszL
	Sy3StdDLzSzRS00p3cQIji0X1R2MEw4pHWIU4GBU4uHVmK8cKMSaWFZcmXuIUZKDSUmU1zdL
	JVCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG+zE1CONyWxsiq1KB8mJc3BoiTOeyPlpr+QQHpi
	SWp2ampBahFMVoaDQ0mCVxJkqGBRanpqRVpmTglCmomDE2Q4D9BwB5Aa3uKCxNzizHSI/ClG
	RSlxXlWQhABIIqM0D64XlvpeMYoDvSLMawdSxQNMm3Ddr4AGMwENXrtcGWRwSSJCSqqBccNf
	P//nVtc8b4YH3v+8YfFrcRYPP4UVC0/lpbkXnmest29RlGib8Dhb7WUFx61fbesl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216682>

On 10/29/2012 01:10 AM, Michael Haggerty wrote:
> How do you use GIT_CEILING_DIRECTORIES that the proposed changes caus=
e a
> slowdown?

Sorry to bring up this old thread again, but I just realized why my=20
computer has been acting so slow when I=E2=80=99m not connected to the =
network.=20
  I put various network filesystem paths in $GIT_CEILING_DIRECTORIES,=20
such as /afs/athena.mit.edu/user/a/n/andersk (to avoid hitting its=20
parents /afs/athena.mit.edu, /afs/athena.mit.edu/user/a, and=20
/afs/athena.mit.edu/user/a/n which all live in different AFS volumes).=20
Now when I=E2=80=99m not connected to the network, every invocation of =
Git,=20
including the __git_ps1 in my shell prompt, waits for AFS to timeout.

Obviously I=E2=80=99m going to stop using $GIT_CEILING_DIRECTORIES now =
that I=20
know what the problem is, but I figured you might want to know why this=
=20
feature is now useless for me.

Anders
