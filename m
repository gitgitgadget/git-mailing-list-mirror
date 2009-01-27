From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC v1 5/6] combine-diff.c: remove a call to fstat()	inside
 show_patch_diff()
Date: Tue, 27 Jan 2009 13:03:49 +0100
Organization: private
Message-ID: <86myddj6qi.fsf@broadpark.no>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
 <1233004637-15112-6-git-send-email-barvik@broadpark.no>
 <e2b179460901270135j6e4cb887radbe664ac98f39f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 13:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRmh4-0002wL-2T
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 13:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbZA0MEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 07:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbZA0MEA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 07:04:00 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:38434 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbZA0MEA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 07:04:00 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE400DE3PIFQGE0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 27 Jan 2009 13:03:51 +0100 (CET)
Received: from localhost ([80.203.78.10]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE40039APIEBC80@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 27 Jan 2009 13:03:51 +0100 (CET)
In-reply-to: <e2b179460901270135j6e4cb887radbe664ac98f39f1@mail.gmail.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107335>

Mike Ralphson <mike.ralphson@gmail.com> writes:

> 2009/1/26 Kjetil Barvik <barvik@broadpark.no>:
>> Currently inside show_patch_diff() we have and fstat() call after an
>> ok lstat() call.  Since we before the call to fstat() have already
>> test for the link case with S_ISLNK() the fstat() can be removed.
>
> s/have and/have an/ ?

  Correct! Will fix.  Thanks!

  -- kjetil
