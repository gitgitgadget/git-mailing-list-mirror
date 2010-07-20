From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: Run git from .bat file (Windows)
Date: Tue, 20 Jul 2010 13:34:33 -0400
Message-ID: <AANLkTik-Mk0pMKWHqzMXUcSzPexAQd2bTAPZF9Q2WKer@mail.gmail.com>
References: <0vy6d6nmcc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Markus Heller <hellerm2@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 19:34:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObGiK-0002UJ-2M
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 19:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab0GTRek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 13:34:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44499 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757285Ab0GTRei convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 13:34:38 -0400
Received: by fxm14 with SMTP id 14so3012766fxm.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=HFIYRXSWL2Tz+ltCD7wI60ctfMu05dEXQKV+OREiiZ4=;
        b=R4XT/quEhmakSOGFxVL1X1zAbB2rb3Fl6y6eRV2EebJb5RGV9qLc0bfZvuNPWN01EX
         agcRtmFrDKWA1hrt3q4JL/m4AZTliMYBQA4zT12g4Q+VUxjU1+MW9LkXpd0kuB5k6aq4
         /sdLh0qny8grK/eyU1QOh1W425SjEM6CXnHfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=aE6FRQmpDVZNSdEBb2fTOMhvv4psylRMflZFnFmZK6UJJa71eePW/EYincbbfDW1nv
         7mxgXaKIpunZy8zcAAqgQWN8IaKAlcbMlhybVye+nQhSKWTZpY62FxWfYMg/eW/GFoso
         S+iszDvjm/at/ii6G1pJwuJiC4sQOuzcFtKmY=
Received: by 10.216.176.83 with SMTP id a61mr5629238wem.47.1279647273767; Tue, 
	20 Jul 2010 10:34:33 -0700 (PDT)
Received: by 10.216.160.85 with HTTP; Tue, 20 Jul 2010 10:34:33 -0700 (PDT)
In-Reply-To: <0vy6d6nmcc.fsf@gmail.com>
X-Google-Sender-Auth: MvG9D5j0kCk-LY3aMtHhBG3RLtA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151335>

On Tue, Jul 20, 2010 at 12:34 PM, Markus Heller wrote:
> git add .
> git commit -a -m "Automated commit by org-git-sync.bat on %fvar%"

> The line "git add ." works, as I can see the additions when I type "g=
it
> status" after executing the script. =A0Committing doesn't work, howev=
er:
> "git log" shows that no commit was created.
>
> Any idea what's going on?

git itself is wrapped by a batch file on Windows. You need to "call" it=
=2E eg:

call git add .
call git commit ...

("call /?" for more details)

Peter Harris
