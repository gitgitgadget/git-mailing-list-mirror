From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH] git.c: make usage match manual page
Date: Mon, 11 Mar 2013 22:43:14 +0200
Message-ID: <513E41E2.3060700@bracey.fi>
References: <1363031055-13562-1-git-send-email-kevin@bracey.fi> <7vli9t909a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 21:43:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF9ZW-0003F0-Ro
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 21:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326Ab3CKUnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 16:43:22 -0400
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:54637 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754284Ab3CKUnT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 16:43:19 -0400
X-Greylist: delayed 6304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2013 16:43:19 EDT
Received: from mail420.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id EDC32FF8EE5
	for <git@vger.kernel.org>; Mon, 11 Mar 2013 21:59:56 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 11 Mar 2013 22:43:17 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 11 Mar 2013 22:43:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
In-Reply-To: <7vli9t909a.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 4747356959180951774
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.500002/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217907>

On 11/03/2013 21:58, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> Re-ordered option list in command-line usage to match the manual page.
>> Also makes it less than 80-characters wide.
> Thanks (s/Re-ordered/reorder/ and s/makes/make/, though).

Got it. But I'm going to reword it, to follow the history of the manual 
change.

> Is git.c the only one whose "-h" output does not match the manual
> synopsis?
>
Generally, "-h" just puts "<options>" in the synopsis, and then prints a 
line per option, so most commands don't really match the manual "show 
all options on one line" style anyway. git.c is atypical. (Something 
else to look at for the whole git help thing? Should "git -h" print a 
option list in that style?)

But, yes, I've found a few others that are show almost the same thing as 
the manual but with subtle pointless differences. "git remote", for 
example. That's a larger project, I feel; the 80-column thing is key here.

Kevin
