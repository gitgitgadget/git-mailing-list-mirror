From: "Bryan Childs" <godeater@gmail.com>
Subject: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Mon, 4 Jun 2007 12:48:17 +0100
Message-ID: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 13:48:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvB2w-0001lx-JM
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 13:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbXFDLsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 07:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbXFDLsS
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 07:48:18 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:1246 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbXFDLsS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 07:48:18 -0400
Received: by py-out-1112.google.com with SMTP id a29so2249638pyi
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 04:48:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b7sLYbB42rIoozGi8L14AqmKPZBnPRgetK0a2qwBsWXqV45nK7wt9ktloRhuifxFM0aTMI+Ig47M5FtG0aftsBHAD0Rk8L50hX2y5zqhmO/4i0aFbhaotWttXIxPuYLJVKqxdQJVw+KX5zfY6EuY4/8GmyA4du1zNyIeu2BimJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=imyaPoEj5A7yRzajjj4m1QFqkJW744mXh52/YNCf9XHk8rEpqeGlWyH8V1wMeT0Luw7xR/mTOgtXDiKOqknt09rdVjUDD/BLmI6GZ0VTWeq5i03lmYpXze8xqcFikuAb4T/4k3Rx/BkGkGa3fpyZ59ECFTQWF4/1dCBw9fypM5g=
Received: by 10.64.213.3 with SMTP id l3mr594130qbg.1180957697135;
        Mon, 04 Jun 2007 04:48:17 -0700 (PDT)
Received: by 10.65.196.14 with HTTP; Mon, 4 Jun 2007 04:48:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49093>

Hello git users / maintainers / fans,

My fellow projecteers and I watched a presentation given by Linus
Torvalds on the advantages of git given at a google questions session
sometime recently.

Our project, www.rockbox.org, an open source firmware replacement
project for digital audio players currently makes use of subversion
for it's source code management system, but Linus's eloquent (though
sometimes rather blunt) speech has made us question whether git is
perhaps a better solution for us.

On the whole, we like a lot of the features it offers but, we have a
couple of issues which we've discussed, and so far have failed to come
up with a decent resolution for them.

1) Due to the nature of our project, with multiple architectures
supported, we strive to provide a binary build of our software with
every commit to the subversion repository. This is so that we can
provide a working firmware for the majority of our users that don't
have the necessary know-how for cross-compiling and so forth.

2) Unlike the Linux Kernel, which Linus uses as a prime example of
something git is very useful for, the Rockbox project has no central
figurehead for anyone to consider as owning the "master" repository
from which to build the "current" version of the Rockbox firmware for
any given target.

3) With a central repository, for which we have a limited number of
individuals having commit access, it's easy for us to automate a build
based on each commit the repository receives.

Given these three points, we wonder how we'd best achieve the same
using git. As far as we can make out we'd need to appoint someone as a
maintainer for a master repository whose job it is to co-ordinate
pulls from people based on when they've made changes we wish to
include in the latest version of our software. This sounds like a time
consuming role for a project which is only staffed by volunteers.

Can anyone offer any insights for us here?

Bryan
