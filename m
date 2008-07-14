From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
 completion
Date: Mon, 14 Jul 2008 07:51:54 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807140751090.3305@woody.linux-foundation.org>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org>
 <20080714000021.GB13066@spearce.org> <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org> <20080714062755.GA15992@spearce.org> <20080714064719.GA26446@atjola.homenet> <20080714065018.GB26446@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 16:55:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIPS4-0003Ws-FJ
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 16:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbYGNOx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 10:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbYGNOx5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 10:53:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39809 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753470AbYGNOx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2008 10:53:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6EEptn6014062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jul 2008 07:51:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6EEpsdn012549;
	Mon, 14 Jul 2008 07:51:54 -0700
In-Reply-To: <20080714065018.GB26446@atjola.homenet>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.4 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88430>



On Mon, 14 Jul 2008, Bj=F6rn Steinbrink wrote:
> >=20
> > Seems that gvfs comes with a completion script that deliberately dr=
ops
> > the : from COMP_WORDBREAKS. Do you have that installed Linus?
>=20
> Ah crap, I should have mentioned which file I'm talking about... It's
> /etc/profile.d/gvfs-bash-completion.sh

Yup. Part of gvfs-0.2.5-1.fc9.x86_64 for me.

		Linus
