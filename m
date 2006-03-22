From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git
Date: 21 Mar 2006 21:35:52 -0800
Message-ID: <867j6nm47b.fsf@blue.stonehenge.com>
References: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
	<86y7z3mdcz.fsf@blue.stonehenge.com>
	<86hd5rma75.fsf@blue.stonehenge.com>
	<7vacbjawyu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 06:36:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLw0s-0001oi-Rf
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 06:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWCVFf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 00:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWCVFf6
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 00:35:58 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:52600 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750776AbWCVFf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 00:35:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id E64758D62C;
	Tue, 21 Mar 2006 21:35:52 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 25937-01-13; Tue, 21 Mar 2006 21:35:52 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 7271B8F3EA; Tue, 21 Mar 2006 21:35:52 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.2.13; tzolkin = 7 Ben; haab = 11 Cumku
In-Reply-To: <7vacbjawyu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17805>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

>> But this wastes a commit.  Is there any way to get an index that simply
>> includes the file from that other branch?

Junio>         $ git checkout master
Junio>         $ git checkout next git-cvsimport.perl

Yow.  How simple is *that*?  Thanks.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
