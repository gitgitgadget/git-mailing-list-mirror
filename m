From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] imap-send: link against libcrypto for HMAC and others
Date: Tue, 7 Dec 2010 23:53:40 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012072347560.6372@dr-wily.mit.edu>
References: <7vwro2sd83.fsf@alter.siamese.dyndns.org> <1290629033-20566-1-git-send-email-flameeyes@gmail.com> <1291613304.3339.12.camel@fixed-disk> <1291613978.4756.157.camel@yamato.local> <7v39qbtoq9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 05:58:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQC78-0007Pz-Sg
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 05:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab0LHE6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 23:58:46 -0500
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:53439 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751815Ab0LHE6p convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 23:58:45 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2010 23:58:45 EST
X-AuditID: 1209190e-b7b3bae000000a71-c1-4cff0f57bcc4
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 0F.53.02673.75F0FFC4; Tue,  7 Dec 2010 23:53:43 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id oB84rgPQ029681;
	Tue, 7 Dec 2010 23:53:43 -0500
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oB84rfK7020402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 7 Dec 2010 23:53:42 -0500 (EST)
In-Reply-To: <7v39qbtoq9.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163171>

On Sun, 5 Dec 2010, Junio C Hamano wrote:
> Anders, wouldn't this be a better fix for NO_OPENSSL build, than reve=
rting
> a fix for an incorrect ld invocation?

It works for me.  I agree it isn=E2=80=99t beautiful but I don=E2=80=99=
t think I have a=20
better idea at this time.

(It=E2=80=99s worth pointing out that $(OPENSSL_LINK) is duplicated in =
the=20
git-imap-send build command, once directly and once indirectly via=20
$(LIB_4_CRYPTO), but I assume this is intentional for clarity.)

Anders
