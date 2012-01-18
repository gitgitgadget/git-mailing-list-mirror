From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] pulling signed tag: add howto document
Date: Wed, 18 Jan 2012 16:40:45 -0500
Message-ID: <4F173C5D.7000802@xiplink.com>
References: <7vehuyosaa.fsf@alter.siamese.dyndns.org> <7v62g9q55f.fsf@alter.siamese.dyndns.org> <4F16E228.5050203@xiplink.com> <7v62g8n1tq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 22:42:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RndHU-0004lC-NA
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 22:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab2ARVmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 16:42:51 -0500
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:35367 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab2ARVmv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 16:42:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp33.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 5926B3018D;
	Wed, 18 Jan 2012 16:42:50 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp33.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 342903070A;
	Wed, 18 Jan 2012 16:40:48 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <7v62g8n1tq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188764>

On 12-01-18 04:22 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
>>> +
>>> +------------
>>> + $ git checkout work
>>> + $ ... "git pull" from sublieutenants, "git commit" your own work ...
>>> + $ git tag -s -m "Completed frotz feature" frotz-for-xyzzy work
>>> +------------
>>> +
>>> +and pushes the tag out to her publishing repository [*2*]. There is no
>>
>> This footnote speaks of the example using a +, but the example does no such
>> thing.
>>
>>> +need to push the `work` branch or anything else:
>>> +
>>> +------------
>>> + $ git push example.com:/git/froboz.git/ +frotz-for-xyzzy
>>> +------------
> 
> Do you not see the plus in front of +'frotz-for-xyzzy' above, or am I
> missing something?

Oops, I was tripped up because the footnote is attached to a sentence that my
addled mind associates with the previous "git tag" example.

It might be better to just move the footnote to the end of the next sentence.

		M.
