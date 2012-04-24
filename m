From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] gitk: avoid Meta1-F5
Date: Tue, 24 Apr 2012 04:41:17 +0300
Message-ID: <CAMP44s3j1UCH_joGBvTHn1i-iEJZ0JMAr0M3=HCzj8dEP7zJTw@mail.gmail.com>
References: <1333758578-9334-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Daniel A. Steffen" <das@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 03:41:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMUku-0003Ni-Ju
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 03:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab2DXBlU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 21:41:20 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57528 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab2DXBlT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 21:41:19 -0400
Received: by eekc41 with SMTP id c41so26097eek.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 18:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7YufL2f4sCt9DxhDojVgTPzGPT5xRVN2pPk2E8Ps0v0=;
        b=gCNYJecVFTKpNtMFOEZwzAeOhZpLruUQ6+QI9c+lX3b5MFQXRvRKarXJ3AVvUQgKw3
         YfJSW3UyPdy5+gKS+vRWEe79WH2ne2H7TB2/MkvxgFBxU6IwMCjDdJ7kIK7y3j1pYNTJ
         M/dvUAGfwyygRfC1P2hoc96O8fpYEbcj6Cr8dZM+64D88EQvGPabCt54p5wNH+2IefTO
         K93Jlx/9Pnv9P4ogJArA/UgABJeCtJi6AshhttDxgZzPm/w6vocfJHv3QKn3591nPFLZ
         Tv0wviQoiFHIjKHsj9z1OnqgZtQuoGACPX2Hh9gcyYSvSWJFw0ZckdW+YEs2s78XFkmR
         +Kbg==
Received: by 10.213.9.209 with SMTP id m17mr31104ebm.19.1335231677826; Mon, 23
 Apr 2012 18:41:17 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Mon, 23 Apr 2012 18:41:17 -0700 (PDT)
In-Reply-To: <1333758578-9334-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196173>

Helloo?

On Sat, Apr 7, 2012 at 3:29 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This is commonly mapped by window managers and what not. Use Shift-F5
> instead.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> =C2=A0gitk-git/gitk | =C2=A0 =C2=A04 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 22270ce..9bba9aa 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2038,7 +2038,7 @@ proc makewindow {} {
> =C2=A0 =C2=A0 set file {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mc "File" cascade {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{mc "Update" command updatec=
ommits -accelerator F5}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {mc "Reload" command reloadcommi=
ts -accelerator Meta1-F5}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {mc "Reload" command reloadcommi=
ts -accelerator Shift-F5}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{mc "Reread references" comm=
and rereadrefs}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{mc "List references" comman=
d showrefs -accelerator F2}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{xx "" separator}
> @@ -2495,7 +2495,7 @@ proc makewindow {} {
> =C2=A0 =C2=A0 bindkey ? {dofind -1 1}
> =C2=A0 =C2=A0 bindkey f nextfile
> =C2=A0 =C2=A0 bind . <F5> updatecommits
> - =C2=A0 =C2=A0bind . <$M1B-F5> reloadcommits
> + =C2=A0 =C2=A0bind . <Shift-F5> reloadcommits
> =C2=A0 =C2=A0 bind . <F2> showrefs
> =C2=A0 =C2=A0 bind . <Shift-F4> {newview 0}
> =C2=A0 =C2=A0 catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0}=
 }
> --
> 1.7.10
>



--=20
=46elipe Contreras
