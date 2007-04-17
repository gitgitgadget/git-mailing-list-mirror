From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 09:50:58 -0700
Message-ID: <86y7kr0wst.fsf@blue.stonehenge.com>
References: <4624CD58.90103@gmail.com>
	<C940520E-732A-4F6E-A7F2-0215FD534455@silverinsanity.com>
	<4624EAAA.6040000@gmail.com>
	<8c5c35580704170855ke426d86vac6e9b3b67fea5ea@mail.gmail.com>
	<4624F18F.6070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 18:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdqth-0002fv-M7
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 18:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031170AbXDQQvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 12:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031183AbXDQQvH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 12:51:07 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:10944 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031170AbXDQQu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 12:50:59 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id DB8901DE916; Tue, 17 Apr 2007 09:50:58 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.4.5; tzolkin = 9 Chicchan; haab = 13 Pop
In-Reply-To: <4624F18F.6070906@gmail.com> (Rene Herman's message of "Tue, 17 Apr 2007 18:10:55 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44795>

>>>>> "Rene" == Rene Herman <rene.herman@gmail.com> writes:

Rene> Well, yes, they do, and I could also do

Rene> git branch b v2.6.20
Rene> git branch c v2.6.20

Rene> directly then (right?) but I do want that "v20" branch in the middle.

What does "in the middle" mean here?

If I set:

   b = a;
   c = a;

That's the same as if I said:

   b = a;
   c = b;

Why do you think those would be different?  There's nothing recorded
when you say "git branch X Y" except to make a new X that's a copy
of the SHA1 of the old Y.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
