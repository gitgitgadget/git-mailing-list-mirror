From: Wincent Colaiuta <win@wincent.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 20:40:51 +0100
Message-ID: <4B445491-99C8-49CD-910F-7F3CC1C67984@wincent.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>  <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org> <b4087cc51003181232q6b8ec056lad79c62926b65a10@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 21:26:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsMI8-0004AB-2V
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 21:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab0CRUZ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 16:25:59 -0400
Received: from outmail148103.authsmtp.co.uk ([62.13.148.103]:56042 "EHLO
	outmail148103.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751622Ab0CRUZ6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 16:25:58 -0400
X-Greylist: delayed 2691 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2010 16:25:57 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt8.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o2IJewCM036084;
	Thu, 18 Mar 2010 19:40:58 GMT
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o2IJes0B042113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 19:40:55 GMT
Received: from [192.168.1.6] (174.Red-88-5-248.dynamicIP.rima-tde.net [88.5.248.174])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o2IJepKh017684
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 18 Mar 2010 15:40:53 -0400
In-Reply-To: <b4087cc51003181232q6b8ec056lad79c62926b65a10@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
X-Server-Quench: 2b5c2663-32c6-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJCUVH axYdC1NJdwdEHAkR Am8BX1ReVVg/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNFnwSVF8B dB4aUBhzdEtHeXx4 YAhgDHUIXkJ8dlt+ QB1SCGwHMTF9YWdN Al1YdwFWdgdDeRdA a1gxNiYHcQJfNz53 BEcyOXg4dTNWLSkC CiUAMR0JCVsQE3Y1 D1AfADQjWUsMQih3 IhkvK1pdVFoLM102 PEdJ
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142513>

El 18/03/2010, a las 20:32, Michael Witten escribi=F3:

> On Thu, Mar 18, 2010 at 14:07, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>=20
>> And if it doesn't have meaning, then it's just
>> annoying and will never ever be attached to
>> anything relevant long-term.
>=20
> You've actually just described the current name/email system.
>=20
> What a uuid provides is that very property of long-term attachment; a
> git user can change the name/email pair but keep the same uuid.
>=20
> You see, the problem is that the name/email pair isn't really an
> identifier; it's actually just info about the user's current email
> account, which is very useful for everyday workflow, but pretty naive
> for historical identification over long periods of time.

This whole thing is a stupid idea.

If users can't even be bothered keeping a stable email address, what ma=
kes you think that they can be assed "doing the right thing" with respe=
ct to a meaningless UUID string?

The idea is complicated, over-engineered, brings no benefit and adds on=
ly cruft.

W
