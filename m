From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: Trying to split repository
Date: Thu, 1 Oct 2009 20:47:15 -0400
Message-ID: <c376da900910011747i894404dne1ea60dae5e3990b@mail.gmail.com>
References: <20091001160335.GA26068@raven.wolf.lan>
	 <c376da900910010949p197aa311l9c91ef711beffdf7@mail.gmail.com>
	 <20091001211340.GB26068@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 02:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtWIs-00059n-90
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 02:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbZJBArN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 20:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbZJBArN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 20:47:13 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:43333 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbZJBArM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 20:47:12 -0400
Received: by bwz6 with SMTP id 6so608459bwz.37
        for <git@vger.kernel.org>; Thu, 01 Oct 2009 17:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=RE8zzOrONaWFdJp6rWCH7lG/Ct9QfVXfz9qojslmzXA=;
        b=q8X1XBlWs0vCf5nbHWWQy5kFaBp2RzMpTDy6Fr9KO5oYIzsPiKF9FqfXZ8StI+W3FN
         J849Q+bbEKX0cO7EcCfJzQWJfB3nPC/YsTbM4p2PP8kn7g0SOOp+gwSkDrTJPaCvsLG5
         UknGTF0dFFZlNIbuOIKixFhoR0p3WU9fpD6iM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=d0YZ/f86YPQURqmiWt3E6OcLtdeEQynbrRqNjTGeKIkcItvVSjZ2pQrZvGWKLn2L1E
         ISdovtqUeVNMjyu0r87c8n/626IP7rAqt9sCyErarHhHh6mDXtvtQWGTctdD/tOBIemy
         9t7/26gam72y+dUqtVvXuQW6T7Zhqu9OEvfLU=
Received: by 10.204.174.209 with SMTP id u17mr597278bkz.7.1254444435722; Thu, 
	01 Oct 2009 17:47:15 -0700 (PDT)
In-Reply-To: <20091001211340.GB26068@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129418>

>>
>> git-filter-branch accepts a --prune-empty option that does what I
>> think you're looking for.
>
> Thanks for your answer, Adam!
>
> Is this a new option? 1.6.0.2 don't seem to have it?

1.6.0.2 was released September 2008 (git log -n1 v1.6.0.2).

This feature was added in October 2008.  (git blame
Documentation/git-filter-branch.txt; git log -n1 d3240d93).

It's still it is missing from the option summary in master though.

Adam
