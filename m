From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list
 available repositories
Date: Wed, 28 Jul 2010 19:14:54 -0400
Message-ID: <1280358894.31999.9.camel@balanced-tree>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
	 <20100726232855.GA3157@burratino>
	 <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com>
	 <201007270916.59210.j.sixt@viscovery.net> <20100727174105.GA5578@burratino>
	 <AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com>
	 <20100728003336.GA2248@dert.cs.uchicago.edu>
	 <AANLkTik1D45_cHPapbmMMys-V544ssCyoxrs5Fxck7oP@mail.gmail.com>
	 <20100728064251.GB743@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Brockman <gdb@mit.edu>, Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 01:15:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeFq6-0005Vr-GN
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 01:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711Ab0G1XPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 19:15:00 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:50434 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751774Ab0G1XO7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 19:14:59 -0400
X-AuditID: 1209190e-b7bbeae000000a09-ac-4c50b9f46c27
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 4B.85.02569.4F9B05C4; Wed, 28 Jul 2010 19:15:00 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o6SNEvJa016601;
	Wed, 28 Jul 2010 19:14:57 -0400
Received: from [192.168.1.32] (c-71-192-160-118.hsd1.nh.comcast.net [71.192.160.118])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6SNEtTY010957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 28 Jul 2010 19:14:56 -0400 (EDT)
In-Reply-To: <20100728064251.GB743@dert.cs.uchicago.edu>
X-Mailer: Evolution 2.30.2 
X-Brightmail-Tracker: AAAAARVg+I8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152127>

On Wed, 2010-07-28 at 01:42 -0500, Jonathan Nieder wrote:
> (if you use getpwent instead of getenv to fetch $HOME).

That seems like it could lead to problems with multiple users with the
same UID, and possibly also on Windows.  If it=E2=80=99s important to b=
e
paranoid here, what about all the other places Git already uses
getenv("HOME"), including where it reads ~/.gitconfig?

Anders
