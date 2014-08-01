From: Mike Stump <mikestump@comcast.net>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 16:47:14 -0700
Message-ID: <5EEA8572-291D-4D8C-A38A-E09E24E81A77@comcast.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801200201.GS12427@google.com> <20140801205040.GT12427@google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 01:47:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDMXt-0007FE-II
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 01:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbaHAXr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 19:47:29 -0400
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:46755 "EHLO
	qmta04.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750997AbaHAXr3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 19:47:29 -0400
Received: from omta20.emeryville.ca.mail.comcast.net ([76.96.30.87])
	by qmta04.emeryville.ca.mail.comcast.net with comcast
	id Zb9K1o0011smiN4A4bnUsp; Fri, 01 Aug 2014 23:47:28 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta20.emeryville.ca.mail.comcast.net with comcast
	id ZbnT1o00J2ztT3H8gbnUcE; Fri, 01 Aug 2014 23:47:28 +0000
In-Reply-To: <20140801205040.GT12427@google.com>
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1406936848;
	bh=nXexSHiwTaZboqF39p3rkdY51FuT3OEaTIwXvA2xQqk=;
	h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
	 Message-Id:To;
	b=tk/puxRfpZ9IwyFqNc8bfcRyjjIhsm+qywxHXVz+tQ3ARxodzbVpojn/ScZLbnAGu
	 R8ln6h2C3XCC7Fq6gRJl0QZPd6IRO/Z1Fpc4dW1FqK2QM2nF8aDSIQzA/xa8VtmlDe
	 wHH9wjuXvAmiN/VhyT2OkktheOpVdl63hqY1XBF3qraA1MHXlSGW578Cx47He8ySqt
	 1sJ1OjlAaNnXK1lLqZMeOPwJ+ojNWISBwJuQB1teXsch/NIgu0/gTSzbhG0I9PwdbM
	 no3yQ9p1XFRtIHavhT1tL0moO+wMX145Kxn4v+6HdpbsSDV9GF8DNPzFwiIoDEAlXC
	 J9NK+IxcYdfAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254685>

On Aug 1, 2014, at 1:50 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>=20
>       And on the other hand a one-patch-at-a-time merge would
>       try to apply X (with no effect, since it's already applied)
>       and then try to apply the revert of X.  The net effect would
>       be to revert X from "master" (bad)!

Yeah, I appreciate that.  I know the type of user that would do that, a=
nd I understand why you would want to do that and even do that by defau=
lt.

However, as an expert user, I don=92t need that particular type of hand=
 holding given the cost of more conflicts and would like an option to l=
et me to choose to have fewer conflicts when merging.