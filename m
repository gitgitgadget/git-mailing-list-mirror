From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Fri, 24 May 2013 23:38:27 +0530
Message-ID: <CALkWK0=QbDAmbRm+01FWc3Okhcgg8RdoRjwfkjrsZ8n=Zm007g@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8CaCv4eO2YH_bUKKKZWTxSu9zd3qaDQ5kdZQaKg64ggyQ@mail.gmail.com> <7vobc09sf6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 20:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfwQV-0003Wr-AL
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 20:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab3EXSJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 14:09:09 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:46153 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab3EXSJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 14:09:08 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so13233232ief.12
        for <git@vger.kernel.org>; Fri, 24 May 2013 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BgtPqF6hvtq7xtHjYBLorvxXR0qGuYFm5e85KF4roAo=;
        b=rU9paHCEd+LgLnJGKaD3ITntRsLehrlA24/KsY7mxTrVIbc+V5KIPBVjrlOy+o1z7a
         IaUESsiEgLUMDO5a24icibSAuVO1cFhJT1LeZ7dwQKqe3gy4JPKVt5xTlokI95SBRaIh
         vmysscB9z+ctdH/qa40lnHUy1vkLSL1Lw4F6Ywh/qBr4+LGCL5+1ST8+rxtBNo2VClTL
         6regIp1Z9NgNQg/dxrDqNks+drH65koVutmQEXnO+yqrYAEJxY2uVsFsgeH5Tb5VlQq9
         OsbCHgJH6wtRsrEDF0Il/mcKcnK52q0EhrbunEYp96hkutvA0KqvCUMi3w+FCttUBWz3
         q7Yw==
X-Received: by 10.50.11.72 with SMTP id o8mr194875igb.44.1369418948155; Fri,
 24 May 2013 11:09:08 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 11:08:27 -0700 (PDT)
In-Reply-To: <7vobc09sf6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225392>

Junio C Hamano wrote:
> Yes, the aim of the topic should be to make the machinery flexible
> enough so that we can lose -v/-vv implementation and replace them
> with calls to the new machinery with canned set of output format
> templates.

Definitely.  I don't want to keep my ugly alias around forever, and I
certainly want more users to have easy access to this (configurable
git-branch output formats).  However, the series is not the
theoretical exercise of prettifying the code underlying -v and -vv.
Supporting -v and -vv is something we _have_ to do to preserve
backward compatibility, and I would consider it a side-effect of the
series rather than the "aim of the topic".  The aim of the topic is to
get more useful output from git-branch.

As long as the topic doesn't paint us into a corner after which it
will be impossible to implement -v and -vv on top of the format, I
think we're good.
