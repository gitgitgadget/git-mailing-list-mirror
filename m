From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Include a git-push example for creating a remote branch
Date: Thu, 06 Sep 2007 10:57:18 -0400
Message-ID: <1189090638.3423.0.camel@hinata.boston.redhat.com>
References: <20070906044408.GA588@spearce.org>
	 <A3C344D0-B2A0-44DC-BCBD-3B2C1EBD24B1@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 17:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITIpq-0006gV-V4
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 16:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbXIFO7x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 10:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbXIFO7x
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 10:59:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44063 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbXIFO7w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 10:59:52 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l86EvQ5Y007199;
	Thu, 6 Sep 2007 10:57:26 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l86EvQso019743;
	Thu, 6 Sep 2007 10:57:26 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l86EvO2l017437;
	Thu, 6 Sep 2007 10:57:24 -0400
In-Reply-To: <A3C344D0-B2A0-44DC-BCBD-3B2C1EBD24B1@wincent.com>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57889>

On Thu, 2007-09-06 at 12:50 +0200, Wincent Colaiuta wrote:
> El 6/9/2007, a las 6:44, Shawn O. Pearce escribi=C3=B3:
>=20
> > +git push origin master:refs/heads/experimental::
> > +	Create the branch `experimental` in the `origin` repository
> > +	by copying the current `master` branch.  This form is usually
> > +	needed to create a new branch in the remote repository as
> > +	there is no `experimental` branch to match.
> > +
>=20
> A welcome addition; I was puzzled the first time I tried this myself =
=20
> too.

Indeed, but a even better approach might be to expand the error message
with a sugestion on how to create a branch.

Kristian
