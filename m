From: "C. Scott Ananian" <cscott@laptop.org>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Fri, 19 Dec 2008 12:08:22 -0500
Message-ID: <c6d9bea0812190908k223b6156j238763baeda8a0b7@mail.gmail.com>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
	 <c6d9bea0812181647n55fbb6b9w333702fc80127198@mail.gmail.com>
	 <494B68B8.20107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Howells" <dhowells@redhat.com>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 18:09:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDirA-0008NU-Go
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 18:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbYLSRI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 12:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbYLSRI0
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 12:08:26 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:9943 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbYLSRIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 12:08:24 -0500
Received: by mu-out-0910.google.com with SMTP id g7so486042muf.1
        for <multiple recipients>; Fri, 19 Dec 2008 09:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=c1GQ/fEOPiPGi4pUtl+E6h2AzZnHV8gwYxGXuSosCaE=;
        b=BJ8LLsd+x+Y4pUNMKLH0aroU5LYbS7JqJOcAKmHDePjxk/IWLvCFxO9dYj6Un6FSFT
         fGT91/21c8q1sctg3dWTxvIgmWqNvKoNlfMtPRdqkRe0F6MUL/i0miErjIe7CwvBFimH
         20cQ+aAVjOrgKEvGcHbTRU20R7gz334SJ+y/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=kviPns1N+HNPl9J9Fj+wTnLFBu7N36gLOHhxzp3sV+SnoHCn/Qv+V+ZHq9eLmLRpEv
         W/+0SOGibesLlNvwDKR4SFCu1E7zxD2VlaBRGZtnzspfZm3TNpUm4DYICqFd32w83DiF
         GUZvLeT8PGngCzi1pTbvS8UKxjtjpXjJxBK1M=
Received: by 10.103.192.10 with SMTP id u10mr1301357mup.101.1229706502703;
        Fri, 19 Dec 2008 09:08:22 -0800 (PST)
Received: by 10.102.228.4 with HTTP; Fri, 19 Dec 2008 09:08:22 -0800 (PST)
In-Reply-To: <494B68B8.20107@drmicha.warpmail.net>
Content-Disposition: inline
X-Google-Sender-Auth: 0bceeb69eff1a97e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103569>

On Fri, Dec 19, 2008 at 4:26 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> C. Scott Ananian venit, vidit, dixit 19.12.2008 01:47:
>> On Fri, Dec 12, 2008 at 1:28 PM, David Howells <dhowells@redhat.com> wrote:
>>> Add a guide to using GIT's simpler features.
>>> diff --git a/Documentation/git-haters-guide.txt b/Documentation/git-haters-guide.txt
>>> +In the above example, I've assumed that you've got your own tree with the head
>>> +at commit C3, and that you've got a branch that you want to merge, which has
>>> +its head at commit B3.  After merging them, you'd end up with a directed,
>>> +cyclic tree:
>>
>> That should be, "acyclic".  There are no cycles, because the graph is directed.
>
> Well, directed graphs can have cycles. But the revision graph of a
> revision control system has to be an acyclic directed graph. Otherwise
> parenthood would be a complicated matter ;)

I mean that the example given didn't have a cycle (even though it has
nodes arranged in a circle) because of the orientation of the edges.
But you're right, "directed acyclic graph" is a better correction; the
nodes in git do not form a tree.
 --scott

-- 
                         ( http://cscott.net/ )
