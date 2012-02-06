From: Adam Mercer <ramercer@gmail.com>
Subject: Re: git describe relative to a given tag pattern
Date: Mon, 6 Feb 2012 16:18:06 -0600
Message-ID: <CA+mfgz375mQUao8nF6dJYzd0_ui==25zKFj51fV5d9eEWrzc6Q@mail.gmail.com>
References: <CA+mfgz0VB9qMHHtoT76zCOiUaH=8egdMDrneQVRBug2waQsGAg@mail.gmail.com>
 <7vhaz362b8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 23:18:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuWtf-0001RP-Fp
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 23:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab2BFWSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 17:18:47 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57442 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab2BFWSq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 17:18:46 -0500
Received: by pbdu11 with SMTP id u11so5342701pbd.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8nGmyBesfd/XeYpe+72zSWsPE8TJmgSBsQf1KWnrFcU=;
        b=ORUMaVXZWMZDMkYmqbwAesA13e4pELLjQ8Lmlzz/LI4Pa7rLvA69gMndDFCPLKkqCN
         gwVsW0rWW9gmcUk7YNWNSASKx3UnnaZ6uIFhoU5Dnqis2XF2mq5Or16kV1WRpvqru4tQ
         XIWnuyT0zJLQDjXaFA0yGNzNUzrZUsThdlWbI=
Received: by 10.68.238.136 with SMTP id vk8mr51039438pbc.14.1328566726156;
 Mon, 06 Feb 2012 14:18:46 -0800 (PST)
Received: by 10.68.232.170 with HTTP; Mon, 6 Feb 2012 14:18:06 -0800 (PST)
In-Reply-To: <7vhaz362b8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190114>

On Mon, Feb 6, 2012 at 16:10, Junio C Hamano <gitster@pobox.com> wrote:

> Perhaps Git is correct and your HEAD is not a descendant of any tag whose
> name matches the pattern "lal-v*".

Thanks you're right, the tags I was trying to match are on a different
branch. Back to the drawing board for this script.

Cheers

Adam
