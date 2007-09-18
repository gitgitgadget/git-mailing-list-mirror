From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 9/9] Implement git commit as a builtin command.
Date: Mon, 17 Sep 2007 20:11:25 -0400
Message-ID: <1190074285.10112.25.camel@hinata.boston.redhat.com>
References: <11890382242333-git-send-email-krh@redhat.com>
	 <11890382243290-git-send-email-krh@redhat.com>
	 <11890382253220-git-send-email-krh@redhat.com>
	 <11890382252522-git-send-email-krh@redhat.com>
	 <1189038225525-git-send-email-krh@redhat.com>
	 <11890382262161-git-send-email-krh@redhat.com>
	 <11890382264046-git-send-email-krh@redhat.com>
	 <11890382271931-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0709061741370.28586@racer.site>
	 <1190069881.10112.10.camel@hinata.boston.redhat.com>
	 <20070917235645.GG24342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 02:11:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQgn-0003Gv-EN
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 02:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233AbXIRALh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 20:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756221AbXIRALh
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 20:11:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57282 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbXIRALg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 20:11:36 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8I0BVhp014242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Sep 2007 20:11:31 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I0BVcR023673;
	Mon, 17 Sep 2007 20:11:31 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I0BVwo022568;
	Mon, 17 Sep 2007 20:11:31 -0400
In-Reply-To: <20070917235645.GG24342@sigill.intra.peff.net>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58510>


On Mon, 2007-09-17 at 19:56 -0400, Jeff King wrote:
> On Mon, Sep 17, 2007 at 06:58:01PM -0400, Kristian H=C3=B8gsberg wrot=
e:
>=20
> > > > -	builtin-runstatus.o \
> > >=20
> > > Better keep it; some people's scripts could depend on it.
> >=20
> > Seriously?  Why don't we remove it and see if somebody yells?  It's=
 more
> > of an implementation detail than most other git commands; if you ne=
ed
> > status output in your script why wouldn't you just run git status?
>=20
> As the author of builtin-runstatus, I had always intended that it was=
 a
> temporary part of the transition to a C git-commit, and would go away
> then. But I see in the interim somebody documented it.  It should
> perhaps have been called git-status--helper, and the documentation
> should have read "DO NOT USE THIS."

That's what I suspected, thanks for clearing that up.  It definitely
feels more like a step towards a built-in commit than a useful command
on it's own.  It plugs right into this work, so as such, it's been a
success.

Kristian
