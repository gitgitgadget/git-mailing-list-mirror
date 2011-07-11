From: Carlo Trimarchi <mr.spoon21@gmail.com>
Subject: repository in different directories
Date: Mon, 11 Jul 2011 14:44:02 +0200
Message-ID: <CABU6SG5uLXAsu0yXa1cmPAmte3WnsjaHN0r_D4c8C7W2tKJDHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 14:44:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgFqd-0007Us-W1
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 14:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab1GKMoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 08:44:23 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46010 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab1GKMoW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 08:44:22 -0400
Received: by gxk21 with SMTP id 21so1448048gxk.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=bK2iq2rH4a9uCKLY1y+qSxecg1o1oHmBKNLXwNZQwgI=;
        b=s7HGoYtLX0/WKCHQzoJCkb2NS4FVHnG7E1WsiEd21B4qj+ESQnlc7CFWe3HXqGCELD
         LbCxHo/amn1AqZZ8f4YhP+x5WQIn8KOlhbTHwy879t3IXR+1V8fl7kXycW58UG8TilFT
         P0JSsSCebCHi7DhxP/oaixhlWI3tbEqVMRyKk=
Received: by 10.236.152.102 with SMTP id c66mr5570061yhk.340.1310388262165;
 Mon, 11 Jul 2011 05:44:22 -0700 (PDT)
Received: by 10.236.110.135 with HTTP; Mon, 11 Jul 2011 05:44:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176839>

Hi,
I'm using git to build a website using the Codeigniter php framework.
I work on my local machine and then push to a remote server. The whole
website would be divided in different directories. I have the webroot
in /home/carlo/public_html/ directory. Here I have an index.php, the
css files and images. Then, outside this directory, I have the
application folder with all the real php stuff. Suppose it is in
/home/carlo/ci/application.

I have the same configuration on the server. So, the workflow would be
that I work on my local machine, I change something in the application
folder, then something in some css file and then I have to sync
everything with the server. I can have two repositories, one for the
folder in the webroot and another one for the application folder, but
then I'd have to push twice. Is there a better or a good way to do all
this?

Thanks,
Carlo
