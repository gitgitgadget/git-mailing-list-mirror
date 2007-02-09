From: "Marco Costalba" <mcostalba@gmail.com>
Subject: 'git status' is not read-only fs friendly
Date: Fri, 9 Feb 2007 20:25:04 +0100
Message-ID: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 20:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFbNF-0001dP-4D
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 20:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992773AbXBITZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 14:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992772AbXBITZI
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 14:25:08 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:55715 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992771AbXBITZG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 14:25:06 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1048496wri
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 11:25:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fVwENC7Dp+ew0RvBoKEZr3HeTxMGL2fsXO4zVxOnlrod3LOXKuqa7sFo0bPxtvziZMZ0HKouTOu8vA1UtUZqljE3d/IqmL9hGZUL6M8jnaOqeWp5w6QjKdseWekTUl77rmpiBV0SyG/KNk+RvoJLtWHXkN+ib6SYjbAlKCH+xbY=
Received: by 10.114.200.2 with SMTP id x2mr5231295waf.1171049104897;
        Fri, 09 Feb 2007 11:25:04 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Fri, 9 Feb 2007 11:25:04 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39191>

In a repository under a mounted Windows directory (ntfs) I get this error:

$ git status
fatal: unable to create '.git/index.lock': Read-only file system
$

Is this correct? there exist a workaround? I just need to know if
current working directory is clean and report back to qgit user, so
read-only access would be ok for me.

All other commands commonly used to browse a repository seems to work
well, without pretending to write stuff.

Thanks
Marco
