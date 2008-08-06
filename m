From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH 1/2] Fix generated Subject: line in .topmsg
Date: Wed, 6 Aug 2008 07:10:08 +0200
Message-ID: <36ca99e90808052210y109e1321j319f531141112f96@mail.gmail.com>
References: <1217963610-15195-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Bert Wesarg" <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 06 07:11:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQbIp-0002y3-Pi
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 07:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbYHFFKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 01:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754299AbYHFFKK
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 01:10:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:8460 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbYHFFKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 01:10:09 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1703856wxd.4
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 22:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+wfHZSNwimBDPkSehy11ZjJRP0W6PN3dyZG7E/scUqE=;
        b=FhUQmr6HnVrfwjqiEKnSjSZmVDC8g5l5Zc6OVKBry0du3iF6Ztvw2MYHwCbAoqRdAs
         XAWq4F8g3nSmKyPrdlXR6TkDoSQcIYDKR8taZKY0Iv5ZnDk08vRtm+mU2BP/ZkutxK48
         gWSqOj+OSI1i7MEQKti7Wzr7gkbf9agVBTtX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DPBA+9gtw5q/NSDnSUohSZn7HSMokHQw4I5VCeW8gDCt+MNkHDrlar51zJKqV0NN+V
         EVGonZxivllIKvdrZiKPXi1GMcQkEnC57TykB3OV6ZqSuWZgKJFFq7Q8y2Ci5AzwLH6N
         /Re1/jblbv/dOknueJRV+iRQITb6F2BTGHMI8=
Received: by 10.70.71.9 with SMTP id t9mr2306960wxa.72.1217999408828;
        Tue, 05 Aug 2008 22:10:08 -0700 (PDT)
Received: by 10.70.28.18 with HTTP; Tue, 5 Aug 2008 22:10:08 -0700 (PDT)
In-Reply-To: <1217963610-15195-1-git-send-email-bert.wesarg@googlemail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91483>

Just a resend, because Petr didn't get this mail.

Bert

On Tue, Aug 5, 2008 at 21:13, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> $1 is unset after parsing all arguments, so use $name instead.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
>  tg-create.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/tg-create.sh b/tg-create.sh
> index d196e4f..0bf329c 100644
> --- a/tg-create.sh
> +++ b/tg-create.sh
> @@ -107,7 +107,7 @@ author_addr="${author%> *}>"
>        ! header="$(git config topgit.to)" || echo "To: $header"
>        ! header="$(git config topgit.cc)" || echo "Cc: $header"
>        ! header="$(git config topgit.bcc)" || echo "Bcc: $header"
> -       echo "Subject: [PATCH] $1"
> +       echo "Subject: [PATCH] $name"
>        echo
>        cat <<EOT
>  <patch description>
> --
> tg: (24367cc..) t/fix-subject-line-in-.topmsg (depends on: master)
>
