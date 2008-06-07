From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] improve doc heading for git-bisect
Date: Sat, 7 Jun 2008 18:25:53 +0200
Message-ID: <200806071825.53974.jnareb@gmail.com>
References: <20080607070637.79B17C7C0E@rwavmlap> <m37id1y4zj.fsf@localhost.localdomain> <9af502e50806070906u63e52de4wa0bc4dced0c4d984@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Robert Anderson" <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 18:27:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K51G7-0005Ey-Od
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 18:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759748AbYFGQZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 12:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759780AbYFGQZ7
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 12:25:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:42253 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759478AbYFGQZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 12:25:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so998399fgg.17
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 09:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xYPn9i9AZd/vh0KqyO4omesbBL2U37aV4IyJL9CN4jM=;
        b=fv3nrgFG5Q4A1XFmJNfnopF509YhE5si/lG52fQFsz4o8LmMU+4OzkLH0ue8KFXx7O
         up7xMYOA9ZVrlWaDkJJpVAH5WB5bvGwGwNIZvUD6Lbzwf9fZeUODpeOGoVHuGL46p1Wp
         VxxknxgVdI47APVbvddyGhsKUI4/w08E2VzP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=eBdglc7vnWFBHsDX+eGLpr94ewJt9WMy5XsFeozaNmdjfE/ZlZ+IrSC2rcfRE5iOMN
         3LdunlLuG6NDjdGNb5VWNkCBIS6Exc8QCh92DC8okSBnOh64+Am/7oVaxFk9vIpKLTok
         3a+7VEc0Jp2g+ncRGgynZ6dNNNImHVIkWwP6g=
Received: by 10.86.27.19 with SMTP id a19mr1994252fga.56.1212855957222;
        Sat, 07 Jun 2008 09:25:57 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.218.155])
        by mx.google.com with ESMTPS id 4sm7695120fgg.9.2008.06.07.09.25.54
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Jun 2008 09:25:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <9af502e50806070906u63e52de4wa0bc4dced0c4d984@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84214>

On Sat, 7 Jun 2008, Robert Anderson wrote:
> On Sat, Jun 7, 2008 at 2:22 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> rwa000@gmail.com (Robert Anderson) writes:
>>
>>> From 7af03a835b7311c501f2147e25f428642fc3acb7 Mon Sep 17 00:00:00 2001
>>
>> FYI this line is not necessary, and should be removed from
>> git-format-patch output when pasting it to your MUA.
> 
> Err, then shouldn't it be removed from format-patch, rather than
> deleted manually every time format-patch is used?

It is needed, I think, for git-format-patch output to be in mbox format,
so you can just send it (for example using git-send-email), or make
your MUA open it.

If you copy'n'paste, or equivalently use "insert file", into body of
your message, this is not necessary and should be removed.

>>> From: Robert W. Anderson <rwa000@gmail.com>
>>> Date: Fri, 6 Jun 2008 23:53:37 -0700
>>> Subject: [PATCH] improve doc heading for git-bisect
>>
>> FYI the above isn't strictly necessary: if you have 'From:' header set
>> correctly you can simply set subject of email, and put in body the
>> rest of commit message and patch only, without extra mail-like
>> headers.
> 
> Then remove them from format-patch, IMO.

Well, the "Subject:" is neede to copy it to the email subject line
in your MUA.  If from differs from the account you send email from,
it should also be set or left in the body of message.

Besides, there are two conventions of sending patches to git mailing
list, used in slightly different circumstances.

1. Put "Subject:" in the email subject line, remove all headers,
   put comments to patch (those which do not belong in commit message
   itself, for example how the patch differs from previously sent
   version, etc.) between "---" and diffstat.

2. In the case when patch is response to longer thread, or the message
   body is much longer than commit message, you have the comments to
   patch or further part of discussion at beginning, then some kind
   of marker e.g. "-- >8 --" (scissors), but NOT "---" to mark beginning
   of commit, then commit message, including From: and Subject: lines.

In short: this information is sometimes needed.

>>> Improve awkward heading in git-bisect documentation.
>> [...]
>>> -Avoiding to test a commit
>>> -~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +Changing the revision to test
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>>  If in a middle of bisect session, you know what the bisect suggested
>>>  to try next is not a good one to test (e.g. the change the commit
>>
>> It is, I guess, better, but is it the best heading?  What we want to
>> describe here is how to deal when bisect stops on commit which cannot
>> be tested (e.g. project does not compile).
> 
> I disagree. The situation you want to use this is more general than
> that.  Maybe you could test it, but doing so would be a waste of time
> because the commit is a trivial comment change.  In general, this
> simply what you need to know when you want to change the revision
> under test.

Well, I don't have better idea on how to write short but precise header,
and your change is certainly better...

-- 
Jakub Narebski
Poland
