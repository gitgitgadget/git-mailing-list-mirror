From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked files
Date: Wed, 18 Aug 2010 04:07:48 -0500
Message-ID: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
	<vpqsk2kjks7.fsf@bauges.imag.fr>
	<AANLkTimODL6j11D6QuUX4b47GwFOVOXdqkhqrRfRaxmq@mail.gmail.com>
	<AANLkTikV-fye7qc5kQNC5dSCTHB6nYoVfCg_PeFuk0KT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	gitster@pobox.com, Jens.Lehmann@web.de
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 11:08:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olecq-00020p-RQ
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 11:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab0HRJHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 05:07:54 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:57851 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942Ab0HRJHx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 05:07:53 -0400
X-AuditID: 12074422-b7bb6ae0000009fa-91-4c6ba2e0aa92
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id FD.F4.02554.0E2AB6C4; Wed, 18 Aug 2010 05:07:44 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o7I97pV3015155
	for <git@vger.kernel.org>; Wed, 18 Aug 2010 05:07:51 -0400
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7I97nUp009295
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 18 Aug 2010 05:07:50 -0400 (EDT)
Received: by ewy23 with SMTP id 23so158695ewy.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 02:07:48 -0700 (PDT)
Received: by 10.216.131.161 with SMTP id m33mr6794187wei.13.1282122468653;
 Wed, 18 Aug 2010 02:07:48 -0700 (PDT)
Received: by 10.216.172.79 with HTTP; Wed, 18 Aug 2010 02:07:48 -0700 (PDT)
In-Reply-To: <AANLkTikV-fye7qc5kQNC5dSCTHB6nYoVfCg_PeFuk0KT@mail.gmail.com>
X-Brightmail-Tracker: AAAAAhWs/CYVrch4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153819>

> I think "git add ignore-dir/file" above should act exactly like "git
> add file", and not force me to add a "-f" to "git add".
I agree.  That seems very much like the correct behavior.  FWIW, prior
to sending the patch I hadn't noticed that 'git add file' already
works without a '-f', which is why my commit message doesn't mention
it.

Anyway, I'm not sure if there's consensus on this being the right
behavior.  Thus I will take Matthieu's advice and propose a test-case
for the desired behavior.  I'll send that under separate cover in a
few moments.

Thanks everyone for contributing your thoughts thus far.

Greg
