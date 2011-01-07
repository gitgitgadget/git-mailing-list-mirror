From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] Mark gitk script executable
Date: Fri, 7 Jan 2011 15:56:57 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1101071548020.31807@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1101061943140.6372@dr-wily.mit.edu> <7vlj2x8mr4.fsf@alter.siamese.dyndns.org> <20110107030119.GA32290@burratino> <7v4o9k7brc.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.02.1101071526180.31807@dr-wily.mit.edu>
 <7vbp3s5tpl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 21:57:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbJMx-0006M6-Fu
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 21:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483Ab1AGU5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 15:57:00 -0500
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:49035 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751801Ab1AGU5A convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 15:57:00 -0500
X-AuditID: 1209190e-b7b3bae000000a71-ce-4d277e1b1e8e
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id D0.61.02673.B1E772D4; Fri,  7 Jan 2011 15:56:59 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id p07Kuw7j006043;
	Fri, 7 Jan 2011 15:56:58 -0500
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p07KuvXX004726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 7 Jan 2011 15:56:57 -0500 (EST)
In-Reply-To: <7vbp3s5tpl.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164763>

On Fri, 7 Jan 2011, Junio C Hamano wrote:
> If that is the case perhaps the next pull will fix that ;-)

Nope.  There=E2=80=99s nothing to pull; the current gitk.git master was=
 already=20
taken by the last pull.  Even once there are commits to pull, the commo=
n=20
ancestor will be 6758ad94, in which the script is executable, so the=20
script will remain non-executable in the merge result.  (And you can se=
e=20
for yourself that the last 28 pulls since 62ba5143 haven=E2=80=99t adde=
d the=20
executable bit.)

The point is that 62ba5143 introduced a change to git.git that wasn=E2=80=
=99t in=20
gitk.git, and that change will remain in git.git until it=E2=80=99s und=
one in=20
git.git.

Anders
