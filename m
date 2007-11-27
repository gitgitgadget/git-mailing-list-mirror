From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Tue, 27 Nov 2007 13:23:50 -0800
Message-ID: <C1C5EF48-689A-4C6D-9EBB-01AFD252C0DF@midwinter.com>
References: <20071127211730.GA11861@midwinter.com> <fii1od$d38$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 22:24:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix7v3-0006bE-6H
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 22:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759485AbXK0VXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 16:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758996AbXK0VXw
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 16:23:52 -0500
Received: from tater.midwinter.com ([216.32.86.90]:39412 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758954AbXK0VXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 16:23:51 -0500
Received: (qmail 13038 invoked from network); 27 Nov 2007 21:23:50 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=d7FFq/rj+cydFl+L7CrDy0amzEr+OnQzZwvvtJoLmKFUvnghR9jZJ7qVD2lygAyJ  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 27 Nov 2007 21:23:50 -0000
In-Reply-To: <fii1od$d38$1@ger.gmane.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66263>

On Nov 27, 2007, at 1:21 PM, Jakub Narebski wrote:
>> +The hook may optionally choose to update the ref on its own, e.g.,
>> +if it needs to modify incoming revisions in some way. If it updates
>> +the ref, it should exit with a status of 100.
>
> Why 100, and not for example 127, 128 or -1?

Because those seemed much more likely to be used by existing hook  
scripts to denote an error condition, and I wanted to reduce the  
chance that this would break existing scripts.

-Steve
