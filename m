From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH v4] git-new-workdir: Don't fail if the target directory
 is empty
Date: Wed, 10 Dec 2014 12:16:57 -0500
Message-ID: <1418231817.3947.4.camel@mad-scientist.net>
References: <1417034308.23650.51.camel@homebase>
	 <xmqq8uixpqyx.fsf@gitster.dls.corp.google.com>
	 <1417041115.23650.69.camel@homebase>
	 <xmqqk32ho8mc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 18:18:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyku8-0006n7-He
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 18:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbaLJRST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Dec 2014 12:18:19 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:43930 "HELO
	gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932247AbaLJRSR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 12:18:17 -0500
Received: (qmail 20376 invoked by uid 0); 10 Dec 2014 17:18:16 -0000
Received: from unknown (HELO CMOut01) (10.0.90.82)
  by gproxy1.mail.unifiedlayer.com with SMTP; 10 Dec 2014 17:18:16 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by CMOut01 with 
	id RtH51p00g2qhmhE01tH86o; Wed, 10 Dec 2014 10:17:08 -0700
X-Authority-Analysis: v=2.1 cv=OJu0g0qB c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=2NV5t7OSZ7cA:10 a=A92cGCtB03wA:10 a=HHraBdiP_g69TJjr_L4A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=mrzNxJzKNlXRfJm1MPD6UgJHOpgxUmspMO1ZEfpFG1U=;
	b=ZlXVtsBElvpPoXb65mtwW8jhdwnk2RaD2IFQ8O81AtwAbQ7apX9wrq1glytbcM4vuCQiqcmpb5w0aldavjbnaOYsePC0PsWx+/NKsnQl7r/XwoG3OYqzEWfckt8pOGJH;
Received: from [173.9.45.73] (port=39072 helo=pdsdesk)
	by box531.bluehost.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1Xyksr-0005Uh-1u; Wed, 10 Dec 2014 10:17:05 -0700
In-Reply-To: <xmqqk32ho8mc.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 173.9.45.73 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261224>

On Wed, 2014-11-26 at 15:16 -0800, Junio C Hamano wrote:
> Paul Smith <paul@mad-scientist.net> writes:
>=20
> > This is what happens for a file:
> >
> > $ rm -f foo
> >
> > $ touch foo
> >
> > $ ./src/git/contrib/workdir/git-new-workdir src/git foo master
> > mkdir: cannot create directory =E2=80=98foo=E2=80=99: Not a directo=
ry
> > unable to create new workdir "foo"!
>=20
> ;-)  That comes from mkdir || fail which is indeed sufficient.

Hi Junio;

Is this all set to be applied or is there more to do?

Cheers!
