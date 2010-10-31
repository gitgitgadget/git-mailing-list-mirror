From: Sebastien Douche <sdouche@gmail.com>
Subject: Add colors to the prompt for status indicators
Date: Sun, 31 Oct 2010 05:14:08 +0100
Message-ID: <AANLkTi=ZdR4_reQgxL+xRaFE=SaqBYAWTrEuGEbLGynt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 05:18:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCPMx-0005pf-H6
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 05:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964Ab0JaEOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 00:14:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61211 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab0JaEOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 00:14:49 -0400
Received: by iwn10 with SMTP id 10so5563951iwn.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 21:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=Mg+bhyktBMpx++r0za9mLTdEBlm+dRfnajO5l1yh7V8=;
        b=p+CtaqBLm+2oD7kkDMe77rEApmrJNx8dXQdr6t+QhBmBZadMEmFakGQdV4OF53r62z
         S8azzlQXkLEYh+LLBAL5tjnfp1DaSueuHqmC+fg+9gIh7BGSL6hm/Hk9sEnRCJGlocuv
         KtuVVeoh/GEzRY1jP3LLVlwY88/xUILXL8SD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=hhYL3zqKw3zyhGGA3mrcbe04XKRBGt/G3D0DQ0DBHA1z1FLyvgrZfkYuFU6ZazeS5k
         y7g5UumrjiKnUmf6ePYliSfnma46mHPk+rwLTs3FSyJm4ZRamu+f3zcZPOTwSiTN9eoP
         Nsp471YGr8V19TFJIDA97jVbVuLtOEyeq0yvE=
Received: by 10.42.230.193 with SMTP id jn1mr4800582icb.257.1288498488521;
 Sat, 30 Oct 2010 21:14:48 -0700 (PDT)
Received: by 10.231.183.3 with HTTP; Sat, 30 Oct 2010 21:14:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160414>

Hi,
the prompt (git-completion.bash) bundled with git is the most
"advanced" I found on the web. But I would add colors for "status".
Example show: * (unstaged) in blue, + (staged in red), $ (stashed) in
green, % (untracked) in bold blue and < > <> (upstream indicator) in
red.

How make this?

Cheers

-- 
Sebastien Douche <sdouche@gmail.com>
Twitter: http://bit.ly/afkrK (agile, lean, python, git, open source)
