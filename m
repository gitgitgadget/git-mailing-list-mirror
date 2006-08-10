From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: cvs2svn and git progress
Date: Wed, 9 Aug 2006 21:29:00 -0400
Message-ID: <9e4733910608091828l1744822cjf001b2722fea6c5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 10 03:29:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAzMI-0006S1-Ky
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 03:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbWHJB3I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 21:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbWHJB3I
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 21:29:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:26899 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030552AbWHJB3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 21:29:07 -0400
Received: by nf-out-0910.google.com with SMTP id a4so348316nfc
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 18:29:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=snsx1d9jajnHHTTtjl7zgCIg8oRXJS8ff4kq4LsudPHj+HYoSXWZ5M/b35ZNcFs0fPpQGgv4+KX+sWX40MIQG5BehBqsj4EH2C0l7WMIeqa8KUxrQeNJqAUs9FCZ17G2J8MmI22kODG2FjT7IAcU6t1+2nb0LY6ImBPxsq1gnP0=
Received: by 10.78.127.2 with SMTP id z2mr899695huc;
        Wed, 09 Aug 2006 18:29:00 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Wed, 9 Aug 2006 18:28:59 -0700 (PDT)
To: git <git@vger.kernel.org>, "Shawn Pearce" <spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25150>

I've finally got cvs2svn running through pass 7 now. It took me a
while to fix errors where it would run five hours and then die with
"key error 357" or something similar.

pass 1:  7663 seconds
pass 2:     1 second
pass 3:  1043 seconds
pass 4:     3 seconds
pass 5:   204 seconds
pass 6:  1165 seconds
pass 7:    37 seconds

Total is a little less than three hours. The new cvs2svn code is many
times faster than the old version which ran for several days. The
total includes the time needed to write the git pack and index file
for the revisions.

Pass 8 is where the final output is generated. Now that I have a
database I can only run pass 8 as needed to work on the back-end code.

I believe I have the sha1 from the git revisions correctly in the
final database but I need to write my first try at dumping the change
sets to be sure.

-- 
Jon Smirl
jonsmirl@gmail.com
