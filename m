From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: checkout extra files
Date: Tue, 4 Sep 2012 08:49:10 +0700
Message-ID: <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com> <7vsjayew50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 03:50:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8iHm-0007e6-8u
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 03:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab2IDBtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 21:49:42 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38999 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab2IDBtl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 21:49:41 -0400
Received: by ieje11 with SMTP id e11so4175562iej.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 18:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u7/1YYK+99jwG7XLYVcA2+dKGoW7anSM6qo+8PPgTZo=;
        b=TLB2kUie0vay8+puM+HZUiCAxt11VGjf5Tin8JXdyIL/efP6l2UrlRvOepVEK9yIdo
         etNdmwrlYSZXpyR59VdU/yBRcMCR9R9LWRfrwqtJm71tOYnvyJy1ZI1PCW4S0kbcXW4x
         Vo4uDPdFFyzU+zrDAnZUxrsuTgeHSZ5HrxsmZFGgaiTIbChDAMLe2o/sZto4bghYQL3K
         wAvfX3lknrMxshv6Il0hxb+DsBR73EyHLHoE5UMEh4/qSElf7gYqg5wWI1M/Yu98/lgr
         eILLJLXguZkBDivzN2BMyh5W0QiBxr7aBFXKIry6CuSNRa4rrrn4x+s8Qx5w7hKhLuNp
         x52g==
Received: by 10.50.178.97 with SMTP id cx1mr12288390igc.48.1346723381385; Mon,
 03 Sep 2012 18:49:41 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Mon, 3 Sep 2012 18:49:10 -0700 (PDT)
In-Reply-To: <7vsjayew50.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204715>

On Tue, Sep 4, 2012 at 2:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> It's confusing but I don't think there's much we can do about it.
>
> The user can, by telling the shell to expand '*' that does not match
> to nothing, though.

It works 99% the time, I don't think any users would bother setting
that or studying the shell at that detail, until they are surprised.

> Is there anything that is confusing in our documentation?  I am not
> looking for a change to the documentation that protects it from
> getting misunderstood by deliberately twisted interpretations (such
> a change would make the resulting text would harder to read), but I
> do want to make sure it is not prone to confusion even to a casual
> and careless reader.
>
> For this particular scenario, I do not see anything offhand that is
> unclear about the behaviour of Git in the documentation, even though
> as you pointed out, if the user is unaware that the shell passes
> globs unmodified when they do not match, it may lead to a confusion
> like this.  I certainly do not want to do a full "introduction to
> shell" in our documentation, but if adding a short sentence or two
> helps to avoid confusion like this, I do not strongly object to it.

Yeah, one or two sentences about two level expansion might help new
users. I'll check that. Maybe in the pathspec definition, then split
that part of out glossary-content.txt to be included in pathspec-using
commands as a separate pathspec section. Too much?
-- 
Duy
