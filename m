From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 03/24] t7600 (merge): do not launch gitk for --debug
Date: Tue, 17 Aug 2010 12:50:03 -0500
Message-ID: <AANLkTi=1Fz_wdf-grxFB17zUXpW+d26MudbbJP5K=fO_@mail.gmail.com>
References: <20100817065147.GA18293@burratino> <20100817065459.GC22057@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 19:50:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlQIw-000708-Fg
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 19:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757919Ab0HQRuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 13:50:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55642 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819Ab0HQRuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 13:50:24 -0400
Received: by gyd8 with SMTP id 8so136618gyd.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=SZ6dw5GqRARhKZk+UIYVBvfmZGBC7pvtR0SHGyYlxzU=;
        b=kyWlUERDY68JXJsc7BLkweB+ZdNRK8WrTSHojT5/zWzsvhZoBomkT2ceb571wmYyXU
         VdnlqWPUGlEmkUFFt5/lCMwu+Am5Q4D6jZN+7Q1a5Yu2bXLJZv7JlkMfpLUJTHmdKWFe
         TuALGiiFIEcBYcnzlDfXeIbXFqOZQuEPetB1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=be6+aExdMWXjWTJRvmIAZSxS8irkenCP6b8yM6ETMpZeEkh4eQQWKbA0TL7gUEwzoI
         ce+DVvFFaNmG6JtZNL2YYBHsY03Jl3Gl2RTJKlNk5UPN4DBJOTmEUsNHzOAiSJshH4Ea
         DtP43HTQoKOeWLW7hWRPFWQlqIU8POcPqUpgw=
Received: by 10.150.138.19 with SMTP id l19mr7592288ybd.123.1282067423242;
 Tue, 17 Aug 2010 10:50:23 -0700 (PDT)
Received: by 10.150.98.8 with HTTP; Tue, 17 Aug 2010 10:50:03 -0700 (PDT)
In-Reply-To: <20100817065459.GC22057@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153769>

Heya,

On Tue, Aug 17, 2010 at 01:54, Jonathan Nieder <jrnieder@gmail.com> wrote:
> -test_debug 'gitk --all'
> +test_debug 'git log --graph --decorate --oneline --all'


> -test_debug 'gitk --all'
> +test_debug 'git log --graph --decorate --oneline --all'

> -test_debug 'gitk --all'
> +test_debug 'git log --graph --decorate --oneline --all'

Really? Why can't you stuff the command to execute in a variable? On
that note, why wasn't that done in the first place?! This kind of
repetition is not very DRY.

-- 
Cheers,

Sverre Rabbelier
