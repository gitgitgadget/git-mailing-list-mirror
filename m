From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Git sideband hook output
Date: Fri, 11 Jun 2010 16:45:41 +0200
Message-ID: <3B9F4351-4608-455E-B433-A5337A946F8A@wincent.com>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com> <20100608214632.GN14847@spearce.org> <A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com> <alpine.LFD.2.00.1006090934320.30664@xanadu.home> <A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com> <20100610183019.GR14847@spearce.org> <AANLkTikQQh4sUA7h2k1jvQ7aMgYyq7WFetJvJZvqpVxt@mail.gmail.com> <AANLkTikYBB1DsGRRsu4pSNr1j8fFXD-99c4lRAaBqd3M@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	git list <git@vger.kernel.org>
To: PJ Hyett <pjhyett@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 17:03:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON5lH-0006TM-62
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 17:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab0FKPDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 11:03:05 -0400
Received: from outmail137068.authsmtp.com ([62.13.137.68]:51036 "EHLO
	outmail137068.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751244Ab0FKPDE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 11:03:04 -0400
X-Greylist: delayed 1012 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jun 2010 11:03:03 EDT
Received: from mail-c194.authsmtp.com (mail-c194.authsmtp.com [62.13.128.121])
	by punt5.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o5BEjnlH060302;
	Fri, 11 Jun 2010 15:45:49 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o5BEjjIN033687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jun 2010 15:45:46 +0100 (BST)
Received: from [192.168.1.6] (119.Red-88-3-76.dynamicIP.rima-tde.net [88.3.76.119])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o5BEjfAU027229
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 11 Jun 2010 10:45:43 -0400
In-Reply-To: <AANLkTikYBB1DsGRRsu4pSNr1j8fFXD-99c4lRAaBqd3M@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
X-Server-Quench: 052f380a-7568-11df-80b9-0022640b883e
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJC0VH ax8dDEdVdwdEHAkR AmMBX1FeVFs/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNEXcdW0Z4 eB4dUR96cEtHfHt2 ZQhiW3INX0x6JFt6 R0hcCGwHMTF9YGBN WV1YdwFWdgdKLBdN aQUxNiYHcRJeImoj HgM+NTk3MX1fLyNW CgYQMUoPXS4A
X-Authentic-SMTP: 61633436303433.1015:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148951>

El 11/06/2010, a las 16:34, PJ Hyett escribi=F3:

> Hi,
>=20
>> On Thu, Jun 10, 2010 at 8:30 PM, Shawn O. Pearce <spearce@spearce.or=
g> wrote:
>>>=20
>>> If its really a problem, maybe "remote: " prefix should turn into
>>> something shorter and language agnostic, like "<< ".  But thus far
>>> we hadn't had to worry about it, since we didn't have translation
>>> support in Git...  (though yes, I see that is changing now).
>>>=20
>=20
> I'm also in favor of making the default '>>' instead of 'remote:' if
> nothing isn't an option.

=46unny, as '>>' is basically meaningless. At least 'remote:' has seman=
tic value (ie. it indicates _where_ something is coming from).

Wincent
