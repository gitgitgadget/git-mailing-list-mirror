From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 18/27] update-ref --stdin: Harmonize error messages
Date: Tue, 01 Apr 2014 11:29:22 +0200
Message-ID: <533A86F2.90508@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-19-git-send-email-mhagger@alum.mit.edu> <xmqqy4zq2g0b.fsf@gitster.dls.corp.google.com> <5339EE33.7050708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 11:29:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUv0f-00009h-Ne
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 11:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbaDAJ33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 05:29:29 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51306 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751162AbaDAJ31 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 05:29:27 -0400
X-AuditID: 1207440f-f79326d000003c9f-c4-533a86f62dee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id B6.83.15519.6F68A335; Tue,  1 Apr 2014 05:29:26 -0400 (EDT)
Received: from [192.168.69.148] (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s319TNDi008448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 05:29:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <5339EE33.7050708@alum.mit.edu>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsUixO6iqPutzSrYYPFZDYud6yQsuq50M1k0
	9F5htph3dxeTxY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6HHxkrLH501yAWxR
	3DZJiSVlwZnpefp2CdwZP3ZuZiz4xlWx6ukd1gbGOxxdjBwcEgImEqu+23YxcgKZYhIX7q1n
	62Lk4hASuMwocXTaNUYI5yyTxM4T35lAGngFNCVuPMgDaWARUJVY8xSkgZODTUBXYlFPMxOI
	LSoQJHF4wylWEJtXQFDi5MwnLCC2iICaxMS2QywgM5kFVjNKLJ0yA6xZWMBL4tv/GaxQyxgl
	Gme9AOvgFNCR6NzXyQxxqbhET2MQSJgZKPyu7wEzhC0vsf3tHOYJjIKzkOybhaRsFpKyBYzM
	qxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCooF/B2PXeplDjAIcjEo8vJbl
	lsFCrIllxZW5hxglOZiURHmFG6yChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwfm8GyvGmJFZW
	pRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHiLgFEvJFiUmp5akZaZU4KQZuLg
	BBnOJSVSnJqXklqUWFqSEQ+K4PhiYAyDpHiA9ma2guwtLkjMBYpCtJ5iNObYsG1NIxPHreUb
	G5mEWPLy81KlxHnngWwSACnNKM2DWwRLg68YxYH+FuadAlLFA0yhcPNeAa1iAlp1MxFsVUki
	QkqqgZE3zTvnr+m6psSlO67O5LmwyPKahv2Vzzm7vSwU33I9NXhdFLa478Haa2nC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245578>

On 04/01/2014 12:37 AM, Michael Haggerty wrote:
> On 03/31/2014 11:51 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> Make (most of) the error messages for invalid input have the same
>>> format [1]:
>>>
>>>     $COMMAND [SP $REFNAME]: $MESSAGE
>>>
>>> Update the tests accordingly.
>>>
>>> [1] A few error messages are left with their old form, because
>>>     $COMMAND and $REFNAME aren't passed all the way down the call
>>>     stack.  Maybe those sites should be changed some day, too.
>>>
>>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>>> ---
>>
>> Up to this point, modulo nits that have been pointed out separately,
>> the series looked reasonably well done.
> 
> Thanks for the feedback!  Would you like me to expand the commit
> messages to answer the questions that you asked about the previous
> patches?  And if so, do you want a v3 sent to the list already or should
> I wait for you to review patches 19-27 first?

Junio, I incorporated your feedback (which so far has only affected
commit messages).  I also rebased the patch series to the current
master.  I pushed the result to GitHub [1].  I'll refrain from spamming
the list with v3 yet.

Michael

[1] Branch "ref-transactions" at https://github.com/mhagger/git

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
