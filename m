From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 8 Mar 2011 05:11:16 -0500
Message-ID: <AANLkTim_h6vbvnmy7oUNYmV82vCzLLfWKq=3_UY9kPYw@mail.gmail.com>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com>
 <4D75ED72.8030203@drmicha.warpmail.net> <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com>
 <AANLkTikK8Uc8=wKROYWWxZ_6OtQtqBmFCZN760M1LO+c@mail.gmail.com> <4D75FB7B.70403@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 11:11:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwttS-0006bP-TI
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 11:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab1CHKLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 05:11:48 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64723 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab1CHKLr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 05:11:47 -0500
Received: by iyb26 with SMTP id 26so4703206iyb.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 02:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=trx5St8iU/egtGHU+rGuW+uW3++9ybB/h5ebreoq55U=;
        b=wKEDtEufSlPT9c88gNDeXjp3w1WURd2w0zMeKYrBHQbarBYK9AtB89XKDvkRfr5EN8
         SMOLY1vt74tyo7Bzw15mlAh+Ugidpw8DA3LiPmYup6cm9a4Xu5RGSZt6mQODbqCMRhfu
         XNWp0ARa6QqbVdr7a66Q83/hu/Ei1bSCDir9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=V+4C3Rx5N5wgEHFKQ2UOirbLiEenUXOBqmsKmBH91NElB9Rq1b8md6ODmeK17RrrnV
         o6inV+SJl0k0rWXfBfyLsiWT6gLaN5Y90MTcqhw+aSScVHLldVvvQB59K/pJb7bumA7z
         zRp3ZfhFAE+tZsHklTGRzOnxDiOEN5p1Cs8mE=
Received: by 10.231.141.133 with SMTP id m5mr3763555ibu.107.1299579106368;
 Tue, 08 Mar 2011 02:11:46 -0800 (PST)
Received: by 10.231.34.7 with HTTP; Tue, 8 Mar 2011 02:11:16 -0800 (PST)
In-Reply-To: <4D75FB7B.70403@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168653>

On Tue, Mar 8, 2011 at 4:48 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> You mean shorter than:
>
> git rev-list --merges -1 $(git merge-base foo bar)
>
> Or maybe I'm misunderstanding "contain".

Going back to my original picture, I mean commit m:

  o---o---x---o---...    foo
   \       \
    o---o---m---o---...  bar

merge-base foo bar gives me x; to get m I then need to grep the output
of rev-list --parents for x.

j.
