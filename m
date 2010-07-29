From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What is the scenario for a commit with 3 or more parents
Date: Thu, 29 Jul 2010 12:55:18 -0500
Message-ID: <AANLkTik-wOB-iEGK8EnW1Rdk9wwc1E86tYoBU26WepYJ@mail.gmail.com>
References: <AANLkTikMRa_LrD2fU9Piv3GW2H0r7Jf_9s5iM0wc9t6s@mail.gmail.com> 
	<20100729021946.GG25268@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bradley Wagner <bradley.wagner@hannonhill.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 19:55:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeXKc-0004bV-6d
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 19:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab0G2Rzk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 13:55:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59497 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab0G2Rzj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 13:55:39 -0400
Received: by ywh1 with SMTP id 1so205415ywh.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PTco5il5/zDzDYke/QnMlmIxOwmpItyDIyHc/c/dJT8=;
        b=Fv6BZdbOwaBCvRkX1+bsMa9KCrSS5qIeBah8S+hxcRpy6xpoMS2XZxe7j151XxAdfT
         FNx4UgC3f354sCcUSVNtwYUgMBOk6MVUBEFQoH5emugNk05tuALFZgoKbTVY13qN3/tj
         0Ath/eKLugrZWs7PxFLdwdDmpUs5iPjJdaQJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gcy+/n/YkFB1vXWSDeqIvpz9XqL0Vfj/ogNecfc32rXvWOaymvW6SKeO3j9mGVRTcv
         fhTgmGFM5dXGVDUmPbol1UfBJq/eGFEGu/nVSsPQ3+rat0FMMnL9jMwVUG9ttB7qlvLq
         yIQhS0s2bS/UbkS48n96VfNv147ZwbQ9RTmAI=
Received: by 10.150.170.15 with SMTP id s15mr1504892ybe.400.1280426138209; 
	Thu, 29 Jul 2010 10:55:38 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Thu, 29 Jul 2010 10:55:18 -0700 (PDT)
In-Reply-To: <20100729021946.GG25268@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152189>

Heya,

On Wed, Jul 28, 2010 at 21:19, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> Yes. =C2=A0Its called an octopus merge. =C2=A0It happpens sometimes w=
hen
> merging 2 or more otherwise fairly isolated changes in a single
> shot. =C2=A0E.g. `git merge feature-a feature-b thing-c`.

Do we have an explanation anywhere as to when one would use a octopus m=
erge?

--=20
Cheers,

Sverre Rabbelier
