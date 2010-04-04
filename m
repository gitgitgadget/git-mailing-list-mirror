From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git-Automerge
Date: Sun, 4 Apr 2010 22:30:15 +0530
Message-ID: <z2sf3271551004041000yaba616fbu20701cd505c5dbf7@mail.gmail.com>
References: <w2j1f05046e1004040947k3b812063ndbc2f8da3496effb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Nico_Sch=FCmann?= <nico.schuemann@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 19:00:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyTBj-0005jC-Bl
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 19:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab0DDRAi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 13:00:38 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:57232 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab0DDRAh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 13:00:37 -0400
Received: by ywh2 with SMTP id 2so2131233ywh.33
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RPO3TwplLqjVXiWOm/5F1YcnlazpPF8nVTq9srQ/kiI=;
        b=N+z3uK08HPuTMOg0TRyDQTDKJMXk39EinY+SsQYQwPwLtXZkdKvHWj4pwOCyEdrnJO
         H7dhZtsuRS0zp41Xm6eUG9jLnC5eu+UqNDfaaHyvruzmOwFd0pt2KdJCPpb0kgxW6PWx
         KYF7XURql24yfHv54Gk0N0NMmWyGaKYYpZTeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=m/ugIDjs5/3KiynV1ectQu3Y+4tgyUeZeD6JJfunZXaqCNOH0ALa+eGujAHF2xMB7q
         I3jI6lGBOebbinsfLrroe96gnjTtXsckVt2dFcylbkh+aVliEZShvFrVgNPed8QKZLgr
         edlxZ+cppUbbVemXohN2OBvNKnesT2eX/SRI0=
Received: by 10.90.69.14 with HTTP; Sun, 4 Apr 2010 10:00:15 -0700 (PDT)
In-Reply-To: <w2j1f05046e1004040947k3b812063ndbc2f8da3496effb@mail.gmail.com>
Received: by 10.91.129.4 with SMTP id g4mr662172agn.11.1270400436155; Sun, 04 
	Apr 2010 10:00:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143933>

Hi,

On Sun, Apr 4, 2010 at 10:17 PM, Nico Sch=FCmann
<nico.schuemann@googlemail.com> wrote:
> $ git push
>
> But the changes do not appear on the master server. I have to type
>
> # git reset --hard=A0=A0=A0=A0=A0 or
> # git checkout -f

git-push only propagates history and updates refs. It doesn't touch
files in the working tree. I suspect you're pushing to a non-bare
remote. Please see --bare option in git-init (1) and this FAQ [0] on
the Git Wiki for more.

[0] https://git.wiki.kernel.org/index.php/GitFaq#Why_won.27t_I_see_chan=
ges_in_the_remote_repo_after_.22git_push.22.3F

-- Ram
