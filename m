From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: git-svn and renames
Date: Tue, 10 Jul 2007 16:01:48 +0200
Message-ID: <4693914C.3080701@dawes.za.net>
References: <46938594.2010607@dawes.za.net> <87odik74tx.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 16:02:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GIQ-0005yL-D1
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbXGJOC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 10:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbXGJOC0
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:02:26 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:54878 "EHLO
	spunkymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751502AbXGJOCZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2007 10:02:25 -0400
Received: from [192.168.201.103] (dsl-146-24-230.telkomadsl.co.za [165.146.24.230])
	by spunkymail-a11.g.dreamhost.com (Postfix) with ESMTP id 845BAB84DD;
	Tue, 10 Jul 2007 07:02:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <87odik74tx.fsf@mid.deneb.enyo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52072>

Florian Weimer wrote:
> * Rogan Dawes:
> 
>> $ git svn dcommit
>> RA layer request failed: PROPFIND request failed on '/svn/trunk/
>> webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java':
>> PROPFIND of '/svn/trunk/
>> webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java':
>> 400 Bad Request (https://webgoat.googlecode.com) at
>> /home/rdawes/bin/git-svn line 400
> 
> Does the "lessons" directory exist before that commit?

Yes. The file was in the lessons/ directory, and was moved to 
lessons/GoatHillsFinancial/. This new directory also existed prior to 
this commit.

Rogan
