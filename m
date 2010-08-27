From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCH] shell: Display errors from improperly-formatted command lines
Date: Fri, 27 Aug 2010 13:32:05 -0400
Message-ID: <AANLkTim9Dbqt2Bs5F-PMYFrAwo4mAL6iVxmvYX1x4UYE@mail.gmail.com>
References: <1282887373-25618-1-git-send-email-gdb@mit.edu>
	<7vlj7shsn5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 19:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op2ml-0003Ag-T3
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 19:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944Ab0H0RcK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 13:32:10 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:63130 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754820Ab0H0RcI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 13:32:08 -0400
X-AuditID: 1209190d-b7b38ae000006976-be-4c77f69a4572
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Brightmail Gateway) with SMTP id 57.BF.26998.A96F77C4; Fri, 27 Aug 2010 13:32:10 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o7RHW7mv024045
	for <git@vger.kernel.org>; Fri, 27 Aug 2010 13:32:07 -0400
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com [209.85.161.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7RHW5SW017879
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 27 Aug 2010 13:32:06 -0400 (EDT)
Received: by gxk23 with SMTP id 23so1200702gxk.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 10:32:05 -0700 (PDT)
Received: by 10.151.84.16 with SMTP id m16mr2097496ybl.354.1282930325575; Fri,
 27 Aug 2010 10:32:05 -0700 (PDT)
Received: by 10.231.139.75 with HTTP; Fri, 27 Aug 2010 10:32:05 -0700 (PDT)
In-Reply-To: <7vlj7shsn5.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAhXElZUVxU3W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154611>

>> =A0shell.c | =A0 16 +++++++++++++---
>> =A01 files changed, 13 insertions(+), 3 deletions(-)
>
> Forgot to sign-off?
Yes, sorry:
Signed-off-by: Greg Brockman <gdb@mit.edu>

>> The error behavior of split_cmdline was changed in the patch =A0'spl=
it_cmdline: Allow
>> caller to access error string'. =A0This updates git-shell to deal wi=
th printing out
>> split_cmdline errors itself.
>
> Thanks for being careful. =A0I'll merge gb/split-cmdline-errmsg topic=
 (which
> already is in master) to gb/shell-ext topic (which is cooking in next=
) and
> then apply this on top. =A0With this update I suppose the topic is re=
ady to
> be in the next release?
Yep, I believe it's ready.

Thanks,

Greg
