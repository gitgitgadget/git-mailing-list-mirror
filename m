From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: [RFD] How to better document the "two and three dots" format
Date: Mon, 1 Sep 2008 14:43:51 +0200
Message-ID: <4d8e3fd30809010543o1e1562c1s4466e191e782ddcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 14:45:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka8mK-0000bK-O7
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 14:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbYIAMnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 08:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbYIAMnw
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 08:43:52 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:2674 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623AbYIAMnv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 08:43:51 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1859621wfd.4
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=MIOBz7QqZa2i2nw1KVuNJugsIVbcVcyr65dEEAvQlag=;
        b=M+KNxJhCdnE/Ns8LDAAyqhAuRJk4jB7lwOEdIZrIiZPi55d8FXN9kzsrH/SNLHrQBA
         Zxdcbx5gbgcO+kgySK2aCt54zTYFqBFIX3uH/c8gv1V9qVcotr043Zx5C8obKzhfWCyJ
         JrmXuv5zkOS4ik78OA9cEF5XTzXvEW8uibTFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=hAoScK5dbHcCDZK6CR9AmJQMBbgb4bbwF0j6CMX8f0aBf4IzTbB5fNRWjirexZtVfV
         Gj5HhFyHmOB+osHyuPdndQuTeE1qx7Fz6dN9VVHVgL6514DZ+PCUdFFNcOB7FqU7Piyl
         f6J1sYln1mjHCRy1azLj1mykyaU+lczyTWZuc=
Received: by 10.142.188.4 with SMTP id l4mr2097691wff.92.1220273031160;
        Mon, 01 Sep 2008 05:43:51 -0700 (PDT)
Received: by 10.142.177.15 with HTTP; Mon, 1 Sep 2008 05:43:51 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94578>

Hi all,
I'm looking in the existing documentation about some example and
clarification about
the two and three dots formats applied to git diff.

The git-diff.txt file includes the following:

---8<---
Comparing branches::
+
------------
$ git diff topic master    <1>
$ git diff topic..master   <2>
$ git diff topic...master  <3>
------------
+
<1> Changes between the tips of the topic and the master branches.
<2> Same as above.
<3> Changes that occurred on the master branch since when the topic
branch was started off it.
---8<---

I think <3> should be changed in something like:
<3> Changes between the tips of the topic and the master branch that
occurred since when the topic
branch was started off it.

What do you think?

I would like to add some graphical representation of <2> and <3> but
I'm a bit loss
with <3> (and I guess lot of newbies are not really understanding that point).
Can anybody come up with some ASCII art?

Thanks.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
