From: Jakub Narebski <jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Using test-lib.sh under GPLv3?
Date: Wed, 17 Feb 2010 01:26:43 +0100
Message-ID: <201002170126.44752.jnareb@gmail.com>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	<m3aav98oj7.fsf@localhost.localdomain>
	<87r5olfhz9.fsf@steelpick.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Cc: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Michal Sojka <sojkam1-jQs2MHkdoM/twjQa/ONI9g@public.gmane.org>
X-From: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org Wed Feb 17 01:27:01 2010
Return-path: <notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>
Envelope-to: gmn-notmuch@m.gmane.org
Received: from u15218177.onlinehome-server.com ([82.165.184.25] helo=olra.theworths.org)
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>)
	id 1NhXkq-0000FX-FH
	for gmn-notmuch@m.gmane.org; Wed, 17 Feb 2010 01:27:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 825C4431FC2;
	Tue, 16 Feb 2010 16:26:57 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aaICCFE6XK9D; Tue, 16 Feb 2010 16:26:55 -0800 (PST)
Received: from olra.theworths.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 55A32431FBD;
	Tue, 16 Feb 2010 16:26:55 -0800 (PST)
X-Original-To: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Delivered-To: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id EBD64431FBD
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Tue, 16 Feb 2010 16:26:53 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3emeR-cm-Qlt for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>;
	Tue, 16 Feb 2010 16:26:53 -0800 (PST)
Received: from mail-fx0-f224.google.com (mail-fx0-f224.google.com
	[209.85.220.224])
	by olra.theworths.org (Postfix) with ESMTP id 085B9431FAE
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Tue, 16 Feb 2010 16:26:52 -0800 (PST)
Received: by fxm24 with SMTP id 24so7721776fxm.0
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Tue, 16 Feb 2010 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:from:to:subject:date
	:user-agent:cc:references:in-reply-to:mime-version:content-type
	:content-transfer-encoding:content-disposition:message-id;
	bh=yMwQLLAfACmzBPeBdN9apY0z8fcVTefhGCcr+akZG2I=;
	b=P79xELiUiZ5oDce0HoD7ju4EnhTGzmY3yIM+123xNs1KfAJICzxIVJRqDsEpybqWK1
	R4ArxmoG7secc6Xk1gV8m0m38WjusPXqvQOwxgmEPOLgEhUNU6OwUU9mnl225mGQ1bqh
	HiZaVSwOVLLtZ7fr5Bfmhf7/UNy9oidd4EqSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=from:to:subject:date:user-agent:cc:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding
	:content-disposition:message-id;
	b=PF0zX7eC193JTcgI1+KD5qgHKIuw0TvI/WmUMxXlMdkNwl1FkaEctxaB7LHk+PH/eI
	hD2ziG49vzhz+CZ2l8HOP23tCrBhD8Ap1F3eKa/xGe408ft+YR3RZpo0hLNZy0HWE2Zk
	+Ey1T6J288dh8rmLg7zwyjYXvnLp0Ong9EasU=
Received: by 10.87.11.34 with SMTP id o34mr12900587fgi.26.1266366412040;
	Tue, 16 Feb 2010 16:26:52 -0800 (PST)
Received: from ?192.168.1.13? (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
	by mx.google.com with ESMTPS id e11sm12560021fga.24.2010.02.16.16.26.49
	(version=TLSv1/SSLv3 cipher=RC4-MD5);
	Tue, 16 Feb 2010 16:26:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87r5olfhz9.fsf-RBRde3N6TzJErxoiPTnesrp2dZbC/Bob@public.gmane.org>
Content-Disposition: inline
X-BeenThere: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: "Use and development of the notmuch mail system."
	<notmuch.notmuchmail.org>
List-Unsubscribe: <http://notmuchmail.org/mailman/options/notmuch>,
	<mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://notmuchmail.org/pipermail/notmuch>
List-Post: <mailto:notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>
List-Help: <mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=help>
List-Subscribe: <http://notmuchmail.org/mailman/listinfo/notmuch>,
	<mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=subscribe>
Sender: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Errors-To: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140191>

Dnia wtorek 16. lutego 2010 14:06, Michal Sojka napisa=B3:
> On Tue, 16 Feb 2010 02:27:37 -0800 (PST), Jakub Narebski <jnareb-Re5JQEeQqe8@public.gmane.org=
m> wrote:
> > Michal Sojka <sojkam1-jQs2MHkdoM/twjQa/ONI9g@public.gmane.org> writes:
> > =

> > > I like the simple and powerful test suite used by Git and I would like
> > > to use something like that in Notmuch project (http://notmuchmail.org=
/).
> > > [...]
> >
> > Have you thought about using TAP (Test Anything Protocol) format for
> > your testsuite?  Its page (http://testanything.org) has a TAP-producing
> > bash library: http://testanything.org/wiki/index.php/Tap-functions
> =

> Yes, somebody has mentiond TAP on notmuch list. From a quick look at TAP
> shell library it seems to me a bit more complex then git's library and
> it also requires bash.
> =

> If we need to use some TAP-based tools, we could easily change the
> output of git's library to conform to TAP. Right?

Or better yet improve git test suite, so when passed --tap parameter
it would produce TAP output, instead of its own report format.  And
send patches here.

-- =

Jakub Narebski
Poland
