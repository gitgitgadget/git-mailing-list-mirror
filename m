From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: patch for git-p4
Date: Wed, 5 Jan 2011 22:31:24 +0100
Message-ID: <AANLkTimdMH_HcF-Qk3SSmqT24OgxynYnXpSLiDtU7Y6c@mail.gmail.com>
References: <AANLkTi=sNsDy9oo0iBE-qJwvFSDMFYma3oYhbP1J-th=@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andrew Garber <andrew@andrewgarber.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 22:32:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paaxb-0000QM-La
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 22:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243Ab1AEVbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 16:31:47 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60898 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1AEVbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 16:31:46 -0500
Received: by fxm20 with SMTP id 20so15473647fxm.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 13:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=+fdN/MLlwdfx+f19pZWpfvToSFtuOXn9dnej7L0emn4=;
        b=n/fSonNfPwpv3TCJlrC3LLJrmsjZlAQ3clSNFwV+dZZmxFaqpP/Pl2NN/oEM7bhPKr
         abl/PbCP8/FIflf3yvQ7hL6TYhLDKOxdUgcQWwxBFXTdpgyhgqS/h1sIiyUILfH7hF9J
         PTJgH311sJur5Sg3q48awTh5pLXxwu+w99OMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=Ie29H+2gFOdZqsCBqUGxBbrak6nbaoFzlr6Z8b9WMqHQcM1knVy5Cq5pbEkkfRcpmX
         S6470LbG/LDiwE4pBsCh4gF0gnyuv3tvTCfg16SEHRm5wVgd26hciCzkuxenywAFNPfB
         0u0LPlRoClKrkMf/np9FM5Vl1BImestxdiiA4=
Received: by 10.223.86.193 with SMTP id t1mr744156fal.147.1294263105121; Wed,
 05 Jan 2011 13:31:45 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Wed, 5 Jan 2011 13:31:24 -0800 (PST)
In-Reply-To: <AANLkTi=sNsDy9oo0iBE-qJwvFSDMFYma3oYhbP1J-th=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164599>

On Wed, Jan 5, 2011 at 2:45 AM, Andrew Garber <andrew@andrewgarber.com> wrote:
> Hi everyone! This is my first post to the git mailing list.
>

Welcome!

> I was reading the git-p4 source and noticed that some of the lines are
> indented using tabs instead of spaces (very bad in Python). Here's a
> patch against tag v1.7.4-rc0 (commit
> 01b97a4cb60723d18b437efdc474503d2a9dd384) of the git source repo.
>
> Thanks!
> Andrew Garber
>

Please read Documentation/SubmittingPatches for the correct procedure
for submitting patches. The two most important things is:
1) We send patches inline instead of attached (git send-email can do
this for you)
2) You need to add a sign-off

As a side-note, your commit message has some broken grammar in it.
"Some the commits", I'm guessing you omitted a "of" there?

We tend not to write commit messages in past tence. E.g "git-p4:
replace tabs with spaces" (notice that I removed a 'd').
