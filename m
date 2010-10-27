From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Detect merge/rebase conflicts without changing the worktree?
Date: Thu, 28 Oct 2010 01:40:43 +0200
Message-ID: <AANLkTikuyGcK-j_hT2WxJiYVX784nPehZS8=F05N_eGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 01:40:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBFbu-0003os-EK
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 01:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab0J0Xkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 19:40:45 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52390 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab0J0Xko (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 19:40:44 -0400
Received: by qyk12 with SMTP id 12so4718622qyk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 16:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=HD/+OS03qi6TsLu72SeHuesAoctzM9xPBT14MStuf4A=;
        b=J1yR2i910vrVTjZ5Ah9O/94cM8to6AxV2rKow/sBlgc1TrMaUNyvaNO7CH/EWSe0YC
         ISo2oJTm9Z9rWcSlwWv6YPou1tVqzhoBMUy7wdvgnXHFpJpRCNKjhj0O6Bw7qPsvdhn2
         58+L32Vlj7RVcPFRhatSAsINAG2Buq8qRQ0uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=XTCcxZod/kYB9zPYlC3WPGhFVNeb+6qYALqFdyvs+AvZaiOhH52kDR7ZyTgOB0FT+1
         P3nISLU8QSIE37xqxFcPIDKTMkco7ivnTJXrnAYw2XV+b/jAvNeXdGn04yCL/Ya5utOC
         +6VCzbnsk/BvLyX2Sr9Y/wzEZNh9r7xQuaGY4=
Received: by 10.229.73.132 with SMTP id q4mr9931023qcj.132.1288222843213; Wed,
 27 Oct 2010 16:40:43 -0700 (PDT)
Received: by 10.229.182.209 with HTTP; Wed, 27 Oct 2010 16:40:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160136>

Hello

What is the recommended way to detect merge/rebase conflicts without
actually modifying the worktree? Should I use some combination of
custom $GIT_INDEX_FILE and --work-tree to lock the conflict resolution
into a directory specially made for this purpose? Is there even a way
to have the conflict-annotated files written to stdout instead of to
file system when a merge fails?

BR / Klas
