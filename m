From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: ISO 13485
Date: Tue, 17 Jun 2014 11:30:17 -0400
Organization: PD Inc
Message-ID: <0368137BF4DA4E798A17D74DAFE30FEF@black>
References: <539F09B9.3050200@omixon.com> <9738CF1519014998B579C405EB4FA22B@black> <53A05766.7060502@omixon.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'agi'" <agnes.pasztor@omixon.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 17 17:31:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwvLf-0006Vq-5n
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933491AbaFQPay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:30:54 -0400
Received: from mail.pdinc.us ([67.90.184.27]:47335 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933344AbaFQPaT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:30:19 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5HFUHFx014099;
	Tue, 17 Jun 2014 11:30:17 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <53A05766.7060502@omixon.com>
Thread-Index: Ac+KPIiD9cY3JAoiSsCxTO+TwCH9LgAArLxw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251865>

> -----Original Message-----
> From: agi
> Sent: Tuesday, June 17, 2014 10:58
> 
> Hi Jason,
> 
> Thanks for the speedy reply. We are in the process of trying 
> to make our 
> software product ISO13485 compatible and we are assessing all systems 
> that we use.
> Do you have a validation document for git that could provide 
> information 
> on how to use it in order to comply with ISO legislations?

That would be customized to your QA process. A generalized document would be too
vague. I am sure any process consultant could draft that up for you.
(disclaimer: I have been paid to do things like this before)

Maybe you could start by searching with things like
https://www.google.com/search?q=using+QA+with+Git or contacting Atlassian about
their QA product suite integration with Git.

Maybe you could find a process consultant to do it cheaper if you release it out
to the FOSS community?

The "nice" (read as less effort) thing about ISO 13485 is it does not have a
continual improvement requirement so as long as "defects" are detected and
remediated you are good. Please note git does not detect defects, git does not
remediate defects. What git does is ensure the approved artifact is unchanged in
any attribute to maintain the exact level of quality from first inspection of
that artifact for an unlimited amount of iterations. Git has built in "digital
signatures" on the artifacts stored in its repository.

> Any additional information or material you can think of is more than 
> welcome.
> 
> Thanks in advance for your help!
> 
> 
> Best Regards,
> Agnes Pasztor
> 
> Senior Test Engineer
> Omixon Biocomputing Ltd.
> 
> 
> On 06/16/2014 05:20 PM, Jason Pyeron wrote:
> >> -----Original Message-----
> >> From: agi
> >> Sent: Monday, June 16, 2014 11:14
> >>
> >> Hello,
> >>
> >> I would like to ask a question about GIT v. 1.7
> >>
> >> Is it compatible with ISO 13485 (quality management system)?
> >> Can it be
> >> used for developing a medical diagnostic software?
> > Yes.
> >
> > Now, do you have a specific question about how to use Git 
> in your QA process?

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
