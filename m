From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: git add -p and unresolved conflicts
Date: Thu, 29 Mar 2012 12:19:27 +0200
Message-ID: <4F74372F.1030505@ira.uka.de>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com> <7vbongyd67.fsf@alter.siamese.dyndns.org> <vpqvclozr7e.fsf@bauges.imag.fr> <4F73632E.1060408@ira.uka.de> <7vmx70v8ho.fsf@alter.siamese.dyndns.org> <4F736C17.4000403@ira.uka.de> <20120329060853.GD27604@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	kusmabite@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 12:19:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDCRd-0008RD-4s
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 12:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758Ab2C2KSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 06:18:54 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59481 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932719Ab2C2KSr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 06:18:47 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1SDCR9-0003FZ-2o; Thu, 29 Mar 2012 12:18:40 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1SDCR8-0000kp-UV; Thu, 29 Mar 2012 12:18:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <20120329060853.GD27604@sigill.intra.peff.net>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1333016320.136554000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194245>

On 29.03.2012 08:08, Jeff King wrote:
> On Wed, Mar 28, 2012 at 09:52:55PM +0200, Holger Hellmuth wrote:
>
>> On 28.03.2012 21:19, Junio C Hamano wrote:
>>> Holger Hellmuth<hellmuth@ira.uka.de>   writes:
>>>
>>>> I don't think it's that tricky:
>>
>> I was assuming this "tricky" was about a sensible user interface.
>
> I think maybe the discussion elsewhere in this thread has given you a
> taste of the trickiness, but if you want to read more, here is a similar
> discussion from the same time last year (ahh, Spring, when a young man's
> thoughts turn to partial staging of conflicted hunks):

It already dawned on me that to add the proposed conflict resolution 
would also mean changing the working copy of the file which none of the 
other options needs. Which would change the work from (assumed) surgical 
changes to completely new routines and special cases and....
