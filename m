From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: cg-clone http://www.kernel.org/pub/scm/git/git.git fails
Date: Tue, 09 Aug 2005 18:06:10 +0200
Message-ID: <42F8D472.3080404@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 09 18:06:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2WcE-0001tQ-68
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 18:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVHIQGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 12:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVHIQGG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 12:06:06 -0400
Received: from smtp-v.fe.bosch.de ([139.15.237.2]:43446 "EHLO
	smtp-v.fe.bosch.de") by vger.kernel.org with ESMTP id S964842AbVHIQGF
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 12:06:05 -0400
Received: from mta3.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta5.fe.bosch.de (Postfix) with ESMTP id BECF33C007
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 18:06:03 +0200 (CEST)
Received: from si-imc02.de.bosch.com (virusscan7.fe.internet.bosch.com [10.4.98.12])
	by mta3.fe.internet.bosch.com (Postfix) with ESMTP id 87DD58C022
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 18:06:03 +0200 (CEST)
Received: from hi-mail02.de.bosch.com ([10.34.16.71]) by si-imc02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 9 Aug 2005 18:06:03 +0200
Received: from [10.4.106.20] ([10.4.106.20]) by hi-mail02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 9 Aug 2005 18:06:02 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-OriginalArrivalTime: 09 Aug 2005 16:06:02.0711 (UTC) FILETIME=[3D7B4E70:01C59CFC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

with

cogito-0.13.tar.bz2
git-2005-08-09.tar.gz

clone of cogito over http

 > cg-clone http://www.kernel.org/pub/scm/cogito/cogito.git

works fine. But clone of git itself fails:

> cg-clone http://www.kernel.org/pub/scm/git/git.git 
defaulting to local storage area
warning: templates not found /home/user/share/git-core/templates/
16:29:03 URL:http://www.kernel.org/pub/scm/git/git.git/refs/heads/master
[41/41] -> "refs/heads/origin" [1]
progress: 3 objects, 5158 bytes
Getting pack list
error: Unable to get pack index
http://www.kernel.org/pub/scm/git/git.git//objects/info/packs
error: Tried
http://www.kernel.org/pub/scm/git/git.git/objects/6f/f87c4664981e4397625791c8ea3bbb5f2279a3
Cannot obtain needed blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3
while processing commit adee7bdf504120055b0f36b4918bdd3e6156912b.
cg-pull: objects pull failed
cg-clone: pull failed

Is this a tool or repository issue?

Many thanks

Dirk
