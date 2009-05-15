From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git daemon request logging?
Date: Fri, 15 May 2009 14:58:30 -0700
Message-ID: <7vhbzmrptl.fsf@alter.siamese.dyndns.org>
References: <4A0DC4E0.7020001@garzik.org>
	<81b0412b0905151356t7bf613d5me39af08d37f72857@mail.gmail.com>
	<4A0DD81C.2000709@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri May 15 23:58:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M55QN-0002OQ-80
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 23:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbZEOV6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 17:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbZEOV6a
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 17:58:30 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:45030 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbZEOV6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 17:58:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090515215829.GFFB2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 15 May 2009 17:58:29 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id rxyW1b00E4aMwMQ03xyWW7; Fri, 15 May 2009 17:58:30 -0400
X-Authority-Analysis: v=1.0 c=1 a=LaD3qmlgg6wA:10 a=96cxnV4OAAAA:8
 a=VwQbUJbxAAAA:8 a=OVUJweh08fWuadTl2ukA:9 a=ngI6iOU6HfzHqf2oeeQZsGi7BHQA:4
 a=5DbmezEbq8cA:10
X-CM-Score: 0.00
In-Reply-To: <4A0DD81C.2000709@garzik.org> (Jeff Garzik's message of "Fri\, 15 May 2009 17\:01\:16 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119303>

Jeff Garzik <jeff@garzik.org> writes:

> Alex Riesen wrote:
>> 2009/5/15 Jeff Garzik <jeff@garzik.org>:
>>> Does the git daemon do any sort of request logging?  Could it?
>>>
>>> I was thinking it would be nice to see the amount of pulls/clones for each
>>> git.kernel.org repository.
>>
>> Does this count?
>>
>> May 15 22:54:47 tigra git[28923]: connect from 192.168.0.8 (192.168.0.8)
>> May 15 22:54:47 tigra git-daemon[28924]: Connection from 192.168.0.8:40845
>> May 15 22:54:47 tigra git-daemon[28924]: Extended attributes (11
>> bytes) exist <host=gate>
>> May 15 22:54:47 tigra git-daemon[28924]: Request upload-pack for '~raa/src/git'
>>
>> fetch(pull)/clone are the same for daemon.
>
> Honestly I was hoping for something more along the lines of httpd
> one-line request logging, as the above is a lot of data to log +
> parse.

I think there was a proposed patch to change the log format to one-line;
it was unfortunately an unilateral "we give no option to produce the old
style logs, screw people's existing log analysis scripts" patch, and I do
not think I applied it.
