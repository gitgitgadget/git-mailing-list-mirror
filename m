From: Howard Miller <howardsmiller@googlemail.com>
Subject: Re: How to commit bug fixes from old revisions
Date: Fri, 18 Dec 2009 15:15:46 +0000
Message-ID: <26ae428a0912180715v15d85fbcm9fef7c33f6ccf448@mail.gmail.com>
References: <4B2B996D.9070302@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Richard Rossel <rrossel@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Fri Dec 18 16:15:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLeYd-0002L2-16
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 16:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbZLRPPu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Dec 2009 10:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbZLRPPu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 10:15:50 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52195 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627AbZLRPPt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2009 10:15:49 -0500
Received: by ewy19 with SMTP id 19so1587741ewy.21
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 07:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J8AYiI0hOGEZWM8NlOTnUvajlagmmzq55a26PJXZUc0=;
        b=OinDdfRDKmgJY7oCbH/LhXCSSmPw19Mb/Zb91jiP4zLMulxMQbg+mwOb4VreB1gS0z
         vZEQI3yx4NqTL1GkfXHVHCEvcvTUOovbtoMa1xV5Mpsa1aFAYm1MrYjmCcym0T+H3U+k
         Mdap+7NXz3c9gulHa7o9WpWi5Ot5fiDWa28d8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BQjGLHn2gHSM1Eu/+n8uk4uM0RADZlHL6UTfRtXHuDPGvwWr6GWbmVhLzbR/3Jk8bA
         hi7m0ZGZ95SbXItvhoj5T3o2B6pLsRELpDmQ07v9zh3zALFZ2sBqlxrevTi2ATadtKQq
         cjn9WnYM5O3RExHO/BXHU1sM4PF0zmkhbr8gw=
Received: by 10.213.37.137 with SMTP id x9mr501781ebd.78.1261149346710; Fri, 
	18 Dec 2009 07:15:46 -0800 (PST)
In-Reply-To: <4B2B996D.9070302@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135415>

2009/12/18 Richard Rossel <rrossel@inf.utfsm.cl>:
> Hi,
> I'm confused with how to commit bug fixes from old tagged version.
> Lets says that I have a serie of tags (v1.0, v1.1, v1.2, v2.0) in mas=
ter,
> and there is a bug from v.1.2. The bug was fixed, but I don't
> want to merge to v2.0, because there are not compatibles. The bug fix=
ed
> should be
> tagged as v1.3
>
> So the question is how to commit between revisions( in the example, b=
etween
> v.1.2 and v2.0),
> without made any change in the HEAD of master (v2.0)
>
> Or maybe the solution is to separate the versions =A0in different bra=
nches or
> different repos.

I think it depends on how you look at it.  The tag implies that v1.3
is a fixed release but what you say implies a branch. What I would do
is have a (say) '1.3_RELEASE" branch and that has the various fixes
merged on it. To put it another way, does your fix mean that there'll
be a v1.3.1? If so you would be tagging that on the 1.3 branch
(probably).

HTH
