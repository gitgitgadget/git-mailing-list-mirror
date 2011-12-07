From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: Query on git commit amend
Date: Wed, 07 Dec 2011 07:58:07 +0530
Message-ID: <87wra9und4.fsf@gmail.com>
References: <4EDDD0E4.6040003@st.com> <87fwgxwvn9.fsf@gmail.com>
	<7vobvlfowk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Viresh Kumar <viresh.kumar@st.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 03:28:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY7F8-0003vR-7p
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 03:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab1LGC2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 21:28:12 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62861 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab1LGC2L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 21:28:11 -0500
Received: by iakc1 with SMTP id c1so135834iak.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 18:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ehqIOXoyoIuuE3P3/lfJYWtWFBnmhac/2pahlbpX3vM=;
        b=hTYLyU9AbRZSh0IR7gG5U07izmU4m40tvg9iZ6DbplIX1niM4aoKNwKVv9i+XsAEsu
         T2UVmjXJWHvAVDgAABWyel4iMhO3Biw0P/WcXBoswL4N6gBmQubGJqmJRpg6TIwpbzQ5
         eZghoHsoYknZosE8f/FDn4++eq77SGzywLt3E=
Received: by 10.50.197.167 with SMTP id iv7mr17479927igc.46.1323224890244;
        Tue, 06 Dec 2011 18:28:10 -0800 (PST)
Received: from BALROG ([59.92.45.19])
        by mx.google.com with ESMTPS id g16sm817704ibs.8.2011.12.06.18.28.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 18:28:09 -0800 (PST)
In-Reply-To: <7vobvlfowk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 06 Dec 2011 12:03:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186416>

Junio C Hamano <gitster@pobox.com> writes:

> Vijay Lakshminarayanan <laksvij@gmail.com> writes:
>
>> I've found 
>>
>> $ GIT_EDITOR=cat git commit --amend
>>
>> useful.
>
> Are you sure it is a cat?

Yes.

Did you mean something else by your question?

> I almost always use
>
>     $ EDITOR=: git commit --amend

I just tried this out.  This and Peff's GIT_EDITOR=true silently dwiw
but cat is useful to review the commit.

-- 
Cheers
~vijay

Gnus should be more complicated.
