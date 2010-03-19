From: Wincent Colaiuta <win@wincent.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 14:41:11 +0100
Message-ID: <873DD7AF-6D5C-4F5F-BDC1-1F26480D412F@wincent.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com>  <b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com>  <46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com>  <b4087cc51003181457s76560b02y84aafbe77f45af87@mail.gmail.com>  <4BA36F5F.9080706@gnu.org> <b4087cc51003190543mafc403q6260a3774653e2d5@mail.gmail.com>  <4BA373C0.2070506@gnu.org> <b4087cc51003190603v259b833embb40b7360a07cf1f@mail.gmail.com>  <4BA3776B.5040706@gnu.org> <b4087cc51003190613y2fe32c26jd27cb009e64f197c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 14:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nscha-00007e-Pa
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 14:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305Ab0CSN5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 09:57:22 -0400
Received: from outmail148099.authsmtp.net ([62.13.148.99]:65174 "EHLO
	outmail148099.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752275Ab0CSN5V convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 09:57:21 -0400
X-Greylist: delayed 958 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2010 09:57:20 EDT
Received: from mail-c194.authsmtp.com (mail-c194.authsmtp.com [62.13.128.121])
	by punt2.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o2JDfHrD066102;
	Fri, 19 Mar 2010 13:41:17 GMT
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o2JDfFEA002939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Mar 2010 13:41:16 GMT
Received: from [192.168.1.6] (174.Red-88-5-248.dynamicIP.rima-tde.net [88.5.248.174])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o2JDfCOX031668
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 19 Mar 2010 09:41:14 -0400
In-Reply-To: <b4087cc51003190613y2fe32c26jd27cb009e64f197c@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
X-Server-Quench: 17a937e3-335d-11df-80b9-0022640b883e
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJDkVH axcdC1NJdwdEHAkR AmUBX1VeUVs/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNFn8cV2p0 dx4eUBBxfktPf3d2 K0dlD3lYWxF5aEV+ RxpJFGxSM3poaDIW TUBYdQFSdAMYdhdG Px4dAXkdBj1WIm0j Vw41dzl5OzxaJXMd ZgwRYklaXF0GVjd0 Bw0fHDlrG0QASmE+ KhUnLh9UAFwQKkE/ LTMA
X-Authentic-SMTP: 61633436303433.1015:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142592>

El 19/03/2010, a las 14:13, Michael Witten escribi=F3:

> On Fri, Mar 19, 2010 at 07:08, Paolo Bonzini <bonzini@gnu.org> wrote:
>> Maybe you have to define entropy.  For human consumers, "Paolo Bonzi=
ni
>> <pbonzini@redhat.com>" has considerably less "entropy" than
>> 8aacc35ffca0d34fccf8a750e84e3a81bdcb940b, as does even "Paolo Bonzin=
i
>> <bonzini@gnu.org, pbonzini@redhat.com>".  For non-human consumers, a=
 good
>> mailmap will do.
>=20
> As I've stated before many times, the SHA-1 is not necessary to the p=
roposal.
>=20
> Please go read.

Stop telling people to go read your idiotic proposal. It has _already_ =
been read with great attention, and multiple people have shown immense =
patience repeatedly explaining to you why the idea is stupid. Your cont=
inued trolling is really starting to grate.

The overwhelming, sustained opposition to your idea should already be e=
nough indication that such a proposal will _never_ be accepted into the=
 Git codebase, so right now you're just wasting people's time.

w
