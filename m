From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 23:52:07 +0530
Message-ID: <CAMK1S_jhxOEd10pMUp9Wt4VmTD9QRVgVvWz4p=k9TxL3QSdzAQ@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
	<CAMK1S_i7WjrZ=L_LVoTQriW8kKMPd+ABrgowpFCY3ks43E6K7A@mail.gmail.com>
	<20120729141354.GA16223@paksenarrion.iveqy.com>
	<CAMK1S_iFqQvU+USYf+wcsLFS1QtsytLnPfEhjcAVZa9Vwj8d1w@mail.gmail.com>
	<20120729150550.GA17679@paksenarrion.iveqy.com>
	<CAMK1S_hHBB9BViH=CFuJNgMJzMtzhE0mGc7ryFaDWNxOoH2Pgg@mail.gmail.com>
	<20120729154124.GA19201@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 20:22:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvY8i-0004vZ-LA
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 20:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341Ab2G2SWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 14:22:10 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64875 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753229Ab2G2SWJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 14:22:09 -0400
Received: by lahd3 with SMTP id d3so3049776lah.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7Q6teoIIiiTfPkHQPV7AxT9klyVD/BMvxV1aXG2YQTM=;
        b=sLDeEnJ6rQyYOIIvt+eSbAjiZy2zOvahhuKk/2ttNoza0HqbVdhD6IdWtz9Tbz6SIH
         NMI5Vi15KMVJatIfFrRU03+7ri12RrOWIin6AV/6pIZGmg3od//p0Td36OL+ZUVGUuRc
         IPWdePaau/qGWzd2wJNVQGBjDJuOK6HfvRPiW04e8gZXdmkkgIL3G190ZR38lPYHvRaO
         VL4fdq2cY/wgjUJnHZhxwsMVWtSDkplIpToi6e4xTjlhuYlflovhikUR+nAyP1JHkj2K
         7NsuG/hPH2vq6P/n2wSBHsj03IPyHTEdkcQGW3EE+vmS+0wpYhvD9JtYYmsq7nVge61o
         rVVA==
Received: by 10.152.111.200 with SMTP id ik8mr9032111lab.15.1343586127134;
 Sun, 29 Jul 2012 11:22:07 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Sun, 29 Jul 2012 11:22:07 -0700 (PDT)
In-Reply-To: <20120729154124.GA19201@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202487>

On Sun, Jul 29, 2012 at 9:11 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Sun, Jul 29, 2012 at 08:45:39PM +0530, Sitaram Chamarty wrote:
>> I think you misunderstood how gitolite works.  Gitolite does not have
>> *any* user interaction other than sending some extra messages back via
>> STDERR if you're using a normal git client to do normal git operations
>> (clone/fetch/ls-remote).
>
> As you say, gitolite has userinteraction, and its not even standard to

I think we differ on the meaning of the word "interaction".
