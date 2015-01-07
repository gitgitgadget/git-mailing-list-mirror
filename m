From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Probably a bug with "~" symbol in filenames on Windows 7 x64 in
 git 1.9.5
Date: Wed, 7 Jan 2015 15:35:30 -0800
Message-ID: <CAPc5daVddkaMkx=43nCeQKbbkrV6nExOqvEBJNyugzDQB2n6kQ@mail.gmail.com>
References: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Dmitry Bykov <pvrt74@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 08 00:36:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y908p-0000eR-9U
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 00:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437AbbAGXfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 18:35:51 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:53911 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826AbbAGXfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 18:35:51 -0500
Received: by mail-oi0-f51.google.com with SMTP id h136so5154286oig.10
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 15:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hSoD1ASAdbT+/Q0RqUJJropLNewgbi5tLULs+TVDrqU=;
        b=fAyoZ4tTDT2sMpFF0ik/wKLFpEwIyG/WmZ3asoEfsIxYLdEIq9dE/nlWWdTfcFLpaB
         jms4pSH1pwTKPvDl0jvBV7B84wkeEddBJaBEg8g34p/lfYDdGGMxnoCAibTqsxwMRkXN
         0+BzYfrDzqJZjb4fn+hfETaa1E5hOa34phk6j+MpHDBWP1y6EnX3DAyUMQVYs77JgGcW
         yXS39yQCqMFtJejgx4zSSBIoiARVhUNwtFkrOP9Nxki/8LYiaaQLhhG3juoAb7BKXArf
         Ezuc6M65yFVjGmc2TNN1zoo0S3cwqI8yPu1G+eclBkJZq3m7LJvaPhITJEcwTQThSpzQ
         HIGQ==
X-Received: by 10.182.148.229 with SMTP id tv5mr3768704obb.41.1420673750418;
 Wed, 07 Jan 2015 15:35:50 -0800 (PST)
Received: by 10.202.213.140 with HTTP; Wed, 7 Jan 2015 15:35:30 -0800 (PST)
In-Reply-To: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com>
X-Google-Sender-Auth: xPLeisuJdJhQS0eKQxyR_u_STRA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262168>

Dscho, this sounds to me like the additional "8.3 ambiguity
protection" (which is only in Git for Windows) in action. Any
thoughts?

On Wed, Jan 7, 2015 at 3:26 PM, Dmitry Bykov <pvrt74@gmail.com> wrote:
> Hello,
>
> Recently I installed 1.9.5 git version and faced the problem that one
> of the files in my cloned repository with a name ICON~714.PNG is
> marked as deleted even repository was freshly cloned. Trying to do
> anything with that file resulted in constant "Invalid Path" errors.
> Reverting back to 1.9.4. fixed that problem.
>
> Thanks,
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
