From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 3/4] Export launch_editor() and make it accept ':' as a
	no-op editor.
Date: Fri, 02 Nov 2007 12:16:12 -0400
Message-ID: <1194020172.25288.14.camel@hinata.boston.redhat.com>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
	 <1194017589-4669-2-git-send-email-krh@redhat.com>
	 <1194017589-4669-3-git-send-email-krh@redhat.com> <472B466E.8070805@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 02 17:23:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InzIM-0000Mb-T2
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 17:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbXKBQWk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 12:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbXKBQWk
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 12:22:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52348 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837AbXKBQWj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 12:22:39 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA2GGIj1025387;
	Fri, 2 Nov 2007 12:16:18 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA2GGIGY027973;
	Fri, 2 Nov 2007 12:16:18 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA2GGHrv010580;
	Fri, 2 Nov 2007 12:16:17 -0400
In-Reply-To: <472B466E.8070805@op5.se>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63142>

On Fri, 2007-11-02 at 16:46 +0100, Andreas Ericsson wrote:
> Kristian H=C3=B8gsberg wrote:
> > =20
> > +	if (!strcmp(editor, ":"))
> > +		return;
> > +
>=20
> Doesn't this make the change in 2/4 superfluous?

Yeah, but it's still a nice cleanup, I think.

Kristian
