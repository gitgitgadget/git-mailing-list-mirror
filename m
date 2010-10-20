From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git rebase and merge commits
Date: Wed, 20 Oct 2010 11:44:52 -0600
Message-ID: <4CBF2A94.1030206@workspacewhiz.com>
References: <AANLkTikroNPehcyBsueCnJ5hR0idd3cBP4m1KNccdRqL@mail.gmail.com> <20101020173201.GA10537@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dominique Quatravaux <domq@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 19:45:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8cil-0003FR-0z
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 19:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab0JTRo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 13:44:58 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:48959 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab0JTRo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 13:44:57 -0400
Received: (qmail 5957 invoked by uid 399); 20 Oct 2010 11:44:53 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.162.52)
  by hsmail.qwknetllc.com with ESMTPAM; 20 Oct 2010 11:44:53 -0600
X-Originating-IP: 75.220.162.52
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.11) Gecko/20101013 Lightning/1.0b3pre Thunderbird/3.1.5
In-Reply-To: <20101020173201.GA10537@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159420>

----- Original Message -----
From: Jonathan Nieder
Date: 10/20/2010 11:32 AM
> I'm sorry to break this news, but "rebase --interactive --preserve-merges"
> (unlike "rebase --preserve-merges" without --interactive) was never
> implemented completely.  See the BUGS section of the git-rebase man page.
>
> Luckily, there is a roadmap for anyone interested in implementing it.  Maybe
> it could be you?  See [1] and the surrounding thread.
>
> Thanks for your interest,
> Jonathan
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/148059/focus=148144
I applied that patch to my git-rebase--interactive, although it did not 
cleanly apply.  I hacked a few bits to get it going again.  I could post 
the entire file here, if someone wants to clean it up.

It does properly rebase the first-parent merges fine.

Josh
