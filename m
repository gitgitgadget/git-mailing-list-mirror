From: Belmar-Letelier <luis@itaapy.com>
Subject: cg-mkpatch use case
Date: Tue, 02 May 2006 09:47:26 +0200
Message-ID: <44570E8E.5070402@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 02 09:47:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FapbZ-0001fp-F8
	for gcvg-git@gmane.org; Tue, 02 May 2006 09:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWEBHrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 03:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWEBHrZ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 03:47:25 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:52486 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932255AbWEBHrY
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 May 2006 03:47:24 -0400
Received: from [192.168.0.42] (itaapy-255-90.cnt.nerim.net [195.5.255.90])
	by mallaury.nerim.net (Postfix) with ESMTP id CB1564F3B8;
	Tue,  2 May 2006 09:47:17 +0200 (CEST)
User-Agent: Thunderbird 1.5 (X11/20060309)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19405>

Hello,

I have 3 questions about cg-mkpatch

1. I've receive a file "xxx.patch", this content came from
   cg-mkpatch, but I can't apply it.
   For example if I try git-am I get::

     $ git-am --signoff xxx.patch
     Patch does not have a valid e-mail address.

   What is the Cogito way to apply the result of "cg-mkpatch"


2. What are the difference between usecases with "cg-mkpatch"
   and "git-format-patch" ?


3. It seem that if a commit as a binary file they are no way to manage
   it by email patches. Any plan about this in Cogito ?


-- 
Luis
