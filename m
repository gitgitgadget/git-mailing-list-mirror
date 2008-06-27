From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 10:02:54 -0700
Message-ID: <9af502e50806271002h6c2b1bffn8e695f8298559dc7@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <20080627085007.GE12567@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:04:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCHMX-0003NH-W9
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbYF0RC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbYF0RC5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:02:57 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:31873 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbYF0RC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:02:56 -0400
Received: by fk-out-0910.google.com with SMTP id 18so519719fkq.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=to5r9zvOqPMbcMpdSYlupcQf+FlL3und4CvrQjRkFLw=;
        b=nk9aGHpZxQtKfcnleSODdSpRP0FCbaKHOc+d1niPlmF9YM8/xan9wiTytbZIWECrRf
         ZA5ygHbxr8MKybZd1TM/r/oEOWQ9DRiFgiKhNJSX8+jtZW+xaCz8fI2DIIw5BqrTXRjs
         j9ZBGX5oLDhSQFEHVFM9rPAxTUUU03GIaIxNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bo+E7Fwf/e8FulfJG4PLPLDYM3gI62awnofCMNKeLiNRxa4U8NdwR2Ei4AzMjYm2gg
         wYoF81EcLXqqCR0ff1T4+KY1uNnoDwXuni5RMoH/1bRLo2/0wNSYfxKn6uJlbUzSLcCn
         2Vaa7YGYL881qLd7BNm+Jb6Jhy7zW6y5JIF9w=
Received: by 10.82.112.6 with SMTP id k6mr66971buc.77.1214586174568;
        Fri, 27 Jun 2008 10:02:54 -0700 (PDT)
Received: by 10.82.178.10 with HTTP; Fri, 27 Jun 2008 10:02:54 -0700 (PDT)
In-Reply-To: <20080627085007.GE12567@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86599>

On Fri, Jun 27, 2008 at 1:50 AM, Petr Baudis <pasky@suse.cz> wrote:
>  Hi,
>
> On Thu, Jun 26, 2008 at 11:50:06PM -0700, Robert Anderson wrote:
>> Seems to me the concept of the "index" is a half-baked version of what
>> I really want, which is the ability to factor a working tree's changes
>> into its constituent parts in preparation for committing them.  The
>> index provides some very nice facilities to factor out changes in a
>> working tree into a "staging area", but the fundamental flaw of this
>> in my view is that this "staging area" is not instantiated as a tree,
>> so it cannot be compiled and/or tested before committing.
>>
>> Consider a facility where the state you want to commit next is built
>> up in the current working directory, and the original set of changes
>> exists in some proto-space like the index currently inhabits, where
>> you can query and manipulate that state, but it isn't instantiated in
>> your working tree.
>
>  I wanted to suggest using commit and commit --amend, but I realized
> that frankly, I don't understand quite what are you wanting to do.

I think if you read the whole message the answer to your question is there.

> Through the process, are you preparing a sequence of two commits at
> once, or merely a single commit? With s/--prep/--cached/ and throwing
> git prep away completely, it's not clear to me how would what you
> present be different at all from just using index - could you point out
> what is actually different in your workflow compared to the prep
> workflow you propose?

As I said in my original message, twice, was that the index state is
never instantiated and therefore cannot be compiled or tested.

Thanks,
Bob
