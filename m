From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Quickly searching for a note
Date: Fri, 21 Sep 2012 14:25:14 -0600
Message-ID: <505CCD2A.8020003@workspacewhiz.com>
References: <505C7C80.3000700@workspacewhiz.com> <7vy5k370n7.fsf@alter.siamese.dyndns.org> <505CB21E.4040607@workspacewhiz.com> <7vtxur3zxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:25:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF9n2-0003PI-4a
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 22:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757817Ab2IUUZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 16:25:22 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:44085 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122Ab2IUUZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 16:25:21 -0400
Received: (qmail 12356 invoked by uid 399); 21 Sep 2012 14:24:47 -0600
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@204.238.46.101)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Sep 2012 14:24:47 -0600
X-Originating-IP: 204.238.46.101
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vtxur3zxi.fsf@alter.siamese.dyndns.org>
X-Antivirus: avast! (VPS 120921-0, 09/21/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206159>

----- Original Message -----
From: Junio C Hamano
Date: 9/21/2012 2:04 PM
> Joshua Jensen <jjensen@workspacewhiz.com> writes:
>
>>> Is there any particular reason you do that as two separate steps?
>>> It would feel more natural, at least to me, to do something along
>>> the lines of
>>>
>>> 	git log --show-notes=p4notes -1000
>>>
>>>
>> Thanks for the reply.
>>
>> I did not make clear above that I want to stop looking when I find the
>> first commit that has the note.
>>
>> In the case of 'git log --show-notes=p4notes -1000', Git will process
>> and hand me the log output for 1,000 commits.  It is rare I need to
>> walk that deep.
> I simply matched it with your initial "rev-list --max-count=1000".
> The "log" command pages and you can hit 'q' once you saw enough (in
> other words, you do not have to say -1000).
>
This is run via script without user intervention.  Presumably, Git will 
do 1,000 commits of work when it may only need to do 1 or 5 or 10?

-Josh
