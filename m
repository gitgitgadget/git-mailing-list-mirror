From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 1/2] hash-object: support --stdin-paths with --no-filters
Date: Sun, 14 Feb 2010 14:42:35 +0100
Message-ID: <40aa078e1002140542v6372b7daj712119830d119dcb@mail.gmail.com>
References: <1265997155-3592-1-git-send-email-kusmabite@gmail.com>
	 <37fcd2781002121037n4c98890eq5d635fc3bad5928a@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	normalperson@yhbt.net
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 14:42:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgekU-00085i-RK
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 14:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301Ab0BNNmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 08:42:38 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:61502 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab0BNNmh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 08:42:37 -0500
Received: by ewy28 with SMTP id 28so3406183ewy.28
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 05:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=rVzsVVdiibJF/bhl6ZgCv5B4qD7qS/cUQ/pFmw40NwA=;
        b=CVySB7Plr6B+XDMjWq3oDatkVemm7VV0Fkx1VhB7OwGAZ/+NKmG84hTQAvB/2ODgcQ
         5HxBvqnVGyB9UDjryZvsyA45nL6b2qBh/+y5DG1gLbUbBwDtU2syPvzPDHicEaWMmRYq
         zS0Tcp+ap3FUCr04WhqJSdd27NlNiOhCCT3P4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=NxAR3Sn/aA5vBC+D5TRyaUpdTMOlhBfv1IRGqCMH/bN8obFb32nzf0mDpCX2ARKIbY
         ebdGfm4rResOEnzHcaz985yOCKGphC9ZIHgUJYny0rzk84qOk/kmGr6zT0v/XRTetOG+
         XXNR6Wfmch3bF93RQCxVXeMbrBaE1cFB022TY=
Received: by 10.216.176.143 with SMTP id b15mr2343813wem.155.1266154955648; 
	Sun, 14 Feb 2010 05:42:35 -0800 (PST)
In-Reply-To: <37fcd2781002121037n4c98890eq5d635fc3bad5928a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139908>

On Fri, Feb 12, 2010 at 7:37 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> Hi Erik,
>
> I don't remember why I made --no-filters incompatible with --stdin-paths
> when I added it. So your patch makes perfect sense to me. However, I
> think you should correct synopsis in Documentation/git-hash-object.txt,
> so it will be clear that these two options can be used together now.
> Also, it would be nice if you add a test case to make sure that it works
> as expected and will not broken in the future..
>

Thanks. I've fixed the synopsis and added a test for the next round.

-- 
Erik "kusma" Faye-Lund
