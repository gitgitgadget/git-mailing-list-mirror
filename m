From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: UI and git-completion.sh
Date: Tue, 23 Oct 2007 23:46:17 +0200
Message-ID: <20071023234617.45a4fc64@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 23:46:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkRZw-0007l3-D4
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 23:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbXJWVqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbXJWVqM
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 17:46:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:47596 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbXJWVqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 17:46:11 -0400
Received: by ug-out-1314.google.com with SMTP id z38so211242ugc
        for <git@vger.kernel.org>; Tue, 23 Oct 2007 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=/WaPuPbmKovtrdUecZZHgcMeKLzA3gfawzaeXoqjjGU=;
        b=MTwcEsNg8T0Hh72iU8JEHRzHM7hzsPm1f+UqcqhctPCJffoTe+Ux6PL2/aF3HyWZ62uYBIwezBEBmpFkCCF8tzF1Za/x/ZW5UCCEF2GbaAn42Ni1qF0o5J9rbiDVqXjTftd/tz6DAiRMg9nr4et54s+27dmj256gZNxlCZVeJlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mSwml6HPwqqkFiGpbW/YwRTOquDUV4pDcI1Aih6SdifvkZ9bTllK+aG4YRj/m2QUmhv0iNsRAtnwKDY9GRzr/2QRy8ts7VhpvfBA2+9ZFuoqr59q+pkGydFEZyMdsidh2InRFme3uAvXvgF3fH5sf4FIA7/tdpCfQrmwxMwkEMM=
Received: by 10.67.196.2 with SMTP id y2mr1300678ugp.1193175969880;
        Tue, 23 Oct 2007 14:46:09 -0700 (PDT)
Received: from paolo-desktop ( [82.50.3.236])
        by mx.google.com with ESMTPS id o7sm903285uge.2007.10.23.14.46.08
        (version=SSLv3 cipher=OTHER);
        Tue, 23 Oct 2007 14:46:09 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62162>

Hi all,
I just asked for help on the #git irc channel in order to install
the .git-completion.sh script (thanks nessundorma) and after using it 
for a while I started wondering why I cannot find any reference to it the 
official documentation.
The only important think that git grep found is:
	paolo@paolo-desktop:~/git$ git grep completion *
	Documentation/RelNotes-1.5.0.txt: - Bash completion scripts have been updated heavily.
Shouldn't it be mentioned somewhere? 

I know that newbies are somehow scared by the following:
	paolo@paolo-desktop:~/git$ git-
	Display all 151 possibilities? (y or n)
What? Do I have to learn 151 commands?
No way!

Using the git-completation script it all boils down to 48 commands.

paolo@paolo-desktop:~/git$ git 
add                   fetch                 rebase 
am                    filter-branch         rebase--interactive 
annotate              format-patch          relink 
apply                 fsck                  remote 
archive               gc                    repack 
bisect                get-tar-commit-id     request-pull 
blame                 grep                  reset 
branch                gui                   resolve 
bundle                imap-send             revert 
checkout              init                  rm 
checkout-index        instaweb              send-email 
cherry                log                   shortlog 
cherry-pick           lost-found            show 
citool                ls-files              show-branch 
clean                 ls-remote             show-ref 
clone                 ls-tree               stash 
commit                merge                 status 
config                mergetool             submodule 
convert-objects       mv                    tag 
count-objects         name-rev              var 
describe              pickaxe               verify-pack 
diff                  pull                  whatchanged 
diff-stages           push

And I think I can remove some commands from the list.

What people think about starting suggesting the usage of the script in the documentation?
I just want to know the opinion of the list before trying to write a documentation patch.
Next step would be to reduce the number of the items listed by git <tab> but I know there is 
already a discussion about it on the list.

Regards,
		Paolo
