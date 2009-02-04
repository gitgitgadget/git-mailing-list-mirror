From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Best CI Server for Git?
Date: Wed, 4 Feb 2009 14:23:13 -0500
Message-ID: <c115fd3c0902041123j4a16d666r6d1fbb9917184b2a@mail.gmail.com>
References: <c115fd3c0902021258i61a04f74u481ba66c645fe8f5@mail.gmail.com>
	 <1c5969370902021642v4e8d93djd22d5caa4aa9d1a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 20:24:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUnMa-0006Ps-VX
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 20:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232AbZBDTXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 14:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbZBDTXP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 14:23:15 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:19392 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942AbZBDTXP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 14:23:15 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1000438yxm.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 11:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eKqvhJxiLh8k/Sbl7Ysf2tHTFscPolebuxKI+0tFewA=;
        b=gV5yi+7u7UA45HtSuBVNoDtOyaEe3R6OfzDELKcNVIE/Sv+wi51fC422QWjMy6ESpr
         t1zPACtJALB+XtIb5RJ2xX7vrHcau85Uqel07T3QEdoGtnhfJTYl/S37evGZSEnVCRRm
         W8I97dTyP6/8NMHo77Q6VSH623Go7v2tHZH5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O8k+8HBxcNqLHBkiEdSYJGa3FgDAKyRYnmkpCju15CS8Q/2gZBLqzusRm+oYuzFR5c
         WLD/fzZ5yC4GEdJmglg0wyqYwDfVFr31PS3Ls6XOVKuo0JuFXaBZD0BL+dMn2Oi8qDqb
         8Z4bE8g3FXcyRN4WMfe6KbgsaqH3bGa8UITWI=
Received: by 10.100.139.20 with SMTP id m20mr412595and.147.1233775393551; Wed, 
	04 Feb 2009 11:23:13 -0800 (PST)
In-Reply-To: <1c5969370902021642v4e8d93djd22d5caa4aa9d1a9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108413>

On Mon, Feb 2, 2009 at 7:42 PM, Matt Graham <mdg149@gmail.com> wrote:

> Hudson leaves a fair amount to be implemented by plug-ins, so not
> being installed out of the box doesn't really imply bad.  I would say
> that there are more significant differences between Hudson and Cruise
> Control than how they integrate with Git.

Makes sense.

> We are currently switching from Cruise Control to Hudson for reasons
> related to ease of use.

Would you mind being a little more specific?  The basics of what I've
heard is that Cruise Control is ultimately much more flexible and
capable, but that Hudson beats it hands down regarding usability and
UI.  What specific issues had your team come up against?

> Here is another hudson/git plugin.  It may not be quite as official
> but addresses issues people have had with the more official one:
> http://github.com/stephenh/hudson-git2

I remember when this was announced.  Unfortunately, I can't find a
clear comparison of the two.  I heard in a recent thread on here that
at least some of the problems being answered by hudson-git2 have been
cleaned up in the latest version of the official plug-in.  Is it still
the case that there are problems in the official one that are fixed in
Stephen's?

Thanks so much for your help! :)

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
