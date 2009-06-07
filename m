From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Sun, 7 Jun 2009 10:10:04 -0400
Message-ID: <ca433830906070710k61705903ydf985d198e9ea318@mail.gmail.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	 <ca433830906041944s1a2b12en36eb88b23cb93a7c@mail.gmail.com>
	 <85647ef50906050120p6dd65b61g9e82b5c14b098246@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 16:10:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDJ4g-00014z-KW
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 16:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbZFGOKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 10:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbZFGOKF
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 10:10:05 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:53288 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbZFGOKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 10:10:03 -0400
Received: by bwz9 with SMTP id 9so2506092bwz.37
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 07:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gTC67ol4caTP0qR06/4Z8YmBLpuxoQaA3CQRGwzpxSQ=;
        b=HD4QVUL6lYrIREgvup4eKQMSPO/MHvkShhCqvXZ/d2oPKO1ENjC/NyutxDlsKAy4qf
         rrdhPhFPELvymTRLnNDPDDCX03I9Ai+BpvZ3zUrcqLuqD7BOUpE9kFhOXCajDOaMMGMK
         jw47x/WVYg5WYZhR+psbOfLNBpisf7B6aRjTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JnBMMuZ3UTPbxJ5hAaz+3yqzzPyXqZ/I7sweCyy3E7j2qpxSdId8lBL17IWBnbw739
         Z1MxZaaJX7sxEZbT0/hOeL7fNjP5L1KoRQlj+3uw8+FoVHccQ946ajjW11lpY9u1lj5V
         j0xJV8Fm+wbsSpevoMzWc36h5hc5TE9QV0bs0=
Received: by 10.223.116.205 with SMTP id n13mr3054319faq.103.1244383804802; 
	Sun, 07 Jun 2009 07:10:04 -0700 (PDT)
In-Reply-To: <85647ef50906050120p6dd65b61g9e82b5c14b098246@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120973>

On Fri, Jun 5, 2009 at 4:20 AM, Constantine
Plotnikov<constantine.plotnikov@gmail.com> wrote:
> How it works if git is run from IDEs (no tty will be available)?

Then this will be no worse than the current situation, which also uses
standard input to prompt for the password.  Note that a TTY is also
required if an HTTP password is requested.

> Is there a way to redefine the way the password is got?

No.  This may be nice, but it would be much more complicated to implement.

> What about scripting scenarios where passwordless certificates are
> likely to be used?

If you wish to use a client certificate without a password, then you
need the second patch in this series, which adds an option to disable
the password prompt.


Thanks for your input,
Mark
