From: Carsten Mattner <carstenmattner@googlemail.com>
Subject: Re: [PATCH 0/2] completion: backwards compatibility fix
Date: Sun, 20 May 2012 11:02:35 +0200
Message-ID: <CACY+HvqhJf6ywTaDgT5ie-3iBQAGwngTYPiCvKgw6mJB=1+fOg@mail.gmail.com>
References: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 11:02:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW22E-0004yi-QU
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 11:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab2ETJCi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 May 2012 05:02:38 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:44327 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab2ETJCg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2012 05:02:36 -0400
Received: by gglu4 with SMTP id u4so3741034ggl.19
        for <git@vger.kernel.org>; Sun, 20 May 2012 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fi6GIHrd5KbEQZ9ASZXQKH/0iKRWFR3PbHufzLFS56Y=;
        b=Z5kSqtTXpy2huKPSQJqqBKXmb3SqBkwvlEywDHM86nBfx9BI+736LdlGxwxvmz0hG0
         W22hYIO5jmxn61tMhzmzQlfol+zfCRhzQhYVvX1AzmWdXwfMhQOzvY6zwcJJNy5bCIbg
         aooAVLYlVSG4/KbfjYhauwtFE3eHtCq0a9ZghYlER1HCSczM+JDVgUqB+fwSo+MGmmDf
         2lJu5FHeFYFbWxi0D1w0n2k1Hwl/u3RI4s9quANgZPhIPq1gFjME/u2yJ97JRqqZ50se
         +KVAJWF4SRiMYX7ROdriDOji3FmCaAA/Tahqg8qY/PgoxqnXscIYhEMC774URXB2WHYH
         Z6yw==
Received: by 10.42.19.138 with SMTP id c10mr5704827icb.27.1337504555428; Sun,
 20 May 2012 02:02:35 -0700 (PDT)
Received: by 10.50.6.231 with HTTP; Sun, 20 May 2012 02:02:35 -0700 (PDT)
In-Reply-To: <1337395295-29162-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198053>

On Sat, May 19, 2012 at 4:41 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> These two patches are meant to fix the backwards compatibility of _gi=
t, and
> _gitk. This also helps my zsh's wrapper.
>
> Felipe Contreras (2):
> =A0completion: rename _git and _gitk
> =A0completion: add support for backwards compatibilit
>
> =A0contrib/completion/git-completion.bash | =A0 22 +++++++++++++++++-=
----
> =A0t/t9902-completion.sh =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
> =A02 files changed, 18 insertions(+), 6 deletions(-)
>
> --
> 1.7.10.2
>

Thanks Felipe. With the 2 patches applied all the following
completion definitions work.

complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
   || complete -o default -o nospace -F _git g
__git_complete g _git
__git_complete g _main_git

Ignoring backwards compatibility, which one would you suggest
I use? Keep in mind that I originally copied the first
long completion defintion from git-completion.bash a long time
ago.
