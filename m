From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Wed, 18 Feb 2015 21:49:08 -0800
Message-ID: <CAPc5daVzmMnWOdctZeYLjxocnk2vrCrwmOyFvG13mB+zmVFQRQ@mail.gmail.com>
References: <20150218191417.GA7767@peff.net> <xmqqlhju28de.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 06:49:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOJzW-0006VY-Su
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 06:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbbBSFta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 00:49:30 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:52099 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbbBSFt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 00:49:29 -0500
Received: by mail-ob0-f182.google.com with SMTP id nt9so10537899obb.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 21:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=eic0WkTiO3LWJugy7++x7VWlgTRmNQvpKvtiHPr+kL0=;
        b=PufBTr99tt8aYMiU8kAsAwNeHBovY2c/D2cc4FxvrQ841o1BFvcN4lWTv9+KMecb63
         zRrf7gghmlTNjFdf0PUpvnug6UaxQnSvi3aPAMzpG65xIn+VRhvWwbWLtt/mGTqNJpuX
         Qyya8oaz6Q4mJn5NuBGITYKOCX2ZJyp28gmxnNkwUTPXNBAlXp41Qd28W8DsuA/gMddF
         NcBe4JRmPKkvRauLGU9Tr9932IeACTW+beOWPQVrzMsZY/HruUu4zmzq1PPHfrlFmHjY
         x4T/Rac7Dpq+TWWlNYJk4VAN7af6+LBubPYBcFgrLf9DktkVHnr8krkQwtlUBGh2L8UE
         VPzg==
X-Received: by 10.202.219.215 with SMTP id s206mr1718536oig.114.1424324968730;
 Wed, 18 Feb 2015 21:49:28 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Wed, 18 Feb 2015 21:49:08 -0800 (PST)
In-Reply-To: <xmqqlhju28de.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: NWlJUp3y0_-p19T-bYlkM0Ddv3M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264084>

On Wed, Feb 18, 2015 at 1:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> A few for micros.
>
> +### Allow "-" as a short-hand for "@{-1}" in more places.
> +
> +Pick one command that operates on branch names.  Teach it the "-"
> +shorthand that stands for "the branch we were previously on", like we

In the same vein (people may have noticed that "Pick one" is meant to
make this into multiple micros ;-)

### Use unsigned integral type for collection of bits.

Pick one field of a structure that (1) is of signed integral type and (2) is
used as a collection of multiple bits. Discuss if there is a good reason
why it has to be a signed integral field and change it to an unsigned
type otherwise.  Cf. $gmane/263751
