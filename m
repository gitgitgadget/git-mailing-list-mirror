From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] New po/git.pot generated for Git 1.7.10-rc1
Date: Fri, 16 Mar 2012 21:43:01 +0800
Message-ID: <CANYiYbGZ7mQaqyAxOiHOdMfDSy0VsDgLaWiBTTaZ30asiSU0nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Mar 16 14:50:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8XXk-0000IX-RP
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 14:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032218Ab2CPNuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 09:50:01 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46544 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030389Ab2CPNuA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 09:50:00 -0400
Received: by wibhj6 with SMTP id hj6so897635wib.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=KKMsOoOVc2BPpCkPaCFQA1HtCnyePMmwDStsYmeWwFs=;
        b=R3grTwAVJQxa77AHq6/01gjewW+ovr8B310+JY0sxRQE6phBQwo6txpkkmjh65Ouu9
         eNC/3gfJTgnAKnvYwHSlCnLrRqkDvOSq5Xs/ou4qfO7z5KTW9H+/DL1nmfLmW/Togu/I
         K7irejZP9aKXU/OGp1qrslQTLxFMa2b9aQFtFE6KIvoiU801rFKLWqkggGWzGvOrPn3N
         Zud/z0KxOcyrMek3TNWjNN3sImh/DQIvD8l69Wcu/3f6vRfgxMr11CD3Kfv2dExuJMtO
         iZyANyBb/W4E/plawoLVoSqWztxikB1tlbUl7UDyj7u/0jSPdZBrIaayuqY1e6oFF41Q
         pOHg==
Received: by 10.52.64.234 with SMTP id r10mr1592871vds.39.1331905381910; Fri,
 16 Mar 2012 06:43:01 -0700 (PDT)
Received: by 10.52.26.37 with HTTP; Fri, 16 Mar 2012 06:43:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193260>

L10n team leaders,

It time to update your translations to the new git.pot for Git 1.7.10-rc1.
A new "po/git.pot" file is generated in the l10 coordinator repository:

    https://github.com/git-l10n/git-po/

Updates of "po/git.pot" for this new revision since last update:

 * 1 new l10n message at line: 3361

In order to update your translations, l10n team leaders should:

 1. Pull from the l10 coordinator repository;
 2. update your locale file, make a commit;
 3. and then push your commit to the repository of your l10n team.

You can update locale file use this command:

    msgmerge --add-location --backup=off -U XX.po git.pot

After push the commits with new translations to your forked repository
of your l10n team, please send a pull request to the 10n coordinator
repository on GitHub. But before that it is helpful to check your locale
file and new commits as follows:

 * Do a syntax check on XX.po

   msgfmt -o /dev/null --check --statistics XX.po

 * Check your commit logs, and make sure that if there are non-ascii
   characters, the commit logs must have a proper encode setting.
   A helper script can help:

       po-helper.sh check commits

The helper script can be found at:

 * https://github.com/gotgit/git-po-zh_CN/raw/po-helper/po/po-helper.sh

-- 
Jiang Xin
