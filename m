From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 09:19:12 +0200
Message-ID: <8B950268-7F6E-40E5-9D6C-F150EBEA4F0C@wincent.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com> <vpq8w1v5gce.fsf@bauges.imag.fr> <buopqv6kcsd.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 19 10:22:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P87Sc-0005xE-Iu
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 10:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757837Ab0JSIWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 04:22:12 -0400
Received: from outmail149056.authsmtp.com ([62.13.149.56]:58966 "EHLO
	outmail149056.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755871Ab0JSIWK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 04:22:10 -0400
X-Greylist: delayed 3760 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2010 04:22:10 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt10.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o9J7JN8N081237;
	Tue, 19 Oct 2010 08:19:23 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o9J7JGJf079122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Oct 2010 08:19:17 +0100 (BST)
Received: from [192.168.1.6] (81.Red-88-5-242.dynamicIP.rima-tde.net [88.5.242.81])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o9J7JCVt030392
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 19 Oct 2010 03:19:15 -0400
In-Reply-To: <buopqv6kcsd.fsf@dhlpc061.dev.necel.com>
X-Mailer: Apple Mail (2.1081)
X-Server-Quench: 2f8bde56-db51-11df-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJCUVH axcdCVFPdwdEHAkR A24BWl1eUVU/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNHX9ve2t7 UB4ZWxhwdUtHeH11 YAhgCHgJCBF/c1sp EEtVCGwHMTF9YWdN Al1YdwFWdgdDeRdA a1gxNiYHcRJeImok EhU2PjY2OTJQOXYd WAwIKk4fBQ4CEjJ4 DwwYFD4sWQUeWyw8 IlhuJ0IXWi4A
X-Authentic-SMTP: 61633436303433.1014:706
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159313>

El 19/10/2010, a las 06:49, Miles Bader escribi=F3:

> I think the original post, while well-meaning is a bit overwrought, a=
nd
> reflects the difficulty in learning any new system as much as it does
> any inconsistency in git's terminology[*] -- Git's huge sin, after al=
l
> (judging from most complaints I see about it), is that It Doesn't Use
> Exactly The Same Model (and thus Terminology) That CVS Did...

I don't think it's overwrought at all. It's just pointing out a couple =
of obvious road-bumps in the learning curve.

We should smooth out these road-bumps (in so far as we can, with respec=
t to backward compatibility and such) rather than just hand-waving them=
 away saying that they are a natural consequence of demolishing the CVS=
 world view and replacing it with something better. That's not true at =
all; mistakes _were_ made with the terminology, and unfortunately we ha=
ve to live with some of them because they can't be changed in a non-bre=
aking way, but the changes that we _can_ make to remove the confusion, =
we should make them.

Cheers,
Wincent
