From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Why do some commits not appear in "git log"?
Date: Tue, 2 Aug 2011 15:56:29 +0000
Message-ID: <CAMOZ1Bt+Z4XDPNBQyUeVk30aEOuXFAuh8jhdhFke-CDZt2pEDg@mail.gmail.com>
References: <CA++fsGGG7pLt4xoeJozGnYEwOrs6NuzStYPKF_L5k49uzFB-4A@mail.gmail.com>
 <CA++fsGEht+UDp9EnFyfvn-uT1DYPcnhpwmPy_H4PTWvsvUceAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dov Grobgeld <dov.grobgeld@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 17:57:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoHL7-0000UL-HF
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 17:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab1HBP5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 11:57:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41004 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab1HBP47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 11:56:59 -0400
Received: by iyb12 with SMTP id 12so8188597iyb.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=teLyS5KLpRtQtqzGrFFIPgaKxRLdvCzAiGIroB4H/Es=;
        b=mS35Iqb/V+dhMoyqDMTae0WpAqIBIQI/dI8hUMDbP/UHMW0CisVD6PZ3GEYRiu2MH0
         ucZaN4cyDJ/EMrZJzhBQ8sM2hfbdITQWMdarb9Rs4eXGMs9RiHaRU0SPMaBqfZfeWyNU
         O0oIFNPvRkWWmvqYAJPARwdwbzVn+vQjIs8zE=
Received: by 10.42.154.199 with SMTP id r7mr3830342icw.145.1312300619179; Tue,
 02 Aug 2011 08:56:59 -0700 (PDT)
Received: by 10.42.167.137 with HTTP; Tue, 2 Aug 2011 08:56:29 -0700 (PDT)
In-Reply-To: <CA++fsGEht+UDp9EnFyfvn-uT1DYPcnhpwmPy_H4PTWvsvUceAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178479>

On Tue, Aug 2, 2011 at 15:38, Dov Grobgeld <dov.grobgeld@gmail.com> wrote:
> git log --pretty=oneline --abbrev-commit | head -20

Try `--full-history' maybe? Also, rather than `head -20', you can
limit the output directly with `-20':

  git log --pretty=oneline --abbrev-commit --full-history -20

It's hard to know what's going on in your particular example; perhaps
give us the output of `git log' when using the `--graph' option.
