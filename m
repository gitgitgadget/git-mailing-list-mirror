From: Steven Michalske <smichalske@gmail.com>
Subject: Re: [RFC/PATCHv2] bash completion: Support "divergence from upstream" warnings in __git_ps1
Date: Wed, 9 Jun 2010 14:02:28 -0700
Message-ID: <F1A17EC9-1241-4735-9D38-AFECA61CB1D4@gmail.com>
References: <4C0AE640.3040503@pileofstuff.org> <201006062014.59386.trast@student.ethz.ch> <4C0C09BF.4070503@pileofstuff.org> <201006070942.34753.trast@student.ethz.ch> <4C0EB7F1.1030707@pileofstuff.org> <AANLkTiltzOHvsVkqnKLV-fy-T8KyGQ8vg6pPm4xPZpJ-@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 23:02:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMSPy-0007pD-T9
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 23:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306Ab0FIVC3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 17:02:29 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:56587 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab0FIVC2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 17:02:28 -0400
Received: from relay15.apple.com (relay15.apple.com [17.128.113.54])
	by mail-out3.apple.com (Postfix) with ESMTP id A242A9715517;
	Wed,  9 Jun 2010 14:02:28 -0700 (PDT)
X-AuditID: 11807136-b7be8ae00000485f-4b-4c100164001f
Received: from monopole.apple.com (monopole.apple.com [17.205.37.84])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay15.apple.com (Apple SCV relay) with SMTP id 3A.67.18527.461001C4; Wed,  9 Jun 2010 14:02:28 -0700 (PDT)
In-Reply-To: <AANLkTiltzOHvsVkqnKLV-fy-T8KyGQ8vg6pPm4xPZpJ-@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148817>


On Jun 9, 2010, at 1:45 AM, John Tapsell wrote:

> On 9 June 2010 06:36, Andrew Sayers <andrew-git@pileofstuff.org> wrot=
e:
>> Add a notification in the command prompt specifying whether you're a=
head of
>> (>), behind (<), diverged from (<>) or at (=3D) your upstream.  This=
 is
>> especially helpful in small teams that (forget to) push to each othe=
r very
>> frequently.
>=20
> I hate to get all feature-bloat on you...
>=20
> But could it state the number of commits as well please? :) :)
>=20

I like the idea of ahead, at, behind, and diverged

but I would want to use unicode/utf8  as my terminal supports it, would=
 use it.

=E2=87=85	UPWARDS ARROW LEFTWARDS OF DOWNWARDS ARROW is diverged.
=E2=86=91	UPWARDS ARROW master is ahead.
=E2=86=93	DOWNWARDS ARROW is master is behind.

Steve
