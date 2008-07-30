From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH v3] Advertise the ability to abort a commit
Date: Wed, 30 Jul 2008 17:16:55 -0400
Message-ID: <4D1D0F77-C2BE-4513-B664-80505957CB06@silverinsanity.com>
References: <20080730051059.GA4497@sigill.intra.peff.net> <1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk> <E2809CE9-1DEB-48DA-8E42-8BEAB376FED2@silverinsanity.com> <32541b130807301409t2f1f3a80n44c62447c628f03a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Anders Melchiorsen" <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	gitster@pobox.com, peff@peff.net
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 23:18:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOJ3y-0001SJ-NC
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 23:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbYG3VRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 17:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759311AbYG3VQ7
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 17:16:59 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35824 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759303AbYG3VQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 17:16:58 -0400
Received: from [192.168.1.109] (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 238011FFC02D;
	Wed, 30 Jul 2008 21:16:50 +0000 (UTC)
In-Reply-To: <32541b130807301409t2f1f3a80n44c62447c628f03a@mail.gmail.com>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90857>


On Jul 30, 2008, at 5:09 PM, Avery Pennarun wrote:

> On 7/30/08, Brian Gernhardt <benji@silverinsanity.com> wrote:
>> 'git commit' should return with an error any time it does not commit.
>> Otherwise scripts could get confused, thinking everything went fine  
>> when
>> nothing actually got done.  Here, the user decided something was in  
>> error
>> and canceled out, the same way using using ^C causes a non-zero  
>> return
>> status.
>
> The patch uses a non-zero exit code, which is an error status.  But as
> that's the case, I'm not sure why it's described in the changelog as
> treating it "not as an error."

Sorry, was reading through the list too quickly.  Of course an exit  
code of 1 is an error.  I'll go back to hiding under my rock now.

~~ Brian
