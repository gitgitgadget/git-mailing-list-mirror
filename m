From: Santi <sbejar@gmail.com>
Subject: [BUG] git-svn: svn URL is a path to a directory
Date: Wed, 5 Jul 2006 11:26:12 +0200
Message-ID: <8aa486160607050226s62385485l402b7d7d72d43ff2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 05 11:26:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy3eD-00049L-M6
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 11:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWGEJ0O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 05:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWGEJ0O
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 05:26:14 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:58671 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932409AbWGEJ0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 05:26:13 -0400
Received: by wx-out-0102.google.com with SMTP id t10so787018wxc
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 02:26:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J5d82MWaCc6c1v+r6hF6W8rPiC72GODQm3GW5rBmS+OQSXgmzuIiR/Jr0PtD/IwDfekN3VYco6Ko7pJtZuL2oeXUGuDJpy5gtWCisfnnt7PXqqAbie9yL6Vd4nPeIJcj8nANSML5O0anqFOfaTwSGd6d4vJgDuLok1MjkUAObzw=
Received: by 10.70.130.4 with SMTP id c4mr8705361wxd;
        Wed, 05 Jul 2006 02:26:12 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Wed, 5 Jul 2006 02:26:12 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23344>

Hi *,

    currently it is used as a prefix. So, if you have a repository as:

/path/to/repository/project/file
/path/to/repository/project-2/file

and execute:
git-svn init file:///path/to/repository/project
git-svn fetch

you end up with a project with the following files:

file
-2/file

    As a real example you could try:
git-svn init svn://svn.debian.org/svn/kernel/dists/trunk/linux-2.6/
git-svn fetch -r5040:5060

   See you

   Santi
-- 
Looking for signature...
Looking for signature...done
