From: Steve French <smfrench@austin.rr.com>
Subject: sending changesets from the middle of a git tree
Date: Sat, 13 Aug 2005 22:35:50 -0500
Message-ID: <42FEBC16.9050309@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 14 05:36:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E49Ik-0005zw-Fb
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 05:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVHNDfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 23:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbVHNDfb
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 23:35:31 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:60404 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932426AbVHNDfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 23:35:31 -0400
Received: from [192.168.0.2] (cpe-70-112-171-162.austin.res.rr.com [70.112.171.162])
	by ms-smtp-05-eri0.texas.rr.com (8.12.10/8.12.7) with ESMTP id j7E3ZRB2000052
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 22:35:29 -0500 (CDT)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Just to confirm a recent answer to questions on lkml ...

1) There is no way to send a particular changeset from the "middle" of a 
set from one tree to another, without exporting it as a patch or 
rebuilding a new git tree.   I have two changesets that, after testing 
last week, I now consider more important to send upstream than the few 
earlier and later changesets.   If I export those two changesets as 
patches, and send them on. presumably I lose the changset comments etc. 
and then when the upstream tree is merged back, it might look a little 
odd in the changeset history.

2) There is no way to update the comment field of a changeset after it 
goes in (e.g. to add a bugzilla bug number for a bug that was opened 
just after the fix went in).

3) There is no way to do a test commit of an individual changeset 
against a specified tree (to make sure it would still merge cleanly, 
automatically).

Are there easier ways to do any of these?
