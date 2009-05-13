From: Matt Graham <mdg149@gmail.com>
Subject: [BUG] git add -p doesn't actually add
Date: Wed, 13 May 2009 00:41:34 -0400
Message-ID: <1c5969370905122141x527e46dev3929c4cb43c9409d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd6ab727b31fb0469c3d346
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 06:41:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M46Hs-0004kz-IS
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 06:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbZEMElg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 00:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbZEMElf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 00:41:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:37358 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbZEMEle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 00:41:34 -0400
Received: by yw-out-2324.google.com with SMTP id 5so230976ywb.1
        for <git@vger.kernel.org>; Tue, 12 May 2009 21:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=VFFQRfdX6MVN/NuwABbSdMRp0rw5gotWOeq8NicqLbI=;
        b=w3BGQkp3R+WwXACaN3WwLvWDy3is+NHMbCP7h+zB3w79Ad5W/PM1HljPQUXeTQLz4L
         2k9ZIovWU9NbV9Pl5PDPpVcsxbSnyrtZsQG5zW27Csrc1n2tgVNxkkM3ErCnTNHtiTYl
         QF0wE/P8qAaa0a9ZEs2mPi3tne1cYKtS6/OEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=AE1qd5K3SD2r4LgIRyvlm8M42MHySyKI8Iku/UzJk7Z6pFHJm74as4HWQr8r16ZKBt
         jbf0wRUir9Ep38aq1E6jCiSFExRr0JYA8X+lGIFT2PgznQ7oLz02HhFGaif2EKZAmTd+
         CTv7cOxTMyVdwKKq1g4scieG6aj+TyvVyuRS4=
Received: by 10.150.11.20 with SMTP id 20mr64111ybk.348.1242189694447; Tue, 12 
	May 2009 21:41:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118979>

--000e0cd6ab727b31fb0469c3d346
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
I'm having a couple problems with git add -p

First problem:
1. I run "git add -p filename"
2. Split the first diff
3. Edit the first diff
4. Don't change the file, immediately write it and close the editor
I get this error:

Stage this hunk [y,n,q,a,d,/,j,J,g,e,?]? e
error: patch failed: src/pygrate/pygrator.py:1
error: src/pygrate/pygrator.py: patch does not apply
Your edited hunk does not apply. Edit again (saying "no" discards!) [y/n]? n


Second problem (on the same file):
1. I run "git add -p filename"
2. Split the first diff
3. answer 'y' to all
I run git status and it says the file is changed but not updated


The attached file shows this behavior for my version of git.
git version 1.6.3.9.g6345    (pulled from master tonight)

--000e0cd6ab727b31fb0469c3d346
Content-Type: application/x-gzip; name="git-add-p.tar.gz"
Content-Disposition: attachment; filename="git-add-p.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_funjk9o50

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
hKWTAMgAAA==
--000e0cd6ab727b31fb0469c3d346--
