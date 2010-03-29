From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v2 0/2] git-gui: git-gui: change to display the diff with 
	the HEAD in the case of conflicts.
Date: Tue, 30 Mar 2010 10:08:33 +1100
Message-ID: <2cfc40321003291608r2b6c7aaap797b4452985438e9@mail.gmail.com>
References: <2cfc40321003291600q70f0839bt8720dd025a3891f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Mar 30 01:08:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwO4V-00007z-JS
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 01:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124Ab0C2XIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 19:08:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54882 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab0C2XIe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 19:08:34 -0400
Received: by pwi5 with SMTP id 5so7157584pwi.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type;
        bh=axZ/ilS6cf7wYCS4xDybVGueOyhNt6OuXUeC1bKdK7s=;
        b=XBlPW1dVwuO+g9EABE3R315nyMY6kW5MCznCDRF0h+Znvjozwic/GSlSqR4lZGmMBa
         aLZVOHP4segqtEwKhQV3JMUFoivOoRheLoHHXJqnpkRhuCQ2Rf9kckDD9PgmeLxpvzLY
         Yx5uMygq4Z1uwY+SWMyLqbIdVHtfj4nVrsipg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=Ou5+s0AUKjDqI8wiJGpOcU8D2MKWRoV+vnKC3PSYqyjY5RhujG4lGAlYrzbvn9fdc/
         B2unTVx6NNXLmz7wVC+7vFhzFwgzMYt7cS4mUzW7jRenrZIDU8u8pHmSaPQQKYcZmbXp
         orE+dKEqydg18H/zlpuX9p/owIWrE8Nsuyj7o=
Received: by 10.114.13.5 with HTTP; Mon, 29 Mar 2010 16:08:33 -0700 (PDT)
In-Reply-To: <2cfc40321003291600q70f0839bt8720dd025a3891f6@mail.gmail.com>
Received: by 10.114.164.24 with SMTP id m24mr5967591wae.138.1269904113726; 
	Mon, 29 Mar 2010 16:08:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143530>

Apologies, it broke again.

The command I ran to submit the patch was:

   git format-patch -M git-gui-patch~2.. --stdout | git imap-send

I did with git 1.6.6.1, running on cygwin however this process appears
to be corrupting the patch.

Can anyone let me know what I have done wrong?

jon.

On Tue, Mar 30, 2010 at 10:00 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> Resending because my original patch series wasn't whitespace clean and
> I have now removed the configuration to make the safe behaviour
> optional - it is not safe by default.
>
> If there is any other reason why this patch should not be considered,
> please let me know.
>
> [PATCH v2 1/2] git-gui: Introduce is_unmerged global variable to
> encapsulate its derivation.
> [PATCH v2 2/2] git-gui: change to display the diff with the HEAD in
> the case of conflicts.
>
> jon.
>
