From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] gittutorial: Add global color.ui
Date: Mon, 13 Apr 2009 09:03:19 +0200
Message-ID: <4d8e3fd30904130003m78dc7a81pf91ed6772b5c4f93@mail.gmail.com>
References: <20090410141622.10e40448@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 09:04:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtGDv-0004hV-5b
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 09:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbZDMHDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 03:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755019AbZDMHDV
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 03:03:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:57209 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927AbZDMHDU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 03:03:20 -0400
Received: by fg-out-1718.google.com with SMTP id e12so603936fga.17
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 00:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=DpZQ59FGQLMFEtQviguzmupFP+aTDB1ncE1dj7G+GYc=;
        b=VpM74yigjfwTdFl9onwaXdRz93P5HdYtlQZnUdpQlt8dgEaQOf8tMOqFP/BPcjj0mO
         KuTFORFAjhq5e1xLXX+j2bUQ3yn/tW4ghhAUjfyED+MEAF42qtb7PYpMKDsq50owClWJ
         aKH+oqwm2xa2maymDCZfIxscqxbbgyQZWLKeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=JzaX9288fifVIHzqzfS9PRoQJ4oGgYyPt+WKdIaWyY4nGT22EwhtS5hGlVnthQAFOW
         yJPdqmumgau8bjp9gwUQr50dkrvj5/c5Q5kyAsJbLbEDODMmlkFfTG6pxMLwtkG8hovY
         gfsPDLmFyAc4zQEz/by13+tZ7nn+GhemwS71M=
Received: by 10.86.95.20 with SMTP id s20mr4554567fgb.40.1239606199319; Mon, 
	13 Apr 2009 00:03:19 -0700 (PDT)
In-Reply-To: <20090410141622.10e40448@paolo-desktop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116413>

Hello,
AFAIK the below path has not been commented or applied.

Should I just wait or does it means that is not considered usefull?

Regards,
        Paolo

On 4/10/09, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> I consider color.ui so important that I think it deserves to be mentioned in
> the gittutorial document.
> Patch is against pu.
>
> Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> ---
>  Documentation/gittutorial.txt |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
> index c5d5596..6748fda 100644
> --- a/Documentation/gittutorial.txt
> +++ b/Documentation/gittutorial.txt
> @@ -44,6 +44,14 @@ $ git config --global user.name "Your Name Comes Here"
>  $ git config --global user.email you@yourdomain.example.com
>  ------------------------------------------------
>
> +This will make prettier the output of certain commands such as `git diff`
> +and `git branch`:
> +
> +------------------------------------------------
> +$ git config --global color.ui auto
> +------------------------------------------------
> +
> +
>
>  Importing a new project
>  -----------------------
> --
> 1.6.2.2.485.ge37347
>
>
