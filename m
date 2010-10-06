From: fREW Schmidt <frioux@gmail.com>
Subject: Git over SMBFS
Date: Tue, 5 Oct 2010 21:26:15 -0500
Message-ID: <AANLkTik9U_jr6r6BuUcRrk8pjQTacKDY7YbqWnfrCLmD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 06 04:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3JuT-00056F-Bs
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 04:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758390Ab0JFCjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 22:39:04 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47479 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758294Ab0JFCjC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 22:39:02 -0400
Received: by qyk10 with SMTP id 10so3480788qyk.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 19:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=WDI8tRS6zGm5NyWk+m0zBPjV0y63Fg525zzggCaIopU=;
        b=P95jzf3fejmGBjydzDOkbIyu45p1ggS7LpZ3gwSCF59VMWzn+aov6v4hKcavzYZIME
         gyMjyoLR7lgQ/Zbv41Dx3PpNIIwFq5QaOu+M4PBnlagTkjrX5FJXKsJOZIspsGXls/IJ
         lptQg3BczvykOJ2fNfYRcXlORpD/nuqQUtQN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=HQoqTQuV8JontXKKtmgtFptL2IRxCDQU0mLOQt456KA2XJ+Anq4sAyeeCKPn2X0Ctl
         WVoctVUUL+kpmewlF3aqjHXhokVGClUiec16ae0VVqqF/KdM693Ra/JgQiPKzXZAV/Jk
         /IopI7692g2LfqfVN8dY5X7/Y72XLS+KuV2zo=
Received: by 10.224.95.204 with SMTP id e12mr8774660qan.360.1286332741612;
 Tue, 05 Oct 2010 19:39:01 -0700 (PDT)
Received: by 10.224.67.80 with HTTP; Tue, 5 Oct 2010 19:26:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158263>

A coworker of mine is working on a project that is running on a
windows server.=A0 The project is in git, but we are having a lot of
trouble getting it to work at all.=A0 For example, if he merely does
(from his machine) "git checkout ." it seemingly times out after 680
files being checked out.

Are there any settings we might be able to tweak that might make git
more tolerable of the latency involved in a network based checkout?

--
fREW Schmidt
http://blog.afoolishmanifesto.com
