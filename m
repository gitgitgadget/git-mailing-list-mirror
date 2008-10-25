From: Pascal Obry <pascal@obry.net>
Subject: Problem with git filter-branch
Date: Sat, 25 Oct 2008 11:33:12 +0200
Organization: Home - http://www.obry.net
Message-ID: <4902E7D8.6050401@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 25 11:34:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtfXX-0000Xk-21
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 11:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbYJYJdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 05:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbYJYJdV
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 05:33:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:2742 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbYJYJdV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 05:33:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1247913fgg.17
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 02:33:19 -0700 (PDT)
Received: by 10.86.68.2 with SMTP id q2mr1033605fga.34.1224927198582;
        Sat, 25 Oct 2008 02:33:18 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-2-53.w82-124.abo.wanadoo.fr [82.124.64.53])
        by mx.google.com with ESMTPS id l19sm2054527fgb.7.2008.10.25.02.33.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Oct 2008 02:33:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.17) Gecko/20080914 Thunderbird/2.0.0.17 Mnenhy/0.7.5.0
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99100>


I'm using Git svn but I do not think this matters.

I'm used to add manually some branches from the Subversion repository. I
usually fetch the branch without following the parent then connect the
branch to the proper branch point (I really need to do this as the
Subversion repository structure is not following the standard layout).

Anyway, I used to run the following command:

$ git filter-branch --tag-name-filter cat --parent-filter "sed -e
's/^$/-p c96d4da294667de1800687d25340551683153002/'" svn-release_2_6

without problem, I now get this:

Namespace refs/original/ not empty
rm: cannot remove directory
`/home/obry/dev/repositories/git/proj/.git-rewrite': Directory not empty

The .git-rewrite is empty and when the command return I can do:

$ rmdir .git-rewrite

without problem.

Is this is known issue? Any idea?

Thanks,
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
