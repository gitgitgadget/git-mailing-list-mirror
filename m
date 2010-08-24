From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCH v3] shell: Rewrite documentation and improve error message
Date: Tue, 24 Aug 2010 01:43:31 -0400
Message-ID: <AANLkTikeZTF5zZyRDtLfnPrtCYFH0WayXrJeCj8_VuC1@mail.gmail.com>
References: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
	<AANLkTi=u7VUhz4VrU2hdd3SXK7rMvMrijL-X9qXCG1vs@mail.gmail.com>
	<20100822080359.GB15561@kytes>
	<AANLkTintw7=25nsr-7NjE_-xJqMab_HggjPOtSHBf109@mail.gmail.com>
	<20100824053647.GA2037@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 07:43:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnmIR-0007AD-7b
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 07:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab0HXFng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 01:43:36 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:65201 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751859Ab0HXFnf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 01:43:35 -0400
X-AuditID: 12074422-b7bbfae000005e9b-57-4c735c004306
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id 8D.BF.24219.00C537C4; Tue, 24 Aug 2010 01:43:28 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o7O5hWAm012623
	for <git@vger.kernel.org>; Tue, 24 Aug 2010 01:43:34 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7O5hVF6024262
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 24 Aug 2010 01:43:32 -0400 (EDT)
Received: by iwn5 with SMTP id 5so4221502iwn.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 22:43:31 -0700 (PDT)
Received: by 10.231.149.3 with SMTP id r3mr7761727ibv.109.1282628611216; Mon,
 23 Aug 2010 22:43:31 -0700 (PDT)
Received: by 10.231.154.212 with HTTP; Mon, 23 Aug 2010 22:43:31 -0700 (PDT)
In-Reply-To: <20100824053647.GA2037@kytes>
X-Brightmail-Tracker: AAAAAxWs/CYVrch4Fa3jhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154294>

> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"hint: ~/$COM=
MAND_DIR should exist "
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"hint: ~/" $C=
OMMAND_DIR " should exist "
There's still a floating $.  (Recall, you're in C land here, not shell.=
)
