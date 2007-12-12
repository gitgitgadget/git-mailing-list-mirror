From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Fix typo: we require Python 2.4, not 2.5
Date: Wed, 12 Dec 2007 07:07:13 -0800 (PST)
Message-ID: <m31w9srlyb.fsf@roke.D-201>
References: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com>
	<20071211142347.GA22879@diana.vm.bytemark.co.uk>
	<b0943d9e0712120604m97aac2cyaf60cb33c51cf9a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:08:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2TBT-0000IE-GY
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbXLLPHS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 10:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbXLLPHS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:07:18 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:2605 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbXLLPHP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 10:07:15 -0500
Received: by an-out-0708.google.com with SMTP id d31so63266and.103
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 07:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=/8dxLOoqnbYkG3zl0LUF1WFgaics6IsTbzPvC15dPKw=;
        b=WWgJBmAq5sRXmjj3xE6aGaR09biPz+AyUADZCZ6ATe2PWO1T5MYnJzOVMTR2K8r3tK7dvIJpiXGrOxTdlRf5Bb3e5JDDljxxrQp5501f0oWgv7aZM9pB0xtnr7MP7byKBKykQD5msI5sMNqMwZyMOSl4EGyC5QjUYACfKhTTsdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=UbJF75tds5p0KvwYFjtfMW71HnL3rfI2u3UVKHg4wIPu8Qbl3M0xw5gL1c7OXDrZOzYmvdO1dsaHb3zHNR4XdflCgpwi+hssptNxTeUq2FdJUlDAO33ruiBUMfCyXdgLSozw50Okrj07QGElg6imH4Js6RBlOQKKCg3Y/Yxzp9U=
Received: by 10.100.91.17 with SMTP id o17mr1612630anb.109.1197472034866;
        Wed, 12 Dec 2007 07:07:14 -0800 (PST)
Received: from roke.D-201 ( [83.8.249.28])
        by mx.google.com with ESMTPS id w5sm15105907mue.2007.12.12.07.07.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Dec 2007 07:07:13 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBCF79XT025422;
	Wed, 12 Dec 2007 16:07:09 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBCF78MQ025418;
	Wed, 12 Dec 2007 16:07:08 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <b0943d9e0712120604m97aac2cyaf60cb33c51cf9a7@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68047>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 11/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > Yeah. So 0.14.1 (to be released very soon) should probably have thi=
s
> > fix. :-)
>=20
> OK, done. Thanks.
>=20
> On the RPM side, I found a way to specify the required Python version
> on the "setup.py bdist_rpm" command line but I don't think it makes
> any difference since the installed files will go into the python2.5
> directory.
>=20
> Anyway, I linked the SRPMS as well from the website's page.

Thanks. At least compiling SRPMS works:

  $ stg version
  Stacked GIT 0.14.1
  git version 1.5.3.7
  Python version 2.4.3 (#1, Jun 13 2006, 16:41:18)=20
  [GCC 4.0.2 20051125 (Red Hat 4.0.2-8)]
  $ rpm -q stgit
  stgit-0.14.1-1

--=20
Jakub Narebski                      http://www.ohloh.net/accounts/11224
ShadeHawk on #git                   Linux Registered User #239074
