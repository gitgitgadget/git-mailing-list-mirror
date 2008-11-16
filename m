From: Luca Siciliano Viglieri <lsiciliano@web.de>
Subject: Help merging two repo without connection
Date: Sun, 16 Nov 2008 15:59:21 +0100
Message-ID: <AB681AEE-D229-4F1C-8D7B-8E60E0ED8E96@web.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 16:00:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1j7B-0000sN-EY
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 16:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYKPO7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 09:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbYKPO7Y
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 09:59:24 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:59252 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbYKPO7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 09:59:23 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 642A1F6C1CB0
	for <git@vger.kernel.org>; Sun, 16 Nov 2008 15:59:22 +0100 (CET)
Received: from [92.226.145.51] (helo=[192.168.2.252])
	by smtp08.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1L1j5u-0002BG-00
	for git@vger.kernel.org; Sun, 16 Nov 2008 15:59:22 +0100
X-Mailer: Apple Mail (2.929.2)
X-Sender: lsiciliano@web.de
X-Provags-ID: V01U2FsdGVkX187wG3dAKBy8vZPF8PyM3Cy6ar2JseyPg9apK41
	HJrRjtsvFTnjXLy9KldN0tD/N2fz6FevBLuSyftEY8Enpz6iKk
	vyDiZyjHo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101134>

Hi,
i'm trying to keep synched two repositories without always having a   
direct connection.
My situation is the following:
I have a project on my computer with GIT repo.
Another developer visited me and cloned my repository connecting the  
two computer (for example via  SSH).
Than i sent him for the next days patched of my changes but when he  
came and we merged i got the following tree:

                                                               /  
-------------------------------------------(my patch)--(my second  
patch)--\
                                                              /                                                                                                                      \
-- (first commit) -- (second  
commit 
)                                                                                                                        (merge 
) --
                                                               
\                                                                                                                      /
                                                               \ (my  
patch)--(my second patch)--------------------------------------------/


I don't thinks its right to have double (or more?) commits. I would  
have expected something like:


-- (first commit) -- (second commit)  -- (my patch)--(my second  
patch)  --  (merge?) --


The patches were created with git-format-patch and merged with git-am.
I know that the commits have different sha1 but how can i keep with  
patches or something similar the two repositories exactly synched?

Thanks

Luca Siciliano
