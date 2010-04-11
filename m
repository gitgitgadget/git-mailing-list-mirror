From: Damien Tournoud <damien@tournoud.net>
Subject: Re: [PATCH] More flexible URL patterns for gitweb
Date: Sun, 11 Apr 2010 19:46:06 +0200
Message-ID: <r2te821df551004111046v2ef3219x5c012af27f2cc974@mail.gmail.com>
References: <1270946429-5366-1-git-send-email-damien@tournoud.net>
	 <m37hodhp3e.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 11 19:46:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O11Ef-0006Za-8x
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab0DKRqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 13:46:10 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47138 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab0DKRqJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 13:46:09 -0400
Received: by bwz19 with SMTP id 19so29684bwz.21
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 10:46:06 -0700 (PDT)
Received: by 10.204.24.136 with HTTP; Sun, 11 Apr 2010 10:46:06 -0700 (PDT)
In-Reply-To: <m37hodhp3e.fsf@localhost.localdomain>
Received: by 10.204.32.196 with SMTP id e4mr3237862bkd.131.1271007966727; Sun, 
	11 Apr 2010 10:46:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144666>

On Sun, Apr 11, 2010 at 7:33 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> To not break backward compatibility, wouldn't it be better to check i=
f
> elements of @git_base_url_list end with ':' or '/', and join base wit=
h
> project path depending on this condition, i.e.:
>
> + =C2=A0 =C2=A0 =C2=A0 @url_list =3D map { m/[/:]$/ ? "$_$project" : =
"$_/$project" } @git_base_url_list
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unless @url_list;
>
> This means: if base ends with colon ':' or slash '/', concatenate bas=
e
> and project path, otherwise join them using '/' as field separator.

Thanks for the review. Indeed this way sounds better.

All this is new to me so I'm not sure what is the way forward. Should
I publish another patch or would you?

Damien Tournoud
