From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Rename git-core rpm to just git and rename the
	meta-pacakge to git-all.
Date: Mon, 18 Feb 2008 14:00:47 -0500
Message-ID: <1203361247.4082.8.camel@gaara.boston.redhat.com>
References: <1203100163-17509-1-git-send-email-krh@redhat.com>
	 <7vskzs2exj.fsf@gitster.siamese.dyndns.org>
	 <76718490802180651h2ad61c4cg50bae97000957397@mail.gmail.com>
	 <1203350676.4082.0.camel@gaara.boston.redhat.com>
	 <7v7ih2p0wk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:31:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRBiP-000741-Dk
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 20:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbYBRTbP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 14:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbYBRTbP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 14:31:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45313 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615AbYBRTbO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 14:31:14 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1IJ0rsj030752;
	Mon, 18 Feb 2008 14:00:53 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1IJ0qeU024619;
	Mon, 18 Feb 2008 14:00:52 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1IJ0q8O026802;
	Mon, 18 Feb 2008 14:00:52 -0500
In-Reply-To: <7v7ih2p0wk.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.21.4 (2.21.4-1.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74336>


On Mon, 2008-02-18 at 10:36 -0800, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > On Mon, 2008-02-18 at 09:51 -0500, Jay Soffian wrote:
> >> On Feb 17, 2008 2:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >>=20
> >> > "yum install git" and "yum install git-core" do not give such an
> >> > error but the latter gives quite a bunch of errors ("yum install
> >> > git" goes alright).  This is problem #2.
> >>=20
> >> You probably want "yum upgrade git-core".
> >>=20
> >> The "problem" is that yum by default doesn't process RPM renames (=
obsoletes)
> >> unless you either have obsoletes=3D1 in your yum.conf, use "yum --=
obsoletes
> >> update" or use "yum upgrade".
> >
> > Ah, that's what it is.  Thanks, I wasn't aware of this issue.
>=20
> Does that mean that the test I did and the problem I saw were
> end-user errors and that there is no proble with your patch and
> I can use it as-is to cut 1.5.4.3 and future ones?
>=20
> That's a great news.
>=20
> But perhaps we would need some description/warning to help end
> users as clueless as I am with respect to yum in the release
> notes and/or announcements?

We could, but could you provide a little more detail about the system
you tested on?  I have=20

  obsoletes=3D1

in my /etc/yum.conf, which has been default in Fedora since October
2004.

> Could you resend the patch with a commit log message that I can
> later reuse parts from for such a purpose, with a sign-off
> please?

Yup, I'm getting a new patch together to address the comments from your
earlier mail.  Also, I had the git-all package in there, but it turns
out that without a %files section, rpm doesn't create the rpm.  New
patch coming up in a few minutes.

Kristian
