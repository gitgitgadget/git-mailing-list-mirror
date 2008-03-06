From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Thu, 6 Mar 2008 13:18:17 +0800
Message-ID: <46dff0320803052118j2296a2d4p397fa889f8cea45b@mail.gmail.com>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
	 <7vd4q8kbey.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803051754o4b45222es524a62a7cac50b94@mail.gmail.com>
	 <alpine.LSU.1.00.0803060330210.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 06:19:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX8Vn-0004ER-81
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 06:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbYCFFSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 00:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbYCFFSU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 00:18:20 -0500
Received: from hs-out-0708.google.com ([64.233.178.245]:59117 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbYCFFST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 00:18:19 -0500
Received: by hs-out-0708.google.com with SMTP id 4so6932758hsl.5
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 21:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=f/zLlheazyQZxGoDr63l04aZESrLSFAjHCs89hktMPY=;
        b=MQYSzlHib0miUnch5pLu7dL7fXfcYF27zc5iVk7JYE7saID+5KU0eDm0qYjy5AJrWkR79QWJF0hweTx6Cy47CJxNF429LMzbpWsaAg/XBLdRcTwOYvoh5z0pJ9QSZCCRXU4vcV+pnZbbQdbU/ClpyILisaiv6laWplHCISUR3L8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HQ9D4p/2PUH+CRy95VLp9sB5x8PMSdS/ofuXXwWZQXVvpfFxchaPqd6km91Xh+k5u3L7DllX0DTN5zbA4Ft8EVFwP8cp/wEE8TAsgTrqYyqgAah/IaNfFZes26NF0TbrohEBwVrKGpazjIZKvPkzfn6wtHJD7K9vIaL/w4uYUrk=
Received: by 10.100.251.5 with SMTP id y5mr6278571anh.118.1204780697772;
        Wed, 05 Mar 2008 21:18:17 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Wed, 5 Mar 2008 21:18:17 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0803060330210.15786@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76332>

On Thu, Mar 6, 2008 at 10:32 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  > >  The place the owner of the repository (not the project) expresses which
>  > >  modules are of interest, what transports she wants to use to access it,
>  > >  etc. is $GIT_DIR/config, and .gitmodules is a vehicle to supply hints to
>  > >  be used when the user populates that information.
>  > >
>  > Not always the case.
>
>  If it is _not_ always the case, .gitmodules is definitely the wrong place,
>  and $GIT_DIR/config is.
>
>  Just like we need "init && update", and not have "init" update implicitly,
>  like some people wish (who forget that other people might have other
>  wishes), we need to allow for different options here.
>
>  And as .gitmodules is _meant_ to be tracked, it is not the place to
>  express individual wishes differing from the colleagues' wishes.
>
As an analogy, .gitignore is for colleagues' wishes and
.git/info/exluces is for individual wishes.
The same, .gitmodules is for colleagues' wishes and .git/config is for
individual wishes.

There are always common cases and special cases, so we need a machinsm
to support both of them.
>  Ciao,
>  Dscho
>
>



-- 
Ping Yin
