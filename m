From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Creating objects manually and repack
Date: Thu, 3 Aug 2006 23:43:42 -0400
Message-ID: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 04 05:43:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8qbL-0007gU-Vf
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 05:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWHDDno (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 23:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWHDDno
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 23:43:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:32885 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030209AbWHDDno (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 23:43:44 -0400
Received: by nf-out-0910.google.com with SMTP id l23so1560207nfc
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 20:43:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AoijyV/hkXZl8MdYbE33GvJHI7Ji8zQo/8AEF572ZVj1g19OIUxTR/R9H3ZMb8Z3tIDjDfpLw3q+osEW79aYRHo2zX/lIZNgvXNhe5dKs2tf5V+fMa+EP2fkZDuqQMdSLIMKyWi5W5xXL0oUNnt+h5pBNHI8ngL1wuvmkmncHAc=
Received: by 10.78.117.10 with SMTP id p10mr1401865huc;
        Thu, 03 Aug 2006 20:43:42 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Thu, 3 Aug 2006 20:43:42 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24767>

I've made 500K object files with my cvs2svn front end. This is 500K of
revision files and no tree files. Now I run get-repack. It says done
counting zero objects. What needs to be update so that repack will
find all of my objects?

git-fsck isn't happy either since I have no HEAD.

-- 
Jon Smirl
jonsmirl@gmail.com
