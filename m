From: Ping Yin <pkufranky@gmail.com>
Subject: What the best git repack option to avoid out of memory (2G free memory)
Date: Sun, 17 Apr 2011 11:24:57 +0800
Message-ID: <BANLkTimOnuSsSeuZ5QvLQLZBg1QnnDzaNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 05:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBIc3-0001fQ-SL
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 05:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533Ab1DQDY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 23:24:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38626 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab1DQDY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 23:24:58 -0400
Received: by bwz15 with SMTP id 15so3040928bwz.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=dyZ6Yig8B6ddq0GSmSYPDM7zZqBRbC4aEhL9bDp+QBw=;
        b=RqekKQY1cTwiDMyx5E5NozAwrkzIKQAJVGp4DA0HvLna8hy1H2TyQWl3FqLl0cbLZK
         LYz+IsECHs/Xq7wsFLq9okhynQ7TFC7JDpMK6WuANheY9qpFR61GLoGTxybmwUelMIrQ
         2Ft4eOaOBy2P/Jy7+eQu1KGIufAHr8Nylwn94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=NcfSLEyNsChdYtHYyn7y93qnz0S/b4AefRYIgOZPMtKdBTlJBL0cZY/dwcPyuD+Fyg
         IAqkpsDsNH5Ue3yc9f8AseKuWDglqP0boBC76kYw/q4es1yZPalbaupqknuvj+XurE4x
         /RWAag5qzOszZnQfAmD/s01vG/ErLb0kVEZCU=
Received: by 10.204.141.12 with SMTP id k12mr2945467bku.44.1303010697071; Sat,
 16 Apr 2011 20:24:57 -0700 (PDT)
Received: by 10.204.53.18 with HTTP; Sat, 16 Apr 2011 20:24:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171710>

When "gc --auto --aggressive --prune" android platform/prebuilt.git, i
encountered the following error:

Auto packing the repository for optimum performance.
warning: suboptimal pack - out of memory
fatal: Out of memory, malloc failed
error: failed to run repack

I have 2G free memory available and found the --window and
--window-memory option in git repack. However, i wonder how to compute
the max memory git-repack will use, is it "window * window-memory"?

And what is the best --window and --window-memory option for the 2G
free available memory?
