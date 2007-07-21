From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit: failed assertion involving unapplied stgit patches
Date: Sat, 21 Jul 2007 09:14:36 +0200
Message-ID: <e5bfff550707210014x6bff8ff3wfa8da67077f28365@mail.gmail.com>
References: <OF2EB5CD3A.5A6F9DF7-ONC125731E.004BD62A-C125731E.004FCEC9@sagem.com>
	 <e5bfff550707201045s270e0ae1p206ad62cd02ebea4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ydirson@altern.org, git@vger.kernel.org
To: "Yann DIRSON" <yann.dirson@sagem.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 09:14:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC9Az-0007C8-4F
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 09:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbXGUHOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 03:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755978AbXGUHOi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 03:14:38 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:51092 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603AbXGUHOh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 03:14:37 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1264598wah
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 00:14:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PcSKFH05u3VRWEeHN2aizy0EWC5KfGOsRMtIQfMlblfm2jLoIDmZaYbXpghFfHAqB9bKnVoDAciQYGZLDIVp7BMtWrWPlzubNHQJI/rnH9wJ3cPfgSZgSp7hMepNcbqOx5d0wuiHVkpIzI05FT41MiG4pM9oYXQcmuAvNMBInJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gj+H4sMyhq8hZP8EKu8JHgybR9qv8mLL8vBX6H1v80K1i7r2iMA7oP4RYIa/KFjN0KRbecADfsPEh3Yv7jMEXNO5RQdFODwHdUQYKWK2RWX9RUtyI171JCZI89RCdZE8l3850kx8b5tHf3YNUOjdWe654pYzTk4lLtbGTk/HSNc=
Received: by 10.114.13.1 with SMTP id 1mr1172250wam.1185002076737;
        Sat, 21 Jul 2007 00:14:36 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sat, 21 Jul 2007 00:14:36 -0700 (PDT)
In-Reply-To: <e5bfff550707201045s270e0ae1p206ad62cd02ebea4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53150>

On 7/20/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 7/20/07, Yann DIRSON <yann.dirson@sagem.com> wrote:
> >
>
> Regarding to show unapplied patch it seems a little bit difficult
> because git-log /git-rev-list does not know them, after a quick look
> it would seem easier to me to show applied patches as such...I will
> investigate.
>

Yes, it was easier.

Pushed a patch to show applied patches with nice green '+'.

Thanks for bug reporting
Marco
