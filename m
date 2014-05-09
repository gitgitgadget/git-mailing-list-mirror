From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v1 06/25] contrib: remove 'diffall'
Date: Fri, 9 May 2014 08:12:07 -0700
Message-ID: <CAFouetj4A+z2xzciGAbsQ8th8CNwYMd5QTapar4TXRLzGdAqeQ@mail.gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<1399597116-1851-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 17:12:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WimT7-0000lq-1l
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748AbaEIPMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:12:08 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:33591 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756738AbaEIPMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 11:12:07 -0400
Received: by mail-ve0-f177.google.com with SMTP id db11so5333254veb.36
        for <git@vger.kernel.org>; Fri, 09 May 2014 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UhsNJ3X4hgnIlQGxpZAdzUdV47sL4ACWNrglDIC4AFM=;
        b=e1+tNGv4xDxkVnXkE2kl+Aep4MNqSNyszAtp4ybxHpL71+T78aqqe+2F6d9VrorTFh
         4ak5/IY0jY57fVZ4Zkvqwaoh/SIilpz4T0qggpO6HVzer0SdnsT3nGR31Z3LOQG4hPfu
         2hAtsDqKFHQORhIhRyj9yLXpXmlTmgywccDNeo2/s5qdZvNK4ZZ2nX5NB2lV/taFRGUq
         WEQmOi4dW5iIsaTakt3CLDQ2FJJylfzTgqPCqjUb5p0hZNo2gGxY+vqUoj17ZlCis7Mt
         SyHwQG1TTA3YTjgaj9Ea/rVIeFf+/iPFFe5OQJRy3QnppJ4jjc77XyE5YYzIMBfxXDsD
         aijQ==
X-Received: by 10.52.37.48 with SMTP id v16mr7440939vdj.4.1399648327250; Fri,
 09 May 2014 08:12:07 -0700 (PDT)
Received: by 10.220.95.207 with HTTP; Fri, 9 May 2014 08:12:07 -0700 (PDT)
In-Reply-To: <1399597116-1851-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248567>

On Thu, May 8, 2014 at 5:58 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> No activity since 2010, no tests.
>
> Cc: Tim Henigan <tim.henigan@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/diffall/README      |  31 ------
>  contrib/diffall/git-diffall | 257 --------------------------------------------
>  2 files changed, 288 deletions(-)
>  delete mode 100644 contrib/diffall/README
>  delete mode 100755 contrib/diffall/git-diffall

I see no problem with removing this script from contrib.  However, the
commit message
should mention that git-difftool learned all the features of
git-diffall when the '--dir-diff'
option was added in v1.7.11 (ca. June 2012).

Also, the script was first added to contrib in Feb. 2012, so "no
activity since 2010" is
incorrect.  I'm not sure this information is useful in the commit
message at all.
