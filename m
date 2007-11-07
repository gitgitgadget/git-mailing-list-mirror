From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Wed, 7 Nov 2007 17:26:49 -0500
Message-ID: <20071107222649.GL29728@fieldses.org>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <F783880C-A0F9-45D9-A23A-075600B31CEE@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, gitster@pobox.com,
	Ralf.Wildenhues@gmx.de, git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:27:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IptMg-0006io-3V
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757187AbXKGW06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757104AbXKGW06
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:26:58 -0500
Received: from mail.fieldses.org ([66.93.2.214]:42651 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbXKGW05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:26:57 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IptMH-0003SC-UW; Wed, 07 Nov 2007 17:26:49 -0500
Content-Disposition: inline
In-Reply-To: <F783880C-A0F9-45D9-A23A-075600B31CEE@lrde.epita.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63876>

On Wed, Nov 07, 2007 at 11:16:06PM +0100, Benoit Sigoure wrote:
> Hi Steffen,
>
> On Nov 7, 2007, at 10:50 PM, Steffen Prohaska wrote:
>
>> This commits adds a discussion of the challenge of bisecting
>> merge commits to the user manual. The text is slightly
>> adapted from a mail by Junio C Hamano <gitster@pobox.com>
>> to the mailing list
>> <http://marc.info/?l=git&m=119403257315527&w=2>.
>>
>> The discussion is added to "Exploring git history" in a
>> sub-section titled "Advanced topics". The discussion requires
>> detailed knowledge about git. It is assumed that the reader will
>> skip advanced topics on first reading. At least the text suggest
>> to do so.
>>
>> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
>> ---
>>  Documentation/user-manual.txt |   89 
>> +++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 89 insertions(+), 0 deletions(-)
>>
>> Some minor errors were fixed. Thanks to <Ralf.Wildenhues@gmx.de>.
>>
>> I kept the naming of the commits. Benoit Sigoure suggested to choose
>> a different naming which he claims would be easier to remember.
>> I'm not convinced. The current naming starts with X, Y, Z on the left
>> and names the remaining commits on the right with A, B, C, D. This
>> is simple and give sufficient orientation.
>
> I still disagree but...  fair enough ;)
> You end up comparing [ABCD] with [XYZ] which (to me) is hard to follow 
> because it's like you were comparing two different kind of entities.  I 
> tend to think more in term of branch (e.g. what's happened to the upper 
> branch and what's happened to the lower branch, rather than think in terms 
> of "before a point in time" and "after that point in time").  Because of 
> that, I constantly need to look back at the scheme to find out what is `A', 
> what is `Z' etc.
>
> Some more comments below.  Sorry for not spotting these earlier.
>
>>
>> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
>> index d99adc6..d0e738e 100644
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -934,6 +934,95 @@ Figuring out why this works is left as an exercise to 
>> the (advanced)
>>  student.  The gitlink:git-log[1], gitlink:git-diff-tree[1], and
>>  gitlink:git-hash-object[1] man pages may prove helpful.
>>
>> +[[history-advanced-topics]]
>> +Advanced topics
>> +---------------
>> +This section covers advanced topics that typically require more
>> +knowledge about git than the manual presented to this point.
>> +
>> +You may want to skip the section at first reading, and come back
>
> I think the correct wording here is "on first reading".  If a native 
> English speaker could confirm this...

Confirmed....

--b.
