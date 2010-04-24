From: Miles Bader <miles@gnu.org>
Subject: Re: 'commit -a' safety
Date: Sat, 24 Apr 2010 22:29:57 +0900
Message-ID: <k2vfc339e4a1004240629sd0249654u17e5df1b3a77bff2@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<m3633hdw9u.fsf_-_@localhost.localdomain> <87fx2li36m.fsf@catnip.gol.com> 
	<201004241226.34884.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 15:30:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5fRA-0003MV-N9
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 15:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931Ab0DXNaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 09:30:19 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:51412 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab0DXNaS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Apr 2010 09:30:18 -0400
Received: by pxi17 with SMTP id 17so1162226pxi.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=JzK+zdqh0SRJML7A3XOGDit7qf2WxiVNChsUVW/XZOg=;
        b=ui6KP/vnCpxT/XZRWlPZu5UgV6rCOBbJ5bTYTdQYSPgQra8IaAhBukhLBcbA8sU2CP
         hqT+7enzg/ATcm5sG3R5MlulPqXCSSB+cZL19D/nfao/1oMY6MQeNEHnieuq+xoC/OXo
         9t8qH5gnIkC+lcc8jZiQBhWULLURpeTirPjbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=l50buJy0LVnSDsUKLnUaMXCfILbdrz4Y5zmgqTkn688pZNKLwjMQqe5t2fabcE6Q4R
         SWfPrb86NmhZ8JsFNOTN6IqhVirst8x95dZbTWof1ZL1rhRjvNRvd4LdPu3xq23dK1t6
         JfLtXOEY8ik1N9sp3mtBYtZ0rfb9tG8qhP4XU=
Received: by 10.142.119.33 with SMTP id r33mr728616wfc.213.1272115817119; Sat, 
	24 Apr 2010 06:30:17 -0700 (PDT)
Received: by 10.142.14.3 with HTTP; Sat, 24 Apr 2010 06:29:57 -0700 (PDT)
In-Reply-To: <201004241226.34884.jnareb@gmail.com>
X-Google-Sender-Auth: 478bb105c1c22fdc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145674>

On Sat, Apr 24, 2010 at 7:26 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Third, there is "git add -N" to mark file as tracked, but not add its
> current context.
>
> =A0$ git add -N file
> =A0$ edit file
> =A0$ git commit -a

Meh.  It's going to still require people to change their habits, and
while requiring people to use -N whenever they think they may want to
use "commit -a" later would work, it feels awkward and artificial.

All in all, it just doesn't smell clean, and I suspect that would
prevent many people from enabling such a feature.

-Miles

--=20
Do not taunt Happy Fun Ball.
