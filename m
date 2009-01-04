From: "Frank Li" <lznuaa@gmail.com>
Subject: announce: TortoiseGit 0.2 preview released
Date: Sun, 4 Jan 2009 23:15:19 +0800
Message-ID: <1976ea660901040715l36667c7dld5f686e8c3624d1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, tortoisegit-announce@googlegroups.com
X-From: git-owner@vger.kernel.org Sun Jan 04 16:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJUj8-0005iX-37
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 16:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbZADPP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 10:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbZADPPX
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 10:15:23 -0500
Received: from rn-out-0910.google.com ([64.233.170.185]:45187 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbZADPPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 10:15:21 -0500
Received: by rn-out-0910.google.com with SMTP id k40so4722450rnd.17
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 07:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=30poxy/qn+L40qvlnfP9IW/N/RHlEjigyE7wiw223ZA=;
        b=xafaWWR8vOldk0+Sk6KMVQPaMYXyMtAr5miqoePJoIxd9uhtB/Qhbt0gVAJ15gIeNK
         zFsoq4xzE27q04dxFjIkaMyL+iuG5tneXI+TbBdNJeGb4JsrRerRDRqzslxGQsJxUiKp
         cMZJkFR5wyTc6nk/E3u9yDLg9Wd0LTQtHf3A4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=aL0BS/Y2Ob6jXJeHtXDZePWmu2yb4UfPgsf8vhq5jdRnUyEwzpyRjgkZr9q1P9sv3D
         DEnubMTrUw72SimipNYc7HJUAECWlkxV63x8zDMUnsaDDOknKwewc9wieNQk2wUHybPr
         ispdHlUn+lojVo77dbblJ8RYvRefLw67k5GRE=
Received: by 10.151.155.9 with SMTP id h9mr26278158ybo.208.1231082119409;
        Sun, 04 Jan 2009 07:15:19 -0800 (PST)
Received: by 10.151.136.13 with HTTP; Sun, 4 Jan 2009 07:15:19 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104519>

After heavy developing, TortoiseGit 0.2 preview release published.
TortoiseGit 0.2 can finish regular work, such as commit, show log,
diff version, create tag, create branch, create patchs.

Download:
http://code.google.com/p/tortoisegit/downloads/list

Version 0.2.0.0 preview version:
Features:
 1. Add TortoisgeMerge as default compare tools
 2. Pull, Fetch, Push
 3. Create Branch\Tag
 4. Switch branch \Chechout
 5. Compare with previous version
 6. Clone(only support local repository, see known issue for detail)
 7. Log Dialog support filter
 8. Check for modifications
 9. Revert local change
 10.Create Patch Serial
 11.Apply Patch Serial
 12.Add file to repository(see know issue)
 13.Export to zip file

Bug Fix:
 1. A2W cause stack overwrite bug when git output is long.


Known Issue:
 1. ProcessDlg will wait for ever when clone remote repository(ssh, http,git).
 2. push fetch and pull don't support password mode. Just support
public key problem.
 3. Just fetch first 100 log item.
 4. If install TortoiseGit before MsysGit, you need modify register
     HKEY_LOCAL_MACHINE\Software\TortoiseGit\\MsysGit\
    Let it point to correct msysgit install path.
 5. Add File, please commit and show unversion file, the choose add
file, then right clict, Choose Add file
 6. To new initial repository, You will not see add file again in
commit dialog box if give up commit when choose add
