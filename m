From: Mircea Bardac <dev@mircea.bardac.net>
Subject: git blame for a commit
Date: Sun, 22 Jun 2008 23:32:05 +0100
Message-ID: <485ED2E5.3070906@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 00:33:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAY7P-0000j9-2f
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 00:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbYFVWcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 18:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755835AbYFVWcL
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 18:32:11 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:62455 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbYFVWcK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 18:32:10 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1142454ika.5
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 15:32:09 -0700 (PDT)
Received: by 10.210.102.16 with SMTP id z16mr5236536ebb.22.1214173928761;
        Sun, 22 Jun 2008 15:32:08 -0700 (PDT)
Received: from macmac.local ( [89.155.32.52])
        by mx.google.com with ESMTPS id m5sm6359901gve.3.2008.06.22.15.32.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Jun 2008 15:32:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85811>

Hi everyone,

Is there any straightforward way of doing git blame for all the files 
that got changed in a commit. Problems are renames, deletes and copies.

I was also thinking of git diff with a huge number of context lines, but 
this one feels a bit hacking. "git diff" is also missing author info, so 
"git blame" is a bit more desirable.

Has anyone ever done this before?

Many thanks.

-- 
Mircea
http://mircea.bardac.net
