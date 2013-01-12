From: Ben Aveling <bena.001@optusnet.com.au>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Sat, 12 Jan 2013 12:02:59 +1100
Message-ID: <50F0B643.20201@optusnet.com.au>
References: <A0DB01D693D8EF439496BC8B037A0AEF322039A7@xmb-rcd-x15.cisco.com> <20130111212325.GA18193@sigill.intra.peff.net> <CALWbr2xasF1y9j3G=-fQ9Wwg41Ymv=MMsWoqyuhweDov9KpRvg@mail.gmail.com> <7vy5fz9xdl.fsf@alter.siamese.dyndns.org> <CALWbr2wtAzz7yWb_Z_V0LFt5ddZcRSs7_rea2w=ghdC847mEyQ@mail.gmail.com> <7vmwwf9sx9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Antoine Pelisse <apelisse@gmail.com>, Jeff King <peff@peff.net>,
	"Matt Seitz (matseitz)" <matseitz@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 02:12:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtpeM-0001Xq-Dj
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 02:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab3ALBMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 20:12:22 -0500
Received: from fallbackmx08.syd.optusnet.com.au ([211.29.132.10]:34698 "EHLO
	fallbackmx08.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753608Ab3ALBMV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2013 20:12:21 -0500
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2013 20:12:20 EST
Received: from mail09.syd.optusnet.com.au (mail09.syd.optusnet.com.au [211.29.132.190])
	by fallbackmx08.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id r0C14QUM019731
	for <git@vger.kernel.org>; Sat, 12 Jan 2013 12:04:26 +1100
Received: from [10.1.1.5] (d110-33-193-162.mas801.nsw.optusnet.com.au [110.33.193.162])
	(authenticated sender bena.001)
	by mail09.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id r0C12rv6004634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Jan 2013 12:02:54 +1100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vmwwf9sx9.fsf@alter.siamese.dyndns.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.0 cv=E6GVPthl c=1 sm=1 a=kfTud4QeKxsA:10
	a=7WVLmRgb_OkA:10 a=8nJEP1OIZ-IA:10 a=PO7r1zJSAAAA:8 a=QnTg2CQDMjYA:10
	a=pGLkceISAAAA:8 a=wcQXagMh3ZeNzI60DuEA:9 a=wPNLvfGTeEIA:10
	a=MSl-tDqOz04A:10 a=UMGjO7nOIO1xZAhw8n2uqg==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213255>

On 12/01/2013 10:54 AM, Junio C Hamano wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> I would simply go for:
>>
>>    What Message-ID are you replying to (if any)?
>>
>> If I don't know what to answer, I would definitely not say y/yes/n/no,
>> but press enter directly.
> Sounds sensible (even though technically you reply to a message
> that has that message ID, and not to a message ID ;-)).
>
> Any better phrasing from others?  If not, I'd say we adopt this
> text.

I guess it depends on how much we mind if people accidentally miss the 
message ID.

If we don't mind much, we could say something like:

   What Message-ID are you replying to [Default=None]?


If we are concerned that when a Message-ID exists, it should be 
provided, we could split to 2 questions:

   Are you replying to an existing Message [Y/n]?

And then, if the answer is Y,

   What Message-ID are you replying to?

Regards, Ben
