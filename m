From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Expand explanation of the use of + in git push refspecs.
Date: Thu, 19 Feb 2009 19:20:15 +0100
Message-ID: <bd6139dc0902191020i787e56a7tbe88cedfc2cb4028@mail.gmail.com>
References: <20090219180258.2C7983360A6@rincewind>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 19:22:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaDXE-0005X7-DN
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 19:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbZBSSUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 13:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbZBSSUV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 13:20:21 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:43107 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbZBSSUS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 13:20:18 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1284486fgg.17
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 10:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=9vZ37ayl8wsNXzDIfx6QKrN5sPtL+hUDUoeFUUR7qn8=;
        b=qNkZbqKMc2eaNF6iF1aEDUxK4AyTbMA3duYNnyHcjs8fVckMYiBO7KcBqwPRGt/rhg
         SBv1qOth1Q4lhexEncXFh6C4ucpkep3HYbRYbRcvqptmHhI/hFRsGg+86aVFXfKadVc/
         8R3p14HUtMQc2PAJadIqJV6BloBUZ+Yc+A/Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=TA7j/IAgiy5k3pq24Hw8bvzzq4KtYEbWSbYnUwRtytKqT1XVRMMXAZE0pwisDzZiW1
         UzlqYNHoBgXkU8s+Mj5hPFUmc59iSCEKc6V9QgoxwVs9VJQlrUMweJp/SV5V00LEglaZ
         sxEuJqy2R78kE3c7magcTzRk7fio67nNCDtdQ=
Received: by 10.86.65.9 with SMTP id n9mr495576fga.61.1235067615872; Thu, 19 
	Feb 2009 10:20:15 -0800 (PST)
In-Reply-To: <20090219180258.2C7983360A6@rincewind>
X-Google-Sender-Auth: 646065e9927e4cbf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110727>

On Thu, Feb 19, 2009 at 18:39, Marc Branchaud <marcnarc@xiplink.com> wrote:
>  Documentation/git-push.txt |   40 ++++++++++++++++++++++++++++++++--------
>  1 files changed, 32 insertions(+), 8 deletions(-)

Most of this is under examples, so I don't think this is cluttering
the man page too much.

> +is recommended only for private, unshared repositories.)  See EXAMPLES

I don't know about this line, I reckon Junio has a + refspec for the
pu branch, that is, it's ok to use a + refspec if you let others know
that the branch may be 'rebased'.

> +       branch.  *This can abandon commits in the origin repository.*

I liked your wording with the commits becoming dangling better.


> +That is, commits A and B would belong to an unreachable branch without a
> +symbolic name.

Perhaps it would be better to say those commits "would no longer
belong to a branch with a symbolic name, and thus become unreachable"?

-- 
Cheers,

Sverre Rabbelier
