From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Calculating tree nodes
Date: Mon, 3 Sep 2007 22:13:26 -0400
Message-ID: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 04:13:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISNv4-0001Vs-Jw
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 04:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbXIDCN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 22:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbXIDCN1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 22:13:27 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:34624 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbXIDCN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 22:13:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2063567wah
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 19:13:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=V7REVSSBPyBQs6rETm7HI2/q1ULBr7gLcT74wx03yF8c4gB8ewPQw8GoZps1FZv6rFHDMGztrLlQEsG/o5axiUcwMMQ/XnZv6Nt3TAWkPzUzc1fiIjh99dEFthZf+PTZr7th+AJuaftrlK/vGweJqFEHRnynlbyl1eGmhP5uMhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hRlmbn6C78LhxhtcDMIaFDTIThe2xl0MhL4ett1tPu61n0ygVdS+uDgDZ5/SJE6ESZfQn3n1tOJJgF2p7V8ClMnbDmZzppu6JGKTTPGPNkZ87FXyd925e0KmwRSknPEYaLhAkfhg3uzKijNv8kP3W62vNWkln7K91oP7Vd4f3is=
Received: by 10.114.137.2 with SMTP id k2mr103893wad.1188872006194;
        Mon, 03 Sep 2007 19:13:26 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Mon, 3 Sep 2007 19:13:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57511>

When I change a file it creates a new object with a new SHA. This new
SHA causes the tree node pointing to it to change. Changing the tree
node forces its parent to change and so on. Of course git batches all
of the changes together into a commit so that this ripple effect
doesn't happen for every file. But every commit causes a new root tree
node to be created, right?

-- 
Jon Smirl
jonsmirl@gmail.com
