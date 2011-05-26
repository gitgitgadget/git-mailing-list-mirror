From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 08/10] revert: Introduce HEAD, TODO files to persist
 state, plan
Date: Thu, 26 May 2011 22:35:25 +0530
Message-ID: <BANLkTi=ifQYFbq-ntpVF=1+sjv-wdkEJ-w@mail.gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com> <1306425233-504-9-git-send-email-artagnon@gmail.com>
 <20110526161102.GC24931@elie> <BANLkTi=FkK=k6OavQtqMRvPCZ7nc+iKtwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 19:05:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPe0O-0001QR-Jy
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 19:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725Ab1EZRFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 13:05:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58265 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757517Ab1EZRFq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 13:05:46 -0400
Received: by wya21 with SMTP id 21so675215wya.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=L2Iu/VsjJ1b7u4X9NnA8SBskID1prB8NFT6jg3Zh/Js=;
        b=XKmPk7m0mJrrkAuzWbmSKy9x33ABOf9U4XoKUuggPbV2d7dD/PBt6zckzFNMoDSvRo
         XlyNkZrFZF/8yYHxNA72lUHw4lDsiCP19fPJoBTyxUUsY5gZlVU79oVUC0/w+kNoYHx4
         lsIyIzmXqio+2LgDBLkaZl6d0PABzV/fmQtnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lN/9sbV6gmG/z8QvXVpafQAsmIWpqnLXNYwVrIFGNiFNzUwuGGQLxlt4kFLaOYYBUe
         Qt2rcZwISVFQbrg347JzMnjhOvexjoKniaOB8kg9OURadu9hKO1Xb6fEyWZlUppZbk70
         oAdHNExlqmbNZnBKYIi7U1GgF1n+oVUoLI6Tg=
Received: by 10.216.255.201 with SMTP id j51mr1015677wes.94.1306429545127;
 Thu, 26 May 2011 10:05:45 -0700 (PDT)
Received: by 10.216.158.70 with HTTP; Thu, 26 May 2011 10:05:25 -0700 (PDT)
In-Reply-To: <BANLkTi=FkK=k6OavQtqMRvPCZ7nc+iKtwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174548>

Hi Junio,

Ramkumar Ramachandra writes:
> Jonathan Nieder writes:
>> And with that, this would no longer depend on the (valuable enough on
>> their own terms) patches 1 and 2 so they could be treated as a
>> separate series, no?
>
> Yes, but I'd like to keep 1 and 2 in this series, if that's alright.
> Another series will have to take care of error handling more
> extensively.
> With a few tests, would it be useful to get this series merged in? It
> implements '--abort', which is already useful.

There's a good way to create a separation between patches 1-2, and the
rest- thanks to Jonathan's suggestion on IRC.
Junio: Would you like to merge just the first two patches? I'll
continue working on the rest, and try to come up with something useful
to merge in another week or two.

-- Ram
