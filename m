From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [bash-completion] syntax error near unexpected token '<' on line 
	123 in bash_completion.d/git
Date: Sun, 25 Jul 2010 11:49:19 +0000
Message-ID: <AANLkTimYo9itgVrL100mD8sU52h7f2F84PuJtCO3yKsJ@mail.gmail.com>
References: <1280056320.7883.9.camel@soho.example.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andrew Sayers <andrew-git@pileofstuff.org>
To: "solsTiCe d'Hiver" <solstice.dhiver@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 13:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oczht-0007Xb-CK
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 13:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab0GYLtV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 07:49:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54295 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab0GYLtU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 07:49:20 -0400
Received: by iwn7 with SMTP id 7so1848989iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 04:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W+czD90a6ra7zy+HaRJhgN9Dus+DGgdvDh60Rt2lud4=;
        b=I9JVjZiSv+fBXYU5QXKAmxhSfAUheC3ROWUhbjDTf1067xrd8CYelneBdSRuUZkB7F
         fpJlZ6c5jIqvt+zegNx0hOGl9n925skYzTOZ/e1kX8EkEsFTSVl6m+L00HonTNxUHzgU
         6kIDMLtQiGpxqi5dosPs/6SQEF0hVXYZyWxfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Fu2n/oxjp9geqWUszxIYrDXNG9I+aAn7MAXPEgO1IwsDOOVTsNiqJaJwGoBTxhI6RJ
         lHXdT7k0qA979/Kix1umIBVGYZwgtpLmsWX1sPcn/kErzshOyn4UvwXTvIy+Cam4KsKZ
         hAGGKHW9MVuLyTNSiPL4ptUNNgTMTtEsD8ZBY=
Received: by 10.231.170.79 with SMTP id c15mr6977417ibz.82.1280058559671; Sun, 
	25 Jul 2010 04:49:19 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 25 Jul 2010 04:49:19 -0700 (PDT)
In-Reply-To: <1280056320.7883.9.camel@soho.example.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151727>

On Sun, Jul 25, 2010 at 11:12, solsTiCe d'Hiver
<solstice.dhiver@gmail.com> wrote:

> =C2=A0 =C2=A0 =C2=A0 =C2=A0done < <(git config -z --get-regexp '^(svn=
-remote\..*\.url|bash
> \.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')
>
> I think that may be there is too much < there.

That's not a syntax error.

CC-ing Andrew Sayers who added this feature.
