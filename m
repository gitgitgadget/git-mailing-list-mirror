From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/3] am: remove support for -d .dotest
Date: Tue, 4 Mar 2008 03:57:45 -0500
Message-ID: <76718490803040057i16cc31b6nee459f560f5386f5@mail.gmail.com>
References: <1204619106-30449-1-git-send-email-gitster@pobox.com>
	 <1204619106-30449-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 09:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWSyx-0004on-4B
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 09:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbYCDI5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 03:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753019AbYCDI5q
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 03:57:46 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:40669 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbYCDI5p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 03:57:45 -0500
Received: by wa-out-1112.google.com with SMTP id v27so699878wah.23
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 00:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xQP+XVm4tkBalxBXD2eqNn/oGBm+JbiaW0t6qu2edls=;
        b=nONWVNuf1lBMxhprk8pLFp5Wifg0IYOvCmmNn06vOyTKoBQnOAuZpnhSWLLW5fmR+Q1ru/NlIczGOvgA1PGeGwusNE+xNlcjvoFYZEZjqkNUWcznOQUNFzO/RUJDOUfUDCsoE0l9aJlXc6y4/ZnjY7uuxAC67S9IDGmyuQNhsYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LA/+amYwQmTjT9VeOnsRwTMJOAWUIMhWtNVfTskQrxV05imhuJWGkfXVdIDFDwN+IO5WeZ61Jmj1AVehDFrPITj25S+5BxWtJ91opsDQ85htrTIY6nDFZ+me949NZiyPdLX/Knb1qVDNwLCwURPIgkXAt+qdHW9T1FTlhtsOXE8=
Received: by 10.115.54.1 with SMTP id g1mr1586316wak.132.1204621065515;
        Tue, 04 Mar 2008 00:57:45 -0800 (PST)
Received: by 10.114.13.5 with HTTP; Tue, 4 Mar 2008 00:57:45 -0800 (PST)
In-Reply-To: <1204619106-30449-2-git-send-email-gitster@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76055>

On Tue, Mar 4, 2008 at 3:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> @@ -152,8 +148,8 @@ do
>        --skip)
>                skip=t ;;
>        -d|--dotest)
> -               shift
> -               case "$1" in /*) dotest=$1;; *) dotest="$prefix$1" ;; esac ;;
> +               die "-d option is not longer supported.  Do not use."

s/not longer/no longer/

Also, probably want to remove mention of the option from
Documentation/git-am.txt as well.

j.
