From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: about crlf file-encodings and other options
Date: Thu, 16 Jul 2009 11:49:15 -0400
Message-ID: <eaa105840907160849k7403feffnc3b834e94a33643d@mail.gmail.com>
References: <f46c52560907160651u1cdc1779r511d227fa5c88956@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 17:49:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRTD4-00049r-Mn
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 17:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbZGPPtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 11:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbZGPPtR
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 11:49:17 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:43485 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512AbZGPPtR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 11:49:17 -0400
Received: by ewy26 with SMTP id 26so229113ewy.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=lg7/5rZuEMuvU4iRim8UXc5oAc0VCpymjMgocEvGzEw=;
        b=gaABycI6MVUPwxKlQ1esKHKN83jtY4H6tKpgrjEcfyFBuLXTR3tPeXAiWiyRRo3HpP
         B5B0r75NzJtJlMG3ONLsq9URRkHEHesuUQE02jD3nAKcKq+HApqT/r4EAMfJuRIqbrNc
         hEAao1TfpCFI1MGOpdk0lCqdGblrwmjSbbKEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=iBEU9QkPrB2IPbOKuiG5BFDDFbbbojExtcCN/mlMeROxAVRR9e/QSbvui68eGxF247
         VjOi8XKuJPdHjSjogbfPkUKTHaPw43kttG3k5Uvkyx5efrEW/HvqmiJHsFS8xq/bDYLu
         K7e/5IwjsDA9x6aT3N6BAmkZsef089BTirS84=
Received: by 10.210.43.10 with SMTP id q10mr2419750ebq.21.1247759355456; Thu, 
	16 Jul 2009 08:49:15 -0700 (PDT)
In-Reply-To: <f46c52560907160651u1cdc1779r511d227fa5c88956@mail.gmail.com>
X-Google-Sender-Auth: 47f0fbd10b92f5f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123405>

On Thu, Jul 16, 2009 at 9:51 AM, Rustom Mody wrote:
> I am trying to figure out the best choices regarding file-encodings,
> crlf choices etc.
> I see some stuff in gitattributes and some in git-config.
>
> So...
> 1. Is there some place I can find out whats the received wisdom
> regarding crlf and file encoding choices

This comes down to personal taste. I actually set core.autocrlf
differently for different projects.

> 2. is there some one place where all the options for all the git
> commands are listed?
>
> For example I find in git-config the following
>
> [branch "devel"]
> =A0 =A0 =A0 =A0remote =3D origin
> =A0 =A0 =A0 =A0merge =3D refs/heads/devel
>
> Where does one find out about such options?

"git help config" (those particular ones are under
branch.<name>.remote and branch.<name>.merge).

Peter Harris
