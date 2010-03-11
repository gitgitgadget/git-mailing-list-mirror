From: Pedro Ribeiro <pedrib@gmail.com>
Subject: generate a diff against a specific tag in a remote branch
Date: Thu, 11 Mar 2010 09:44:47 +0000
Message-ID: <74fd948d1003110144l382f7542qed4e80ea0fab6fde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 10:44:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npewq-0000lw-Ct
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 10:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab0CKJov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 04:44:51 -0500
Received: from mail-ew0-f216.google.com ([209.85.219.216]:53587 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995Ab0CKJou (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 04:44:50 -0500
Received: by ewy8 with SMTP id 8so1738877ewy.28
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 01:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=EEE9ckMoRPbfv78EcK5M9K6ouRtnguHSUjmIT6nBU5w=;
        b=FA29YR5/FGIgpU0QDm4W0FQzI114uOdswQ8siEneGSZPSHsW6UFvMOPHUEk/DfW/mD
         CVdmjGZMDVM/0L1JTZyqsaBAVdBUmBmk9N2T4c0n9hSSa1E7xgwYLAc2YjJcH1rfttKt
         B/pSmXRy12Zw7efDqPkYDS/pHpj8QQ3sAMC+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=piCQ2w2V2rgoVApd/SvcW7HwtTNq6z128v07q/UE58xoLcfVmsLCu7WA0uRMrD3hzB
         a6oHym8lbQSAgipSoFn54190h2n1UJz7XGmisDAips9G6ushk0YNCvUrmbzU54zi22x8
         tBJgr6gQasTbU6ma6WrZXzpCgqpGUQmEXmYvM=
Received: by 10.213.1.135 with SMTP id 7mr1839623ebf.91.1268300688052; Thu, 11 
	Mar 2010 01:44:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141945>

Hi all,

I currently have a copy of the kernel TuxOnIce git tree, and the
latest tag is 2.6.33.

I also have added linus tree as a remote branch
(git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git).

What I want to do is to make a patch of the TuxOnIce changes to apply
to the linus' 2.6.33. The problem is that the linus tree keeps
advacing, obviously, and is now at 2.6.34-rc1.

So what I've been trying to do is to make a diff against the 2.6.33
tag of linus' tree. Is this possible?


Thank you very much,
Pedro

PS: Please CC me directly, I'm not on the list.
