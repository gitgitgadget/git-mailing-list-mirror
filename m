From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git push (mis ?)behavior
Date: Fri, 28 Sep 2007 12:04:40 +0200
Message-ID: <B9F497FD-BD16-4D24-8F37-0D6989155FD3@zib.de>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <9D61974D-E08D-49F6-9C88-6BE446D53C74@zib.de> <20070928065823.GB19299@artemis.corp> <09A90525-8B0B-4249-904C-722BCC544B4E@zib.de> <7vr6kjp1jw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 12:05:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbCiS-0005nl-B6
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 12:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687AbXI1KEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 06:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755481AbXI1KEx
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 06:04:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:45452 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630AbXI1KEx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 06:04:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8SA34Y7019363;
	Fri, 28 Sep 2007 12:04:41 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8SA33dg020976
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 28 Sep 2007 12:03:03 +0200 (MEST)
In-Reply-To: <7vr6kjp1jw.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59385>


On Sep 28, 2007, at 11:44 AM, Junio C Hamano wrote:

>> Let me put it as a question: How can I push changes from the current
>> branch to all remote refs it is configured to push to via
>> "remote.<name>.push"
>> without pushing anything else at the same time?
>
> Sorry, but I do not get you.  Are you talking about pushing your
> 'frotz' into more than one branches 'nitfol' and 'xyzzy' at the
> same remote 'origin' without having to say
>
> 	$ git push origin frotz:nitfol frotz:xyzzy
>
> ???

Yes. Doesn't sound like a very reasonable workflow. But you can do
it with "remote.<name>.push". So I think "git push" should somehow
deal with it in a sensible way.

	Steffen
