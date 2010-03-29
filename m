From: "anand.arumug" <anand.arumug@gmail.com>
Subject: Unable to create .rev_map file
Date: Mon, 29 Mar 2010 08:06:29 -0800 (PST)
Message-ID: <1269878789902-4818963.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 18:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwHU4-0002O9-F1
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab0C2QGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:06:31 -0400
Received: from kuber.nabble.com ([216.139.236.158]:53042 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0C2QGa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:06:30 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <anand.arumug@gmail.com>)
	id 1NwHTx-00046h-TT
	for git@vger.kernel.org; Mon, 29 Mar 2010 09:06:29 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143489>


Hello all!

I am trying to clone a svn repo and I keep getting the following message:

Couldn't create
.git/svn/trunk/.rev_map.????????-????-????-????-????????????: No such file
or directory

Instead of cloning, I tried

git svn init <svn-repo-URL> -T trunk -t tags -b branches
   ===> This creates a .git folder successfully.

git svn fetch -rNNNNN
   ===> This does fetch the files but at the end the above quoted error
message comes up.

Not sure whats causing this problem. Any help is greatly appreciated.

Thanks,
Anand.

PS: My apologies if this is a repeat question. I did search the mailing list
using the error message I have quoted and couldn't find any previous post.

-- 
View this message in context: http://n2.nabble.com/Unable-to-create-rev-map-file-tp4818963p4818963.html
Sent from the git mailing list archive at Nabble.com.
