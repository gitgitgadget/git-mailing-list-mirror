From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Repeatable test t9010-svn-fe.sh failure w/ master (685e9d9, 1.7.4.rc1)
Date: Thu, 06 Jan 2011 11:04:40 -0500
Message-ID: <4D25E818.5050909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 17:04:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PasKe-000525-JM
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 17:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab1AFQEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 11:04:48 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62046 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab1AFQEr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 11:04:47 -0500
Received: by qwa26 with SMTP id 26so16877615qwa.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 08:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:content-type:content-transfer-encoding;
        bh=u9npC/HGF6gmvNZwKDe9ShOhviHnNLtYHkRyTdQDyFE=;
        b=oCul9xOr3U4yLbXPzxOdDNu4JMYYNasm6ai6ZdmcAaDsESb8vS677mzuftyjc3kugt
         1oDS5xDUMb5xQnIhuwUr8mS8LoDXOik1jt2i/9nrPAqubib9vsWHjQS/5X2EaSBLhblG
         SEq103FN23bLCWtC+hRsmATG2W2LEu8f5OAa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:user-agent
         :mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=S6WJq7eDRspkuG3cwBOO2yp4BAs12ussCJAqPHpLtIQAPpKCtXUq5dNKJ/gHrWZxaT
         HNafuyyuA3tlYed0uQvGf5UInTshGjHg7ZZt7ocQ30zXDEmndOA3WCEie+LeKOMZqtGG
         PraKAOQWnR0gSp5Qt4DktQ/IwUc4bnWQi0jzY=
Received: by 10.224.2.133 with SMTP id 5mr13218744qaj.68.1294329887018;
        Thu, 06 Jan 2011 08:04:47 -0800 (PST)
Received: from [10.0.1.130] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id p13sm14456522qcu.41.2011.01.06.08.04.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 08:04:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164637>

System:
	Linux debian 2.6.32-5-amd64 #1 SMP Fri Dec 10 15:35:08 UTC 2010 x86_64 
GNU/Linux
	All installed packages up-to-date as of 2011-01-06 15:55 UTC

Git:
	Latest master (685e9d9)
	$ ./git --version
	git version 1.7.4.rc1

Svn:
	libsvn-perl	1.6.12dfsg-3
	libsvn1		1.6.12dfsg-3
	subversion	1.6.12dfsg-3

Invocation:
	(make NO_OPENSSL=1 'gitexecdir=$(bindir)' all test strip)



*** t9010-svn-fe.sh ***
ok 1 - empty dump
ok 2 - v3 dumps not supported
not ok - 3 t9135/svn.dump
#
#               svnadmin create simple-svn &&
#               svnadmin load simple-svn 
<"$TEST_DIRECTORY/t9135/svn.dump" &&
#               svn_cmd export "file://$PWD/simple-svn" simple-svnco &&
#               git init simple-git &&
#               test-svn-fe "$TEST_DIRECTORY/t9135/svn.dump" >simple.fe &&
#               (
#                       cd simple-git &&
#                       git fast-import <../simple.fe
#               ) &&
#               (
#                       cd simple-svnco &&
#                       git init &&
#                       git add . &&
#                       git fetch ../simple-git master &&
#                       git diff --exit-code FETCH_HEAD
#               )
#
# failed 1 among 3 test(s)
1..3
