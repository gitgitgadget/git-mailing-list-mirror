From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Merging a branch when I don't want conflicts
Date: Mon, 18 May 2009 12:00:46 +0930
Message-ID: <93c3eada0905171930m36765d4fued9c2efdc57e51a4@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 04:30:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5scy-0001c1-1h
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 04:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbZERCaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 22:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbZERCaq
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 22:30:46 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:43479 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbZERCap (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 22:30:45 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2344001qwd.37
        for <git@vger.kernel.org>; Sun, 17 May 2009 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=PbWnD6NNp4n+FDSe+tflegDPQiXh/RfhOjemw/b/M0Y=;
        b=eoETdnDu5sPOqPuHmWindzLlxIV+uT0tVgRd9+JXAnXZmAJ9Lo0Y2yb3v+XNq1Dyb6
         erhHY8xfuIV8milUNfMjIrtQXwGmuCmbSSI4LAUsTX1yIM8Ke/DJa9UrL0DAn4zKbW3T
         4qqjpgLGsz2B6Z79jZ91Jg0Zv/V4QHsbHu0U4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=L0vlRfZzGq+sDzIXt2DmqBixl147TuhndgZoFqfuJLp+HgpXuoS7p6QfL9oTyx53Wk
         leFY+OvLSvZWjK2ZSlOaeCqreEaLu0CyvNy9mBHRyVOuWmXVF7l70J1qWWNNGRrvG2Wh
         FKHfvbofJ2X7FXYcU84CgGwOkOzwNio6hPq9g=
Received: by 10.220.100.5 with SMTP id w5mr5940956vcn.62.1242613846152; Sun, 
	17 May 2009 19:30:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119411>

How do I merge a branch X into my master and tell git that whenever there
is a conflict, the file on X should prevail?  This is for a scripted
application.

Cheers,
Geoff
