From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 5/8] push, send-pack: support pushing HEAD to real ref name
Date: Sun, 28 Oct 2007 09:03:16 +0100
Message-ID: <C83C1B1F-99A9-4F47-9C1A-55170CF61338@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de> <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de> <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de> <11935038084055-git-send-email-prohaska@zib.de> <7vwst7wvdr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 09:05:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im38m-0005fR-Qz
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 09:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbXJ1IEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 04:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbXJ1IEr
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 04:04:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:63902 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbXJ1IEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 04:04:44 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9S81ol2013507;
	Sun, 28 Oct 2007 09:04:41 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1072b.pool.einsundeins.de [77.177.7.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9S81njI023410
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 28 Oct 2007 09:01:50 +0100 (MET)
In-Reply-To: <7vwst7wvdr.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62536>


On Oct 28, 2007, at 8:28 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> This teaches "push <remote> HEAD" to resolve HEAD on the local
>> side to its real ref name, e.g. refs/heads/master, and then
>> use the real ref name on the remote side to search a matching
>> remote ref.
>
> This probably is a good idea.

I'll think about Daniel's suggestion of implementing it
differently.


>> +	if (real_name) {
>> +		free(real_name);
>> +	}
>
> Excess and unnecessary brace pair.

When are excess and unnecessary braces acceptable?
Is

	if (something) {
  		printf("text %d"
   		       "more text %d"
                        "and even more %d\n"
		       , a, b, c);
	}

ok? Or should I avoid braces there, too?

	Steffen
