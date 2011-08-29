From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [tig] [PATCH] Display line numbers in main view
Date: Sun, 28 Aug 2011 23:16:31 -0400
Message-ID: <CAFuPQ1LQgmOO=ziDZcJC9jMckCOu1NEHYM=R9HnMRXWzDuydZw@mail.gmail.com>
References: <20110805010616.GA16045@146653177.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 05:19:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxsO0-0003cc-Eg
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 05:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab1H2DQx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Aug 2011 23:16:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57196 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab1H2DQw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 23:16:52 -0400
Received: by fxh19 with SMTP id 19so4050871fxh.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 20:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=P+ByGAEv+QRCs88lQl5W5WwA/QDYT+tmnDHBu8OThKI=;
        b=EwQOQWoDGi+6hQ8PPS25TODoH3CLkEQCVUFmBXDR63ATkBiDUtU8lh8ooIeQpB/+Cz
         3o2Yu0CS+gKeWDqguBCkQWKfIGADRxSXUQk13npcV5xqHXBK+HP4ICZP41grNCRd18xv
         nz4JGjpG5A+QH0tWpShOjDk4uejB/Huh7hMzw=
Received: by 10.223.63.139 with SMTP id b11mr1353174fai.111.1314587811132;
 Sun, 28 Aug 2011 20:16:51 -0700 (PDT)
Received: by 10.223.96.11 with HTTP; Sun, 28 Aug 2011 20:16:31 -0700 (PDT)
In-Reply-To: <20110805010616.GA16045@146653177.ece.utexas.edu>
X-Google-Sender-Auth: l0Nw6H3U24dNNRDh6UvS6lim0mo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180293>

Applied, thanks!

On Thu, Aug 4, 2011 at 21:06, Kumar Appaiah <a.kumar@alumni.iitm.ac.in>=
 wrote:
> When line numbers are enabled, this enables the display of line
> numbers in the main view as well. This is useful for cases where one
> would want to quickly navigate to a particular commit by the ordering
> displayed in tig, using the `:<num>' approach.
> ---
> =C2=A0tig.c | =C2=A0 =C2=A03 +++
> =C2=A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/tig.c b/tig.c
> index ed92400..92091ab 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -6194,6 +6194,9 @@ main_draw(struct view *view, struct line *line,=
 unsigned int lineno)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!commit->author)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
>
> + =C2=A0 =C2=A0 =C2=A0 if (opt_line_number && draw_lineno(view, linen=
o))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (draw_date(view, &commit->time))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TRUE;
>
> --
> 1.7.2.5
>

--=20
Jonas Fonseca
