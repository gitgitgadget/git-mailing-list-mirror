From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: tags and patches
Date: Wed, 13 Jun 2007 20:22:23 +0930
Message-ID: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 12:52:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyQSg-0000eb-SI
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 12:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281AbXFMKwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 06:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754146AbXFMKwZ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 06:52:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:19484 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbXFMKwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 06:52:25 -0400
Received: by ug-out-1314.google.com with SMTP id j3so380843ugf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 03:52:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qnFGT8KMC6sfoABGD6DnK3g/ufYtqd/xCM1Cn+GGbqtZxVwZiYBJKq9+WJuAp65ahgyCQ2S6DgikKfVggz1PikqlIjOkdd0J7ZDVpB49pwoSfJ3O4LWeFSzBKsOp/J3OkgXCpMl3Tzgps8R80Ihn1WtM626dKUiWHrn3i9p4yyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RVHVgWbJ6TVe9Mfb0C9d30o6CZOnqjbhfekjEjf6OC1r+dmfVmxAxcbUlQjtciMDgz67gFesZnH9GjqOyUR7zrZ5Z386jPU74u+r6qFq3IJOicohevoLE8ykcimFjHQFEsPAYm5SQ1jDObLBI9TQLsExc/XSQy9oC4ZYkNjrsHs=
Received: by 10.82.183.19 with SMTP id g19mr850465buf.1181731943410;
        Wed, 13 Jun 2007 03:52:23 -0700 (PDT)
Received: by 10.82.141.14 with HTTP; Wed, 13 Jun 2007 03:52:23 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50042>

Dear gits,

(I'm on 1.5.0.5)

The last tag made seems to be missing from a patch ... eg.

        cd ~ ; mkdir myrepo ; cd myrepo
        git init-db ; echo STUFF > xxx ; git add xxx
        # work, work, work on xxx
        git commit -a
        git tag v1.0
        # work work work on xxx
        # then I clone this repository
        cd /tmp ; git clone ~/myrepo newmyrepo
        # go back and work some more
        cd ~/myrepo
        echo YYY >>xxx
        git commit -a
        git tag v1.1
        # is git commit -a required to commit the tag???
        git format-patch v1.0
        cd /tmp/newmyrepo
        git am ~/myrepo/THEPATCHNAME
        git tag ls

Where is tag v1.1 ?

Cheers,
Geoff Russell
