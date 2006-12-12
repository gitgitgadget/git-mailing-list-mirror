X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: index manipulation quickref
Date: Tue, 12 Dec 2006 17:57:17 +0700
Message-ID: <fcaeb9bf0612120257p35dc9483ob65eea9ae21b5f7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 10:57:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SEZ4lsF0mkmHEEc9hjhTRw54ZPoh2OQDrA3KPa0lJUKizbDI9Ozs76AKfbWqOzivgoPKV0Rc8yuugzT9eXnOYpz/Mm7qnCOAo2W2QLSci37/9D9wEqElLZOh8saIiEONvs/o27tuk9kvPpeLQ0PwKGdVd6NYBkXl4AHSlfw0CkI=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34078>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu5K6-0004tk-MK for gcvg-git@gmane.org; Tue, 12 Dec
 2006 11:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932188AbWLLK5T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 05:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWLLK5T
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 05:57:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:55413 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932188AbWLLK5S (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 05:57:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1625861uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 02:57:18 -0800 (PST)
Received: by 10.78.201.15 with SMTP id y15mr3927483huf.1165921037937; Tue, 12
 Dec 2006 02:57:17 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Tue, 12 Dec 2006 02:57:17 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I'm trying to collect all operations related to index from user
perspective and corresponding commands. The list may be put to git
wiki if people think it can help newbies:

update file content to index: git update-index file
add a file to index: git add file
delete a file from index: git update-index --remove --force-remove (or
remove that file in workdir and do git update-index --remove)
read a tree to index: git read-tree treeish, git reset treeish
read a file from a tree to index: git ls-tree treeish file|git
update-index --index-info --stdin
copy a file from index to workdir: git checkout-index file
refresh index: git update-index --refresh
copy entire index to workdir: git checkout-index
output a file from index to stdout: ?? (is there a command for this?)
list files in index: git ls-files
compare index and workdir file listing: git ls-files (with lots of options here)
diff between workdir and index: git diff
diff between index and a tree: git diff --cached treeish

Am I missing any operation here?
-- 
