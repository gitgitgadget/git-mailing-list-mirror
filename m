From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] mergetool: add an option for writing to a temporary
 directory
Date: Wed, 15 Oct 2014 21:30:11 +0200 (CEST)
Message-ID: <293924028.621540.1413401411270.JavaMail.zimbra@dewire.com>
References: <1413047085-12398-1-git-send-email-davvid@gmail.com> <xmqqk3433h8m.fsf@gitster.dls.corp.google.com> <20141015063848.GC14751@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:35:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeUMV-0005DP-4y
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 21:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbaJOTfv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2014 15:35:51 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:58285 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbaJOTfu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 15:35:50 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Oct 2014 15:35:50 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 21114815E0;
	Wed, 15 Oct 2014 21:30:15 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id TXFgzoYO9QM4; Wed, 15 Oct 2014 21:30:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 9FE3B81686;
	Wed, 15 Oct 2014 21:30:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RRdbEVfMg6OK; Wed, 15 Oct 2014 21:30:11 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 6FB36815E0;
	Wed, 15 Oct 2014 21:30:11 +0200 (CEST)
In-Reply-To: <20141015063848.GC14751@gmail.com>
X-Originating-IP: [78.69.107.197]
X-Mailer: Zimbra 8.0.7_GA_6020 (ZimbraWebClient - FF32 (Mac)/8.0.7_GA_6020)
Thread-Topic: mergetool: add an option for writing to a temporary directory
Thread-Index: 1AskutzFRN/1k2JioGvUBFCfjE5gDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



----- Ursprungligt meddelande -----
> Fr=C3=A5n: "David Aguilar" <davvid@gmail.com>
> Till: "Junio C Hamano" <gitster@pobox.com>
> Kopia: "Robin Rosenberg" <robin.rosenberg@dewire.com>, git@vger.kerne=
l.org, "Charles Bailey" <charles@hashpling.org>
> Skickat: onsdag, 15 okt 2014 8:38:49
> =C3=84mne: Re: [PATCH] mergetool: add an option for writing to a temp=
orary directory
>=20
> On Mon, Oct 13, 2014 at 12:24:41PM -0700, Junio C Hamano wrote:
> > David Aguilar <davvid@gmail.com> writes:
> >=20
> > > Teach mergetool to write files in a temporary directory when
> > > 'mergetool.writeToTemp' is true.
> > >
> > > This is helpful for tools such as Eclipse which cannot cope with
> > > multiple copies of the same file in the worktree.
> >=20
> > With this can we drop the "change the temporary file name" patch by
> > Robin Rosenberg?
> >=20
> > http://thread.gmane.org/gmane.comp.version-control.git/255457/focus=
=3D255599
> >=20
> > Message-Id: <1408607240-11369-1-git-send-email-robin.rosenberg@dewi=
re.com>
>=20
> I would think so but I'm biased ;-)

The new patch solves my problem.

-- robin
