From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to split a big commit
Date: Mon, 4 Apr 2011 19:08:52 -0500
Message-ID: <20110405000852.GA1704@elie>
References: <BANLkTikFXzut7fY5Tr0u-abu5Q0rMUOCmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 02:09:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6tpf-0005ho-MK
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 02:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828Ab1DEAJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 20:09:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35210 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1DEAJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 20:09:03 -0400
Received: by gwaa18 with SMTP id a18so2378877gwa.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KosU+vb9xN6BlifPUXcBJcchOT+GP5dRY/ylsFp+xQ8=;
        b=fx+SmQHIKP7NOu/umV9oPaPqFsIw8A1rEv41TP79ysjl52FBZUx3cYe3kKmZ6AxAoO
         YFId3VfiHcPxa3OyjorL4DfUZFxWKu45irlyVQlWqqhi6izPH8yDkBAs1oOz3I1WZ/z4
         LO/BrGbPk11k4RciIbEoTouSfPv97Th2f6gM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qrElX1vMZtpoCnEDsiBrmQq5sMyrmpiwoXDuOJw17TMsEs2Z8y8+azA9X+hTYxNYYQ
         q42uadsJi8f4MRDzqJWDd4DzB9rszegwgpsnl34D9CyL8OE7A1Qqtz6geLFgl0fD7QqY
         iKPT8U0O3v3JEudg8fCJ0GlnHKiBtJS62QSiU=
Received: by 10.236.73.137 with SMTP id v9mr261241yhd.391.1301962141690;
        Mon, 04 Apr 2011 17:09:01 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.ameritech.net [69.209.53.77])
        by mx.google.com with ESMTPS id x50sm2578496yhc.18.2011.04.04.17.08.59
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 17:09:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikFXzut7fY5Tr0u-abu5Q0rMUOCmA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170849>

Hi Duy,

Nguyen Thai Ngoc Duy wrote:

> After a lot of small commits and a few mixed up large commits, it was
> too messy that I merged them all into one big commit then started
> spliting it into smaller, reasonable patches. Just wonder if anybody
> else faces the same thing and how they deal with it. I used "git reset
> --soft <big commit>^" and "git add -N" because there were new files,
> but it was clumsy.

I tend to do "git reset HEAD^ -- ." and then "git add -N ." and
"git add -p", for what it's worth.
