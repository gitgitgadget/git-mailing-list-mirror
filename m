From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the 
	SVN
Date: Sun, 29 Mar 2009 14:35:24 +0200
Message-ID: <fabb9a1e0903290535y59cd3a1fvd5a7d3476dff45bc@mail.gmail.com>
References: <22756729.post@talk.nabble.com> <1238276809892-2550565.post@n2.nabble.com> 
	<8c9a060903281504qd1b66hefb70e60c3f624d2@mail.gmail.com> <1238278694146-2550633.post@n2.nabble.com> 
	<fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com> 
	<1238323876827-2552153.post@n2.nabble.com> <fabb9a1e0903290403s2b0bbe1al57ac448a16d05070@mail.gmail.com> 
	<1238327564546-2552334.post@n2.nabble.com> <fabb9a1e0903290503g7ec0a37djd71ce8eba6220d70@mail.gmail.com> 
	<1238328537685-2552369.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jamespetts <jamespetts@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 14:37:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnuGH-00070H-Ap
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 14:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbZC2Mfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 08:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbZC2Mfm
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 08:35:42 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47844 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbZC2Mfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 08:35:42 -0400
Received: by fxm2 with SMTP id 2so1596991fxm.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1jIwaZ2M5lFjLkBPs9qINzcOpQabT48ONWa/JME0iLc=;
        b=auDjgzoJAXk/INiphkmBJU4uIYQfrsFKDPpuuwCWlH/DkxXAVRx7jjVT8D35t7VBiQ
         7naXfnlXfP1AXhAXXZiFB6sIIqsjP78KDBf4C0MYepAmEWv2OBjxwLUbNgmtGFmcFerS
         6OFXUndnVTOJFWwsoPYr8froDJ++2wKYJ6n9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CFeCEcAjffdENTAf7OGTYl5YnjWpiOO/26L9PZYB0hnwkPserHcC7ERgFbmBEoNES3
         /LRockf2NtkFHeyKvFB4ckRCuPGNWzGfXBx/z8FdAOnqtZfVcYizAN7h60+3rRsVygq8
         lRtwXabHpfjQOJZfq/6CAGggSMBw25SoCoXG0=
In-Reply-To: <1238328537685-2552369.post@n2.nabble.com>
Received: by 10.103.240.15 with SMTP id s15mr1211349mur.93.1238330139199; Sun, 
	29 Mar 2009 05:35:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115024>

Heya,

On Sun, Mar 29, 2009 at 14:08, jamespetts <jamespetts@yahoo.com> wrote:
> "fatal: ambiguous argument 'trunk': unknown revision or path not in the working tree.
>
> "use '--' to separate paths from revisions".
>
> What am I doing wrong this time...?

You can do "git branch -a" to see which branch name git svn uses, it
might be 'git-svn', it depends on which version you're using I think.

-- 
Cheers,

Sverre Rabbelier
