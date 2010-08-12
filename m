From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 05:37:33 -0400
Message-ID: <AANLkTi=MenKX7Eh5PTpjfiYirrgLBCamWgorA35rx-Fy@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 11:37:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjUEL-0003wn-Qt
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 11:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759241Ab0HLJhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 05:37:39 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:63243 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753337Ab0HLJhj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 05:37:39 -0400
X-AuditID: 12074422-b7bb6ae0000009fa-b3-4c63c0d7f4c2
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id E6.4B.02554.7D0C36C4; Thu, 12 Aug 2010 05:37:28 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o7C9ba9W007082
	for <git@vger.kernel.org>; Thu, 12 Aug 2010 05:37:37 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7C9bXCb000768
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 12 Aug 2010 05:37:35 -0400 (EDT)
Received: by wyb32 with SMTP id 32so1173691wyb.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 02:37:33 -0700 (PDT)
Received: by 10.216.28.213 with SMTP id g63mr6486596wea.71.1281605853705; Thu,
 12 Aug 2010 02:37:33 -0700 (PDT)
Received: by 10.216.19.142 with HTTP; Thu, 12 Aug 2010 02:37:33 -0700 (PDT)
In-Reply-To: <4C63BD9B.6000608@viscovery.net>
X-Brightmail-Tracker: AAAAAhWWOO0VlxO6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153358>

>> * gb/shell-ext (2010-07-28) 3 commits
>> =A0- Add sample commands for git-shell
>> =A0- Add interactive mode to git-shell for user-friendliness
>> =A0- Allow creation of arbitrary git-shell commands
>
> This needs work on Windows because we do not have geteuid(), perhaps =
just
> a compiler flag -Dgeteuid=3Dgetuid
I had a submitted a revised patch that just uses HOME, see
http://thread.gmane.org/gmane.comp.version-control.git/152050/focus=3D1=
52135.
 I guess that didn't make it in yet.

Thanks,

Greg
