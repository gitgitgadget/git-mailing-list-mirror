From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/3] revisions.txt: language improvements
Date: Sun, 03 Apr 2011 15:05:11 +0200
Message-ID: <4D987087.1050305@drmicha.warpmail.net>
References: <cover.1301569271.git.git@drmicha.warpmail.net> <cover.1301649867.git.git@drmicha.warpmail.net> <cc9e86c7a7cacc7eea66090b38443739e6fbc672.1301649867.git.git@drmicha.warpmail.net> <7vsju1eiff.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 15:05:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Mzo-0006c6-1w
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 15:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab1DCNFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 09:05:08 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39610 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752322Ab1DCNFH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 09:05:07 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3FCB220CBD;
	Sun,  3 Apr 2011 09:05:07 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 03 Apr 2011 09:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=iKq9a3oxSoNnX/QyK80Z0WludQU=; b=cJIQgx6GVhlT8Zh2p5PQxIloNdRBjaYc+/wQEcSlwD+XnNG1gkMubp3oFLTHs83nlkcXOKNOTvnkqW+HFTSgwM8YbzobKlFp+pqGehsQwBwcoxp4SFPTzxgOgW66Nm2M5YXARZXZxb18APBCTi36tHzkkbSLCn65Vfx6goNFb4E=
X-Sasl-enc: o3g4RGpZZv+t3iynMSxj2oU/EcDzguJDhI1D86gHfSo7 1301835906
Received: from localhost.localdomain (p54858924.dip0.t-ipconnect.de [84.133.137.36])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4B36E40147E;
	Sun,  3 Apr 2011 09:05:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vsju1eiff.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170689>

Junio C Hamano venit, vidit, dixit 02.04.2011 00:05:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> 
> Thanks.
> 
>>  Documentation/revisions.txt |   68 +++++++++++++++++++++---------------------
>>  1 files changed, 34 insertions(+), 34 deletions(-)
>>
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index 92bc662..25125c3 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -2,20 +2,20 @@ SPECIFYING REVISIONS
>>  --------------------
>>  
>>  A revision parameter '<rev>' typically, but not necessarily, names a
>> -commit object.  They use what is called an 'extended SHA1'
>> +commit object.  It uses what is called an 'extended SHA1'
>>  syntax.  Here are various ways to spell object names.  The
>> -ones listed near the end of this list are to name trees and
>> +ones listed near the end of this list name trees and
>>  blobs contained in a commit.
>>  
>>  '<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
>>    The full SHA1 object name (40-byte hexadecimal string), or
>> -  a substring of such that is unique within the repository.
>> +  a substring that is unique within the repository.
> 
> Do we need to rephrase this a bit more, so that it would be clear that
> "e86e1950b" is not an abbreviated object name, even though it is a
> substring and may be unique within the repository?
> 
> Perhaps "a prefix of such a full SHA-1 object name that is unique..."?

Yes, definitely, I missed that.

> 
>> @@ -79,8 +79,8 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
>>  
>>  '@\{<n>\}', e.g. '@\{1\}'::
>>    You can use the '@' construct with an empty ref part to get at a
>> +  reflog of the current branch. For example, if you are on
>> +  branch 'blabla' then '@\{1\}' means the same as 'blabla@\{1\}'.
> 
> Is that "a reflog of the current branch", or because there is only one
> reflog, should it be "the reflog of the current branch"?  Ah, we mean one
> entry in the reflog (an entry of the reflog of the current branch), so
> this probably is Ok.

"reflog entry of the..." would be clearer, yes.

> 
>> @@ -133,8 +133,8 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
>>    a commit whose commit message matches the specified regular expression.
>>    This name returns the youngest matching commit which is
>>    reachable from any ref.  If the commit message starts with a
>> +  '!' you have to repeat that;  the special sequence ':/!',
>> +  followed by something else than '!', is reserved for now.
> 
> Hmm, shouldn't it be "something OTHER than" instead?

I think both are correct, "else" is maybe slightly more
American/colloquial in this context. I'd be happy with both.

> 
> Grammar is hard; thanks for cleaning them up.
> 

I too :)
