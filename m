From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 10:05:05 +0200
Message-ID: <6FCE62E3-A27E-43D6-9FDF-0133ABD851C2@wincent.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com> <vpq8w1v5gce.fsf@bauges.imag.fr> <buopqv6kcsd.fsf@dhlpc061.dev.necel.com> <8B950268-7F6E-40E5-9D6C-F150EBEA4F0C@wincent.com> <AANLkTinb0149C88Mzx6m4_2BdhpW12OwQ+uP6XzQ5yLx@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 19 11:06:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P889G-0001fC-Oy
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 11:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab0JSJGR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 05:06:17 -0400
Received: from outmail148115.authsmtp.co.uk ([62.13.148.115]:49675 "EHLO
	outmail148115.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753467Ab0JSJGQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 05:06:16 -0400
X-Greylist: delayed 3659 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2010 05:06:15 EDT
Received: from mail-c194.authsmtp.com (mail-c194.authsmtp.com [62.13.128.121])
	by punt2.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o9J85C1L016128;
	Tue, 19 Oct 2010 08:05:12 GMT
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o9J859P0066358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Oct 2010 09:05:10 +0100 (BST)
Received: from [192.168.1.6] (81.Red-88-5-242.dynamicIP.rima-tde.net [88.5.242.81])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o9J855iC030774
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 19 Oct 2010 04:05:07 -0400
In-Reply-To: <AANLkTinb0149C88Mzx6m4_2BdhpW12OwQ+uP6XzQ5yLx@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
X-Server-Quench: 9872e6aa-db57-11df-80b9-0022640b883e
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJCUVH axcdCVFPdwdEHAkR A28BW1FeUVw/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNHX9gBBVh Bh4YVBp3f0tHf312 YAhrVndZCUIrJFsp EEtTCGwHMTF9YGBN WV1YdwFWdgdKLBdN aQUxNiYHcRJeImok EhU2PjY2OTJQOXYd WAwIKk4fBQ4CEjJ4 DwwYFD4sWQUeWyw8 IlhuJ0IXWi4A
X-Authentic-SMTP: 61633436303433.1015:706
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159315>

El 19/10/2010, a las 09:48, Miles Bader escribi=F3:

> On Tue, Oct 19, 2010 at 4:19 PM, Wincent Colaiuta <win@wincent.com> w=
rote:
>> We should smooth out these road-bumps (in so far as we can, with res=
pect to backward compatibility and such) rather than just hand-waving t=
hem away saying that they are a natural consequence of demolishing the =
CVS world view and replacing it with something better. That's not true =
at all; mistakes _were_ made with the terminology, and unfortunately we=
 have to live with some of them because they can't be changed in a non-=
breaking way, but the changes that we _can_ make to remove the confusio=
n, we should make them.
>=20
> Sure, I'm not claiming that git's perfect or can't be improved.  [As =
I
> noted, I have my own list of complaints about its terminology.]
>=20
> However, just as it's wrong to ignore all complaints for such reasons=
,
> it's _equally_ wrong to assume the opposite and think that all such
> complaints are justified.  Some differences in terminology _are_ due
> to a very different model, and can't simply be papered over.  It isn'=
t
> "hand-waving" to point this out.  They might (and should) be better
> documented/explained, but there are definitely terms and concepts
> where the only reasonable solution is for newbies to have some
> patience and take some time to learn them.

Well, I'm not "assuming" that the complaints are justified; I'm talking=
 from 3.5 years of personal experience using Git:

- the concept of the "index": learnt it in 30 seconds, and sick of hear=
ing people complain about it

- terminology related to concepts of "tracking"/"remote(s)": discomfort=
 almost every time I've had to deal with it

gitglossary(7) helps, but no matter how good it is you'll still get con=
fusion unless the terminology is used consistently across the board. So=
me of this is not actually Git's fault, as a lot of the misuse/abuse of=
 terminology actually comes from people writing blog posts and presenta=
tions and not being disciplined about their use of language -- before y=
ou know it Google returns mostly garbage results and "the community" en=
ds up speaking a corrupted version of the language --  but the stuff th=
at is within the scope of the Git project itself (man pages, official d=
ocs, interfaces) really needs to be top notch.

Cheers,
Wincent
