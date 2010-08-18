From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [RFC/PATCH] Add test case for dealing with a tracked file in an
 ignored directory
Date: Wed, 18 Aug 2010 04:43:08 -0500
Message-ID: <AANLkTik5t9Y8bLOLhnckPDXMh7gmC8s0xikg8xRfEpwU@mail.gmail.com>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
	<1282123788-24055-1-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Brockman <gdb@mit.edu>
To: avarab@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 18 11:43:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlfB9-00088E-NH
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 11:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab0HRJnP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 05:43:15 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:64730 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942Ab0HRJnM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 05:43:12 -0400
X-AuditID: 1209190c-b7c0dae000000a0c-92-4c6bab31d284
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id FB.6C.02572.13BAB6C4; Wed, 18 Aug 2010 05:43:13 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o7I9hBFQ017187
	for <git@vger.kernel.org>; Wed, 18 Aug 2010 05:43:11 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7I9h99b012823
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 18 Aug 2010 05:43:11 -0400 (EDT)
Received: by wwi17 with SMTP id 17so583450wwi.1
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 02:43:09 -0700 (PDT)
Received: by 10.227.135.78 with SMTP id m14mr6815824wbt.47.1282124588917; Wed,
 18 Aug 2010 02:43:08 -0700 (PDT)
Received: by 10.216.172.79 with HTTP; Wed, 18 Aug 2010 02:43:08 -0700 (PDT)
In-Reply-To: <1282123788-24055-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAARWtyHc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153824>

Whoops, forgot the sign-off line:

> This test case attempts to match the behavior of 'git add ignore-file=
'
> with 'git add ignore-dir/file' when .gitignore contains entries for
> ignore-file and ignore-dir.

Signed-off-by: Greg Brockman <gdb@mit.edu>

> ---
> =A0t/t3700-add.sh | =A0 30 ++++++++++++++++++++++++++++++
> =A01 files changed, 30 insertions(+), 0 deletions(-)
>
> This patch is a follow-up to the thread '[RFC/PATCH] git-add: Don't
> exclude explicitly-specified tracked files' at
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/153194
=2E..
