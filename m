From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git rebase --committer-date-is-author-date with -i/-p
Date: Thu, 10 May 2012 13:33:30 +0200
Message-ID: <CAGK7Mr4sJGjPn-6QjM2Mmev-JxnSYfNAtTVofLrandMeyaUc3w@mail.gmail.com>
References: <CAGK7Mr7S42r_Xx0qygRCp+EujuuBF1MT1Y0vqCY+=EBT5++Urw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 13:34:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSRdH-00088M-Vv
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 13:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316Ab2EJLeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 07:34:01 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56083 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab2EJLeA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 07:34:00 -0400
Received: by yenm10 with SMTP id m10so1333460yen.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 04:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=SwvGFGsqoCoq5YMc3qHlPU4hKjayl6wRKUQYW/qhgWU=;
        b=YMWTDDlfpNmJCHtWa1ZeB0FLnKtbUn5qU9LbuofsmjKQkhP68+30mA18AxPdyBkIGJ
         WFSkL2n1o8VJfxdn+MXnlw2XR5VzQYvN0I9YquUg6FmCwelEOve0zjy/u2I0L0wOOkR9
         Ot9KopVyX+dKoNXsGLKj+b4UmFN623A8UPv35/JL+oHIsHPhXYln3LpbDyQFZR7ASVLz
         L5z8rB1iE+0tGGPNrYsepE8FbdThaJtewmDhSYduQjVsBa02ooB+7/GOJ6vtbu4cNp0M
         W5OrRHUFUpEt9tZkBhFTxurdQarskpdtPDF2oNFxD9tGGzTKrZO2vH6dNkU6LyDAhR/0
         0aVg==
Received: by 10.50.168.106 with SMTP id zv10mr1077063igb.55.1336649640285;
 Thu, 10 May 2012 04:34:00 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Thu, 10 May 2012 04:33:30 -0700 (PDT)
In-Reply-To: <CAGK7Mr7S42r_Xx0qygRCp+EujuuBF1MT1Y0vqCY+=EBT5++Urw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197555>

I see that it's probably possible to make it work by changing
`do_with_author` in git-rebase--interactive.sh, if I manage to add the
option to it and pass it from git-rebase.sh would people be interested
in this feature?

Philippe
