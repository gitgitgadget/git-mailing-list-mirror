From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Merge priority
Date: Thu, 26 Nov 2009 17:22:20 +0100
Message-ID: <46a038f90911260822x3cf5fcd1ka7e503764cae699c@mail.gmail.com>
References: <26ae428a0911260444j45437a92r47d7f2e8b292829e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 26 17:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDh6z-0000t4-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 17:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760668AbZKZQWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 11:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759474AbZKZQWQ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 11:22:16 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:40218 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416AbZKZQWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 11:22:15 -0500
Received: by ewy19 with SMTP id 19so597702ewy.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 08:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=R/Ojq1pgF/F9D1tE76z3jFzYCY+vDOM818V4UaNue1Q=;
        b=KNJlKswOcI3YS5rBF6F0XKgTFDaa1jQTStWl8h/NECO8c2snle/m/VDoKXGxfTPkrb
         AtAlOsd1s+s5pj5/yWF1FGDt7kfzv4zCYwn0Hhoy9mRXk6bQNIC4EYKZlpgE8BccPRZK
         x6jM9ALB6YJ2z56C6RpL0CwkT+SKLv9HnA0cw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PUKlk/XnbBz5X9Td68OnS2IcMZUeu1RTcF479emxdiF13guCwitBnoZuXJv/kUBJan
         79+Arpg+3AdvaZlTseUIy9yYPLQ5mM8HKxEAJIF9pNll2TOsLwThunzVedzYPq8J6tHZ
         /CvbG/zimysS4oaQwnQxEI6SKiL3JyCZmMgSA=
Received: by 10.213.23.214 with SMTP id s22mr8486196ebb.11.1259252540253; Thu, 
	26 Nov 2009 08:22:20 -0800 (PST)
In-Reply-To: <26ae428a0911260444j45437a92r47d7f2e8b292829e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133807>

On Thu, Nov 26, 2009 at 1:44 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> I now want to update all my customer branches with the latest fixes
> and patches. Naively, I would just check out each branch and merge the
> stable branch - job done.

Yep, that's what I'd do.

> However, is it sensible to ask if there is a
> way to say that the stable branch is more important if there are
> conflicts.

Not really. The git approach is to assume that... when there is a
conflict, you must look into it. A human needs to take a decision...

> Or should I be using rebase instead (which I still don't
> really understand). I'm trying to reduce my workload as there are
> loads of branches to do.

No, rebase will increase the load and complexity.

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
