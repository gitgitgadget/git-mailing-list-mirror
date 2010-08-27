From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Does changing filename case breaks git's rename heuristic?
Date: Fri, 27 Aug 2010 16:02:18 -0400
Message-ID: <AANLkTikPcPAGn6VMiD9Mbxfq3rdU4EeHsd32qniYu5VZ@mail.gmail.com>
References: <AANLkTinxvj85Jzb-ykK0=MmRHkz8aQzmVxexC8H+Xgno@mail.gmail.com>
 <4C777090.2000107@drmicha.warpmail.net> <AANLkTikN_PbNNH2f4zWuk1FH+LgpKzkoZ6mYOdT9ANBj@mail.gmail.com>
 <4C77DDDC.8070407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dan Loewenherz <dloewenherz@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 27 22:03:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op58b-00065o-Dq
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 22:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab0H0UCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 16:02:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53544 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477Ab0H0UCt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 16:02:49 -0400
Received: by iwn5 with SMTP id 5so2861309iwn.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ex94Bt5ESLBps0KsO8KLypTh5+6u7foPxF92NOyCIyc=;
        b=ETBUJnWYsrgzS3uEsz0dfLtqHckIao6Y/Mcy/X8YVA9fC/Zul8GyDjxqdu92FQpaCY
         15q9qBrr4DtbC3EWF+dZqY2/UBzJuGmxkBOy+RG/LtqQP/tYbOfOG2btfd8GhNxx7nhE
         zjgXc4gBrftoB+kHjiy978CF8D78Fyo8Qbwfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=SCOWl/iPTFxnYKEOMo0NBnAlR/rvuzoXCxH2AuhlhFryZ9dzyWSQpOVnaZFx0LmEYR
         ZnCTfQNbA/EB7cRTai4Lg6i64w8tJbDxd/ZNAWcywFrwKzd9mLieskbnJ0d9zV9zmMCh
         FH0uGEmCsgDYMT9vDPXh9h38UiueIFo/vnS/o=
Received: by 10.231.151.198 with SMTP id d6mr1586507ibw.86.1282939368293; Fri,
 27 Aug 2010 13:02:48 -0700 (PDT)
Received: by 10.231.161.199 with HTTP; Fri, 27 Aug 2010 13:02:18 -0700 (PDT)
In-Reply-To: <4C77DDDC.8070407@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154615>

On Fri, Aug 27, 2010 at 11:46 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> The journalling is no problem, but HFS is. I'm no Macxpert but if I
> remember correctly, then under HFS "readme" and "README" are the same
> file, i.e. HFS only remembers how you want it spelled. People will
> correct me where I'm wrong.

That's correct, HFS is case-preserving but case-insensitve. There is a
case-sensitive variant but it is not the default and sadly, some
applications assume case-insensitity and will break if the system
volume is otherwise.

j.
