From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn tests fail since 1.7.2.2
Date: Thu, 28 Oct 2010 12:56:48 -0500
Message-ID: <20101028175648.GA14212@burratino>
References: <20101028122857.3c8d3f4d@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Oct 28 19:57:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBWin-0007cs-PC
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 19:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760441Ab0J1R5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 13:57:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63978 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab0J1R47 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 13:56:59 -0400
Received: by fxm16 with SMTP id 16so2196698fxm.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mRxv7ku2MKLAN2H/jayX1fkJXHorwkNcSZo1wP8IyOQ=;
        b=YT/nXxfNnKvaUfk2f4fpiNf6SVPI71R+d189j1THjNDqg+sZXu2089KXmJT5GmID1T
         qHssX/WJXYo/M0Ukl8Hog2SwexJaehlou73uf5HSxo2IbP18FeSnYo7DMPCZlgOBU4p1
         fRpJqwmgY9fOqhYKsOuh/RqecKUmPiZ3At2ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vD+vZeF0QJjyvs0QyX4Il3phlOY+Z4PnDZP8mWfJdADr/52GNa+5JA6a+K5jKTN2jy
         FrbuwRbmD4neEl47cj7IodsT29dugAiPx5y2UVi8QxCqXDEDu2YZt4osCtPKWniV++zN
         2zS9zAF9y0/qxe0O6Wp4xHvarEvI/mvDs7yDs=
Received: by 10.223.107.66 with SMTP id a2mr4311534fap.92.1288288618476;
        Thu, 28 Oct 2010 10:56:58 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id k4sm623694faa.8.2010.10.28.10.56.56
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 10:56:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101028122857.3c8d3f4d@pc09.procura.nl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160190>

Hi,

H.Merijn Brand wrote [snipped somewhat]:

> Up to and including 1.7.2.1, all went smooth and fine, but as of
> 1.7.2.2 (and 1.7.3.1 and 1.7.3.2), the tests started to fail on svn
> issues.
>
> t9101-git-svn-props.sh                           (Wstat: 256 Tests: 26 Failed: 3)
>   Failed tests:  24-26
> t9143-git-svn-gc.sh                              (Wstat: 256 Tests: 11 Failed: 1)
>   Failed test:  10
>
> These tests fail on *all* my Linux boxes, which happen to be OpenSUSE
> ranging from 11.0 to 11.3.
>
> OpenSUSE 11.0/64:
> + svn, version 1.5.7 (r36142)
> 
> OpenSUSE 11.2/64:
> + svn, version 1.6.6 (r40053)
> 
> OpenSUSE 11.3/32:
> + svn, version 1.6.9 (r901367)

Any idea what error message or command they fail at?  Useful commands
to try might be

 sh t9101-git-svn-props.sh -v

and

 sh -x t9101-git-svn-props.sh -v -i

Thanks for reporting,
Jonathan
