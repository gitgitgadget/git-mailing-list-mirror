From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: git cherry-pick --continue?
Date: Wed, 10 Feb 2010 21:37:10 +0100
Message-ID: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 21:37:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfJJY-0004ss-06
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 21:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930Ab0BJUhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 15:37:31 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:64673 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab0BJUha (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 15:37:30 -0500
Received: by pzk17 with SMTP id 17so421452pzk.4
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 12:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=n79yTKYUaDxsqnBlJmgXyQnCoNJqNYcHUH918NBmv9Q=;
        b=hZSYX1VG9Xb8Yqah38H8CNlCLpr32/QYvm/At164hUr0CiEqEG8T0JLlgBSHFO7rsp
         gKv5qde8xG8IsTRb9H/ikLM3C3f6V6uBMbQOABPLL9EpRUyZriNcKdApeTOP6fD8nK/g
         Et6kTCoR26NoMj1Ltt9fP4z4h0IbU0pKLzOUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=jJSvPUQx5aaN4eH1TpgMF0aBDeJGEA2RHGGSpHq/8T5mRQsyDk78Q3tCRCNtd0U2Cx
         kUiGywi06AD5Uf1xAS4QEuxuBTPsXCg/0J+ZEFy00NNwXDGTeXa7J2Fh5Sx6SciwBTTY
         WvUjXXezVk0qy95xEJp7zC2Xdp555LXnB6zaw=
Received: by 10.142.65.14 with SMTP id n14mr471687wfa.212.1265834250070; Wed, 
	10 Feb 2010 12:37:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139548>

Heya,

At the moment git cherry-pick stands out from the sequencer tools in
that it doesn't support --continue but requires you to manually supply
the '-c ...' argument to 'git commit' when there's a conflict instead.
Is it desirable that we add such an option? And if so, how would one
go about implementing it?

-- 
Cheers,

Sverre Rabbelier
