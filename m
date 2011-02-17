From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Commit/merge messages for binary files
Date: Thu, 17 Feb 2011 21:40:08 +0100
Message-ID: <AANLkTikXMi92iUd-1bEfs5WfawyHp4G7=Ynd+eaq_wsR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 21:42:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqAgO-0002Tb-If
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 21:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757991Ab1BQUmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 15:42:12 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44723 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285Ab1BQUlr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 15:41:47 -0500
Received: by vxb37 with SMTP id 37so1403804vxb.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 12:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=s/hMl425kCH0mmdJu5+uukqgv7CAvR/JQt8ACkpe6rY=;
        b=wLjtmtlps4n7nHYuZ7nUHvcDvCFMJx+TBt06cwT8i/WlWDRu4D5vBwEEezaUO+J9Ls
         xqT6A6sy4YfFnkdAYkM/9uRy7Mntd2n8pisztjHtTASJSughejr7Q9bODUIaGF8TMQb4
         5+snQgZNyS7jUBHQITaKQc7b1a8DEH+ByA9bU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=KRNw2dZjE5D7fdkGh/y1s3TUq5RRnaiBZgNLct7gpVfzzh10SZRYI4i0JcArwaHx+A
         /FA0GCMhtzJKo2Jfy0YYujE4Mqie9ZXk0YV+8FG11WPfdq55EEzmuvsqMhVlLivfyFo6
         UVrF4WB1NSeHDrDn6zSTsD4wcyz5P6yMVA5P8=
Received: by 10.52.165.164 with SMTP id yz4mr528189vdb.217.1297975208352; Thu,
 17 Feb 2011 12:40:08 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Thu, 17 Feb 2011 12:40:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167114>

Hi,

there's a different output when committing change and when merging
change for a binary file.
Do the insertions/deletions have any meaning for binary files?

For example:

$ git commit -m Updated
[topic 5da30ce] Updated
 1 files changed, 8 insertions(+), 103 deletions(-)
 rewrite blob.o (100%)

$ git merge topic
Updating 75ab259..5da30ce
Fast-forward
 blob.o |  Bin 25920 -> 4364 bytes
 1 files changed, 0 insertions(+), 0 deletions(-)

-- 
Piotrek
