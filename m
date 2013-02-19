From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] Introduce branch.<name>.pushremote
Date: Tue, 19 Feb 2013 14:57:47 +0530
Message-ID: <CALkWK0kBjsHtK1_7imJx-7CATSKFzpUgGzH6Hs9DAQ8c7jRUPw@mail.gmail.com>
References: <1360307982-20027-1-git-send-email-artagnon@gmail.com> <CAGL0X-rKnWBy-Ff=YmEdqgo8RFb40FXTxvUM5X77YaQvhAGHYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Blind <stoycho.sleptsov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 10:28:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7jV4-0001bQ-BB
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758483Ab3BSJ2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 04:28:09 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:40231 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758357Ab3BSJ2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 04:28:08 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so8272807ieb.34
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 01:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ar6EdzzrjEHRi8iyjvPZ0jfpQY6HQ6q6MD0Qkm4/B38=;
        b=pbbhWUAraSLr/7PwzWlVtCt+GYInIsHWDJ+ZJR5Tb4RY/VTdWMBqziQHF6BUMSiVMU
         bX5FmnfkClq4o0aX+dej4dzZV1oY2F1AsNbr81+OdOOyHXH62Bb0LD19TjYi0I8aH4AY
         VjIKB7xVvfQJRCfJ949KXuuZICIE4jVbWgXyjJDcdrCWP16TgLKWF3WAaQ0F8XZqk73l
         13fnjaepulMuVf/a8c+KiyHKeKtv1msaJ75CDTA8RIdnla8XljrqbcvCcEYonm+IW/Ih
         HZS2EFPmRgmA+JikN+qtQOEIAtHrlXzelJSNGdQMP6IgzYRambTEeDYqR+NkVbv/3rjG
         waiA==
X-Received: by 10.42.18.138 with SMTP id x10mr7266894ica.22.1361266087528;
 Tue, 19 Feb 2013 01:28:07 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Tue, 19 Feb 2013 01:27:47 -0800 (PST)
In-Reply-To: <CAGL0X-rKnWBy-Ff=YmEdqgo8RFb40FXTxvUM5X77YaQvhAGHYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216580>

Blind wrote:
> If I understand correctly,
> in your scenario the branches with branch.<name>.pushremote
> will be still included in the $git push <remote> --all?

Yes, this is correct.

> Are you considering some way to exclude a branch from "push --all"
> (branch.<name>.push = always, explicit, never... for example)?

No.  I don't see why push.default is limiting.

> Or maybe, if the branch is already marked as special
> with branch.<name>.pushremote,
> then it could be logical to push it only when is explicitly specified
> on the command line (excluded from --all)?

Huh?  Why would I treat this as a special case?
