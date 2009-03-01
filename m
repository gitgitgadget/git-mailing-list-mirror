From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Changing the defaults for send-email / suppress-cc ?
Date: Sat, 28 Feb 2009 20:32:45 -0500
Message-ID: <7d1d9c250902281732m7293330bt108b70a850dc5cb9@mail.gmail.com>
References: <7d1d9c250902281129t1ea0d9d0k796d97bdd0af046d@mail.gmail.com>
	 <7vsklycct9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 02:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdaZN-00033h-RL
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 02:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbZCABct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 20:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755159AbZCABcs
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 20:32:48 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:19300 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089AbZCABcs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 20:32:48 -0500
Received: by wf-out-1314.google.com with SMTP id 28so2060308wfa.4
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 17:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=PXcpVHWjbu61oUwShvhw/1JMczPqlIbrDPX/knXthuw=;
        b=vj0VeY9wQCNQKFgB0+eqhfDMVwjqBzm4kY5GTIsA6J0fboDGKNksVWibOvibDYl4aW
         hNdOcG3SvLQ8twiAe5hht4pN9cjaSKCoolgOetct6wTMwqDcwGL91rVQwhmQs8NT/0Cc
         SevdL+m7wtpR9KVqCiQaGK5ZV/OCqIBGGM2JM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=tJ0K8RQFbomOuLIG9Y9nTnMAp0N/EXhAvdoOMEMWoCIZc/YNWa0oGvztAoRy9YcxX0
         G9opSlYqwX6vKgKgM7LpkG8N2F9xNiMtq925lLYwua1n3Xwf/oqgqjES6T+BZMmm3YiE
         cnvzDpqjgNDdD4aoNtc5zcRKwl7lvsHPOT/ts=
Received: by 10.142.78.10 with SMTP id a10mr2134545wfb.345.1235871165783; Sat, 
	28 Feb 2009 17:32:45 -0800 (PST)
In-Reply-To: <7vsklycct9.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: 715decf8e3979b67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111806>

On Sat, Feb 28, 2009 at 7:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>
>> In light of this, I've simply advised new users to run something like:
>>
>> git config --global sendemail.suppresscc all
>>
>> ...just so that they won't accidentally do what I've described in the above.
>
>> Apologies if this has been discussed before; I took a quick scan of my
>> archive and didn't see any discussions on it.
>
> I think I've seen discussions in the distant past but not very recently.
> IIRC some people had exactly the same reaction as you did, and were loud,
> while others were happy with the default, but weren't as loud.
>
> But loudness depends on how annoyed they are, and unhappy people are
> louder than others, so we cannot judge much from the loudness alone.

Thanks for the reply -- I'm not interested in being "loud"  ;-)   But
I think I'm in an interesting situation where I see people who are not
necessarily wanting to use git, but are required to use git in order
to do their daily activities.  So they approach it with some
apprehension and, given what human nature is, are looking for reasons
to justify that apprehension.

>
>> With the recent thread
>> about warning people of non-back compatible changes that will appear
>> post 1.6.2 -- I thought perhaps this was a good time to
>> mention/consider it.
>
> Unless you are a single project person, or have groups of hosts that share
> the home directory that is dedicated for working only on a single project,
> using $HOME/.gitconfig for this is a bad advice to give in general; as I
> think this really depends on what you are working on.

Yes, well it is the right solution for the new users I'm working with,
since I know what their focus is, but that wasn't really where I
wanted the discussion to focus.

My point was that I've seen these new users get scared off by having
git send-email essentially embarrass them, and that it would be a
shame to have people in general get the wrong impression about git
from this one small setting, when it is such a useful tool.  Really,
it does tend to violate the principle of least surprise for the new
user.  If there is a new user who is a bit apprehensive about git, the
defaults for "suppress-cc" can give them all the evidence they need to
justify their fear of it, and then the FUD starts.   So, I think this
is a case where "do nothing, unless explicitly asked" is perhaps the
wise choice.  That was the only thing I wanted to draw attention to.

Thanks,
Paul.
