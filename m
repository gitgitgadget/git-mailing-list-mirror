From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Split fetch and merge logic
Date: Fri, 16 Feb 2007 09:40:51 +0100
Message-ID: <8aa486160702160040t3f42b5a0xbd12f333805ad4d7@mail.gmail.com>
References: <874ppmplw7.fsf@gmail.com>
	 <7vwt2i7bq7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 09:40:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHyeH-0000LF-8d
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 09:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966233AbXBPIky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Feb 2007 03:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966235AbXBPIky
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 03:40:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:50151 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966233AbXBPIkx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Feb 2007 03:40:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so77115uga
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 00:40:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AWkVXaBVgkdIS7z22zUJM3JJII420sCHluj+skc4MOov6aY1pnzYV1p2xk22fFBk6yOY4xH7WzAj9caLDlxR4Bb7sVuXWrGV4Zb1MjXAGpkltKpuWgDC9fCGIVNZL+a1R3uwBtc/+m1sE7LMOSmfUn2OHSKSbDK2pGMhMxFaGYY=
Received: by 10.78.50.5 with SMTP id x5mr562485hux.1171615251510;
        Fri, 16 Feb 2007 00:40:51 -0800 (PST)
Received: by 10.78.69.4 with HTTP; Fri, 16 Feb 2007 00:40:51 -0800 (PST)
In-Reply-To: <7vwt2i7bq7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39907>

On 2/16/07, Junio C Hamano <junkio@cox.net> wrote:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
> > This series implements the split of the fetch and merge logic.
>
> That's a description of what it does, but could you describe
> what problem it solves, please?

Sure.

In the past we've had problems when we have changed the merge logic
(as shows 4363dfbe3). This patch makes the two process completely
independent, and concentrate the merge logic in one place (leaving
git-parse-remote.sh independent of the merge logic).

>
> The approach of presentation to introduce the test and showing
> the behavior change in a later patch is very good, though.

Thanks.

Santi
