From: Thomas Adam <thomas@xteddy.org>
Subject: Re: Question about rerere
Date: Thu, 6 Nov 2014 17:03:10 +0000
Message-ID: <CA+39Oz4k97uKceBmaiz3z5m2sVZ6jtQS9s+UVCwixkF_Rn+U+A@mail.gmail.com>
References: <F9D7CE90-BED2-4694-B5DB-AE848C9F3F34@phare.normalesup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Tristan Roussel <troussel@phare.normalesup.org>
X-From: git-owner@vger.kernel.org Thu Nov 06 18:03:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmQTK-00014w-5Q
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 18:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbaKFRD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2014 12:03:29 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:37068 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbaKFRD0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Nov 2014 12:03:26 -0500
Received: by mail-wg0-f50.google.com with SMTP id z12so1711022wgg.23
        for <git@vger.kernel.org>; Thu, 06 Nov 2014 09:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=njn7pXUFNHdQOC2yjrW1Zsh6UNqXyrIoFRdeFNPIm74=;
        b=eHBnpwdbkN+D2qhM+OHlIPzLbHjn0NyDi+x3VBJONdC+1TPWTaSwv45qSConIZe12y
         LJ9jeoedn7cmL3ksiNJUjgeeqPwdU39CYggr0SXdpwZoIJA/wY7hI1+eX2RKMM41P6/i
         04kHA9ps8mRyeRvn9DcIeVeIBWsTtyhvoUJIaolChoJRcxLU6U0MWlsdHxAfJqRA5QVa
         8J9gz2Se67BXXwc172Z198lF/aLmJdCV40cg1kWnynR6vknmaUNVLcEmFQAIac384Q1N
         18nB/PoldpjurMRqZhMsSoCINzPKHNasqTG7JzRaNr/NGi4NN9I7gUmTnBruYBl2QutD
         2tLw==
X-Received: by 10.195.13.14 with SMTP id eu14mr7321253wjd.31.1415293405312;
 Thu, 06 Nov 2014 09:03:25 -0800 (PST)
Received: by 10.217.160.5 with HTTP; Thu, 6 Nov 2014 09:03:10 -0800 (PST)
In-Reply-To: <F9D7CE90-BED2-4694-B5DB-AE848C9F3F34@phare.normalesup.org>
X-Google-Sender-Auth: 8a8Zn50x_nfMgcBB935h777Pkzk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 November 2014 11:30, Tristan Roussel <troussel@phare.normalesup.or=
g> wrote:
> Hello,
>
> I=E2=80=99ve just learnt about rerere and it=E2=80=99s going to make =
my life so much easier, I have a question though.
>
> I enabled rerere very lately and I wanted to know if there was a way =
to feed rerere with old merge conflict resolutions (and if not, would i=
t be considered a good feature request)? I=E2=80=99d like to do a rebas=
e of my work because I unintentionally merged a branch I didn=E2=80=99t=
 want and the merge is a bit far in the git history and I don=E2=80=99t=
 want to re-resolve merge conflicts I had after that.

Have a look at contrib/rerere-train.sh

-- Thomas Adam
