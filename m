From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] bisect reset: Allow resetting to any commit, not just
 a   branch
Date: Tue, 13 Oct 2009 10:29:20 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0910131025220.5105@dr-wily.mit.edu>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu> <7vr5t8coex.fsf@alter.siamese.dyndns.org> <4AD420BC.5060506@viscovery.net> <7v3a5n3hgn.fsf@alter.siamese.dyndns.org> <4AD43002.5080003@viscovery.net> <7vtyy3zo9m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 16:35:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxiSf-0000dA-7B
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 16:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbZJMOaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 10:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbZJMOaG
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 10:30:06 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:59797 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751273AbZJMOaF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 10:30:05 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n9DETIWR008046;
	Tue, 13 Oct 2009 10:29:18 -0400 (EDT)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n9DETKBd017414;
	Tue, 13 Oct 2009 10:29:21 -0400 (EDT)
In-Reply-To: <7vtyy3zo9m.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130164>

On Tue, 13 Oct 2009, Junio C Hamano wrote:
> I agree that "git bisect reset-and-detach-at-the-first-bad-one" would=
 make
> a lot of sense.

Under my patch, that=E2=80=99s =E2=80=98git bisect reset bisect/bad=E2=80=
=99.  Similar arguments=20
may be made as to whether that should or shouldn=E2=80=99t be a separat=
e command=20
(although it=E2=80=99s less clear what to call it, in this case).

Anders
