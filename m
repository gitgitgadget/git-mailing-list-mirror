From: Cheng Renquan <crquan@gmail.com>
Subject: Re: [RFC] git branch --status ?
Date: Tue, 4 May 2010 05:03:39 +0800
Message-ID: <t2s91b13c311005031403h37c5e066va6870a3ae0a79420@mail.gmail.com>
References: <p2i91b13c311005031131vc876475fn674c0ceffbdb3cf6@mail.gmail.com>
	 <4BDF2A02.1050907@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 03 23:03:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O92ns-0005Uj-82
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 23:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab0ECVDm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 17:03:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41760 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0ECVDl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 17:03:41 -0400
Received: by vws19 with SMTP id 19so2167311vws.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vB2yKABmtyzvTE0mOsKSqcXov1zs6t1Hop0Frnsn3KM=;
        b=w0oXCwvY7QrXa4+XGVC6ihmArRp1szepmEoaAduMFIJcPhWPwm/39kXa7+7fvsgnxP
         7kBCldnjZd6DlmF/aqcr3nwJniTt1euuPncyQE8nCNDdcPbjdlHhWaObG6edeDrntxvY
         7MtO/lumbZLrAS132KsTjeMbRtAyST44Z3cJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TtruEfnTtGN9ncNFi2jGTqI/jcy0/C14G20QAdtIOoGDd0j5o36bROTVjhEI2R76W1
         DHejZjvQPtuLZM8yseR9YWrhtJtveS4kbnNk2S6x+T0lDQRqxx8MtZVoRuHmB3MNKCEt
         SK5fZH2CTmXiT7M+cz5FzmbBNjuTJ0Pd8kqe4=
Received: by 10.220.127.75 with SMTP id f11mr10602393vcs.218.1272920620046; 
	Mon, 03 May 2010 14:03:40 -0700 (PDT)
Received: by 10.220.16.79 with HTTP; Mon, 3 May 2010 14:03:39 -0700 (PDT)
In-Reply-To: <4BDF2A02.1050907@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146258>

On Tue, May 4, 2010 at 3:54 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> You may mean something like
>
> git log --no-walk --format=3D"%d [%h %an %ad %s]" --branches
>
> although Jeff will tell you to use
>
> git for-each-ref --format=3D"%(refname:short) [%(objectname) %(author=
name)
> %(authordate) %(subject)]" refs/heads

changed to refs/remotes, it works well, thanks,

git for-each-ref --format=3D'%(refname:short)%09[%(objectname)
%(authorname) %(authordate:relative) %(subject)]' refs/remotes

> and will probably know how to abbreviate the objectname here ;)
>
> Cheers,
> Michael
>

--
Cheng Renquan (=E7=A8=8B=E4=BB=BB=E5=85=A8), Singapore
