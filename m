From: Honza Horak <hhorak@redhat.com>
Subject: Announcing release for Git 1.9 on CentOS Linux 6 and 7 x86_64 SCL
Date: Wed, 23 Dec 2015 15:17:10 +0100
Message-ID: <567AACE6.7040002@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 15:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBkE9-0003hn-8G
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 15:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbbLWORM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 09:17:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53741 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbbLWORL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 09:17:11 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 845BD8E23B
	for <git@vger.kernel.org>; Wed, 23 Dec 2015 14:17:11 +0000 (UTC)
Received: from hhorak-t440.usersys.redhat.com (vpn1-4-113.ams2.redhat.com [10.36.4.113])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tBNEHARC025880
	for <git@vger.kernel.org>; Wed, 23 Dec 2015 09:17:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282947>

I am pleased to announce the immediate availability of Git 1.9 on CentOS 
Linux 6 and 7 x86_64, delivered via a Software Collection (SCL) built by 
the SCLo Special Interest Group 
(https://wiki.centos.org/SpecialInterestGroup/SCLo).

QuickStart
----------
You can get started in three easy steps:
   $ sudo yum install centos-release-scl
   $ sudo yum install git19
   $ scl enable git19 bash

At this point you should be able to use git just as a normal 
application. Examples of commands run might be:
   $ git clone https://github.com/openshift/mysql.git
   $ git commit -m "Initial commit"

In order to view the individual components included in this collection, 
including additional conversion tools, you can run:
   $ sudo yum list git19\*

About Software Collections
--------------------------
Software Collections give you the power to build, install, and use 
multiple versions of software on the same system, without affecting 
system-wide installed packages. Each collection is delivered as a group 
of RPMs, with the grouping being done using the name of the collection 
as a prefix of all packages that are part of the software collection.

The collection git19 delivers version 1.9 of the git, fast, scalable and 
distributed revision control system, plus additional conversion tools 
and plugins also available as RPMs.

For more on the Git, see https://git-scm.com.

The SCLo SIG in CentOS
----------------------
The Software Collections SIG group is an open community group 
co-ordinating the development of the SCL technology, and helping curate 
a reference set of collections. In addition to the Git collection being 
released here, we also build and deliver databases, web servers, and 
language stacks including multiple versions of PostgreSQL, MariaDB, 
Apache HTTP Server, NodeJS, Ruby, Python and others.

Software Collections SIG release was announced at 
https://lists.centos.org/pipermail/centos-announce/2015-October/021446.html

You can learn more about Software Collections concepts at: 
http://softwarecollections.org
You can find information on the SIG at 
https://wiki.centos.org/SpecialInterestGroup/SCLo ; this includes howto 
get involved and help with the effort.

We meet every second Wednesday at 16:00 UTC in #centos-devel (ref: 
https://www.centos.org/community/calendar), for an informal open forum 
open to anyone who might have comments, concerns or wants to get started 
with SCL's in CentOS.

Enjoy!

Honza
SCLo SIG member
