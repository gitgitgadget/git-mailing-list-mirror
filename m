From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Fri, 16 May 2008 13:12:39 -0400
Message-ID: <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>  <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com> <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com> <alpine.DEB.1.00.0805161125320.30431@racer>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 16 19:13:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx3V9-0004bY-K9
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 19:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbYEPRMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2008 13:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbYEPRMo
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 13:12:44 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:46278 "EHLO
	randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754996AbYEPRMn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 13:12:43 -0400
Received: from [192.168.0.203] (c-24-91-11-245.hsd1.nh.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id AACAEEF3C9;
	Fri, 16 May 2008 10:12:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805161125320.30431@racer>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82306>

On May 16, 2008, at 6:25 AM, Johannes Schindelin wrote:

> On Thu, 15 May 2008, Andr=E9 Goddard Rosa wrote:
>
>>>> This patch will make git a little more human friendly, reporting =20
>>>> "file.txt: has local changes".
>>>
>>> Documentation/git-checkout.txt should also change in this case,
>>> otherwise users will see different output to that described and
>>> possibly get confused if following along with the examples.
>>>
>>
>> I like the idea too.
>
> No comment on the concern that it might break people's scripts?  None=
?


How about an ugly hack? Look to see if stdout is a tty, if so spit out =
=20
the more human-readable version, otherwise spit out the old version >:-=
)

-Kevin

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
