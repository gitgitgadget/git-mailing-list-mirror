From: Jay Cheah <jay.cheah@astc-design.com>
Subject: Bug in Git Gui create branch
Date: Mon, 23 Jun 2014 16:41:53 +0930
Message-ID: <53A7D339.3030806@astc-design.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040203070308050105090909"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 09:30:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wyyhw-0004jN-53
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 09:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbaFWHaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 03:30:24 -0400
Received: from au2.astc-design.com ([203.122.250.137]:51322 "EHLO
	au2.astc-design.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbaFWHaX (ORCPT <rfc822;git@vger.kernel.org.>);
	Mon, 23 Jun 2014 03:30:23 -0400
X-Greylist: delayed 1108 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jun 2014 03:30:23 EDT
Received: from [192.168.126.56] (unknown [192.168.96.207])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by au2.astc-design.com (Postfix) with ESMTP id 18C0820044
	for <git@vger.kernel.org.>; Mon, 23 Jun 2014 16:41:54 +0930 (CST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252325>

This is a multi-part message in MIME format.
--------------040203070308050105090909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Not sure what are the prerequisites for creating this bug, but it just 
suddenly happened to me that I cannot create branches.

bad window path name ".__branch_create____o1____d.desc.name_t"
bad window path name ".__branch_create____o1____d.desc.name_t"
     while executing
"focus $old_focus"
     (procedure "choose_rev::_sb_set" line 10)
     invoked from within
"choose_rev::_sb_set ::choose_rev::__o1::__d 
.__branch_create____o1____d.rev.list.sby v 0.0 1.0"
     (vertical scrolling command executed by listbox)

I pasted the error log here as well as attach the file.

Regards,
Jay

--------------040203070308050105090909
Content-Type: text/plain; charset=windows-1252;
 name="gitgui_createbrancherror.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gitgui_createbrancherror.log"

bad window path name ".__branch_create____o1____d.desc.name_t"
bad window path name ".__branch_create____o1____d.desc.name_t"
    while executing
"focus $old_focus"
    (procedure "choose_rev::_sb_set" line 10)
    invoked from within
"choose_rev::_sb_set ::choose_rev::__o1::__d .__branch_create____o1____d.rev.list.sby v 0.0 1.0"
    (vertical scrolling command executed by listbox)
--------------040203070308050105090909--
