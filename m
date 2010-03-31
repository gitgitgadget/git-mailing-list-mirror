From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v3 0/2] git-gui: change to display the combined diff in 
	the case of conflicts.
Date: Thu, 1 Apr 2010 07:52:44 +1200
Message-ID: <v2z2cfc40321003311252s86d44ad7l540559eafb0636d4@mail.gmail.com>
References: <2cfc40321003300834w59532e58m13d42acce4f2c5ce@mail.gmail.com>
	 <4BB2F7A0.6020702@viscovery.net>
	 <k2p2cfc40321003310412hf4c6d642n4349af3f644829ff@mail.gmail.com>
	 <4BB3346C.7070700@viscovery.net>
	 <t2u2cfc40321003310523u8fda9baeo883d2e0b3c6fa807@mail.gmail.com>
	 <4BB3534E.3080803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Mar 31 21:53:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx3yP-0004Mo-1A
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 21:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757562Ab0CaTwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 15:52:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56329 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757482Ab0CaTwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 15:52:45 -0400
Received: by pwi5 with SMTP id 5so488239pwi.19
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type;
        bh=X3fVWMiDZDVq7wXGWOSdZM6kPOc6mFivV+1fTE36OuY=;
        b=Lv7bn4iWux5AsmGmR88ZuQr3gHCP8vIddWoo+i6qo8ptzrRRoywt6/epO4y4ykSMj9
         veNzCBGvT3PCIIs+otQaaxiAS744SVrM35FWHkUJEohrz1yx4L2zLq1clIF6mQ1SzG9x
         bGLGQ3rAB6tUo6cv0FWbCkWy/yPkbGHN6H78U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=lBqBDY1jgodb+5cUHRkniOz6SkynMkzzTtYBL3sF5CRGpQHNzC9f6D30Zu/l6aQoKQ
         cNVCI/iVDR++xfik4iYjj5t1XfAficJDCpYxGwE1pzJ6HqcAjj94/7FhLzQOIP8jloOb
         oeimtB//P8XenDRIkc3z235PjSbNfQdE4+JzU=
Received: by 10.114.13.5 with HTTP; Wed, 31 Mar 2010 12:52:44 -0700 (PDT)
In-Reply-To: <4BB3534E.3080803@viscovery.net>
Received: by 10.114.164.19 with SMTP id m19mr323435wae.152.1270065164523; Wed, 
	31 Mar 2010 12:52:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143693>

| apologies - missed the list

I agree that removing the options is better than preserving the
current behaviour,

My argument is simply this:

That it is better to inform a user that an action is potentially
dangerous than to "protect" them from
a "scaring" amount of diff -c output by presenting a conflict-only
summary. You claimed this output was "uninteresting" and hence should
be suppressed, my point was that supresssing output because it was
"uninteresting" is a dangerous thing to do because it is relevant to a
decision not to act.

My preference for options are:

* preserve the actions, but provide more information to the user
* remove the actions
* preserve the actions, make the safer output the default and enable
the simpler, more dangerous output as an option
* preserve the actions, make the current output the default and enable
the safer, less dangerous output an option.
* do nothing

We disagree about the relative order of options 1 and 2. But
seriously, if you agree the actions are dangerous I can't see how you
can argue that is preferable to suppress the scary amount of diff -c
output.

I would imagine that a change that proposed to remove the actions,
without an option to enable them, would encounter stiff resistance
from the list. However, perhaps the list can respond?

jon.
