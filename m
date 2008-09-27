From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH RFC 4/6] Docs: send-email: Option order the same in man page and usage text
Date: Fri, 26 Sep 2008 20:13:44 -0500
Message-ID: <D779B9F2-9CDF-4301-89D9-2F63A5B7BBA0@mit.edu>
References: <1222099095-50360-1-git-send-email-mfwitten@mit.edu> <1222375476-32911-1-git-send-email-mfwitten@mit.edu> <1222375476-32911-2-git-send-email-mfwitten@mit.edu> <1222375476-32911-3-git-send-email-mfwitten@mit.edu> <1222375476-32911-4-git-send-email-mfwitten@mit.edu> <20080926224032.GA24817@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 27 03:18:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjOSJ-0007o6-8B
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 03:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbYI0BOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 21:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbYI0BOd
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 21:14:33 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:46188 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751301AbYI0BOd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2008 21:14:33 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8R1DlCq003436;
	Fri, 26 Sep 2008 21:13:47 -0400 (EDT)
Received: from [192.168.0.65] (97-116-112-224.mpls.qwest.net [97.116.112.224])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8R1DiYa029190
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2008 21:13:46 -0400 (EDT)
In-Reply-To: <20080926224032.GA24817@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.929.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96895>


On 26 Sep 2008, at 5:40 PM, Jeff King wrote:

> I think overall this serious is well-intentioned the results look sane
> to me (I diffed the manpage and usage text before and after).
>
> My only concerns are:
>
>  4/6: ...
>       The manpage, on the other hand, is a comprehensive reference and
>       so should probably be alphabetized for easy reading.

I can buy it. I'll change it back.

>       ...
>       That being said, I find the length of the current usage  
> statement
>       somewhat ridiculous.

I'll take care of it.

>  5/6: This isn't really a documentation patch, as it adds a new config
>       option. I think the result is reasonable, but it was a surprise
>       after reading the rest of the series.

I didn't mean to mark those as Docs. I'll fix that too.

>       I was also going to complain that there was no entry in
>       Documentation/config.txt for the new option, but I see that none
>       of the sendemail options are there. Maybe while you are working
>       on this, it is worth factoring them out to send-email- 
> options.txt
>       and including it in both git-send-email.txt and config.txt.

Grumble grumble grumble... erm.. hmm.. grrr.. ok.
