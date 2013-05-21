From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: trivial fix for zsh
Date: Mon, 20 May 2013 19:38:14 -0500
Message-ID: <CAMP44s04oKBtjnF-+5hjPM+-krZA=m-4=Mb=vzU65GsTNhR3vA@mail.gmail.com>
References: <1369096383-28733-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 02:38:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueaar-0003UV-2t
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 02:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249Ab3EUAiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 20:38:16 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:41795 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab3EUAiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 20:38:16 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so147677lbi.18
        for <git@vger.kernel.org>; Mon, 20 May 2013 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3ama177L3UKiiCg81CWnoUkX8flFBetaxV1d6N/k4WM=;
        b=fyxOtYirx2xlaplYhZwZLiN/H8hY3jRTFxp1VGK6f+5300Pgn2/I3DYSJcZQSZlQrR
         356FBB3u164xJYQ9DQnQXJQpkcnHbR3fRl4aX9a2uRzbJ2N4jAzhotdSauMvy0oHs8B7
         yxJQCM7MON+0xXEiGZcg4ajmnSYZbWXWtQYfFVJWDXeHq7qvazNDB1vnDW+8naHdb2Wj
         MIwPqWbdW0ikVzdTSsxUCfgvp16zrm2VL9pNw/13t3jYbj7mhNrMXs2Z3uup72Aexno3
         A+PdqcSa6jOEc9p+J4D0Q8JEQ4d07DbpujH78m4Lt8Gr2wnJp1UqzRtjfrtp8PAodr07
         HcEw==
X-Received: by 10.112.166.101 with SMTP id zf5mr248737lbb.59.1369096694775;
 Mon, 20 May 2013 17:38:14 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 20 May 2013 17:38:14 -0700 (PDT)
In-Reply-To: <1369096383-28733-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225006>

On Mon, May 20, 2013 at 7:33 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> zsh completion wrapper doesn't reimplement __gitcompadd(). Although it
> should be trivial to do that, let's use __gitcomp_nl() which achieves
> exactly the same thing, specially since the suffix ($4) has to be empty.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

This is probably v1.8.3 material, I just noticed it's probably a
regression introduced by 1ce23aa (completion: add new __gitcompadd
helper).

-- 
Felipe Contreras
