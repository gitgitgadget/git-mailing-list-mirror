From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout or merge, stash & restore submodules)
Date: Thu, 1 May 2008 12:56:31 +0800
Message-ID: <46dff0320804302156w7ed0e139pae171fa51a9e8cb8@mail.gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
	 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
	 <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tim Harper" <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 06:57:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrQrK-0000ik-Jb
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 06:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbYEAE4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 00:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbYEAE4c
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 00:56:32 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:18713 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYEAE4c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 00:56:32 -0400
Received: by an-out-0708.google.com with SMTP id d40so176151and.103
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 21:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cFTHexENtgMPgqxf+onYQSohwn2ShXdXa9iqSkX1FQw=;
        b=SRhJkMJKsP9qBxByURe0D/tSUP1mGW8pDUdxPTWVMrEwFhgEywA3ARq/bV3BXwaZgGpXDBiZY+F+EoVPND96+hMOvSuy8K44TC6Z4wws0k84/HRoHPtYKLNRvNRTRBCg/L0tmo8qhmPvNdlTwijwt0z2VDqaFjdrEtj/bmeQTSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AWyUKN4PkQNWbV1sKK28sHXUh5o0a3krGiNinCiONYUJzoFS20BJ3eth16izHdKTA5u0AB6GFqAifD7ngIMoySI1s6YP5uqihxzsAlivdehJFldvw5dGq8U6hkeEVSCV5L+ecuA+lB8WAwdWiKHgbMzol+PEGLI70QGo80Xv7cw=
Received: by 10.100.194.5 with SMTP id r5mr2478221anf.146.1209617791083;
        Wed, 30 Apr 2008 21:56:31 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Wed, 30 Apr 2008 21:56:31 -0700 (PDT)
In-Reply-To: <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80888>

On Thu, May 1, 2008 at 4:19 AM, Tim Harper <timcharper@gmail.com> wrote:

>
>  I could see an issue if you changed the submodule version, and forgot to
> commit the version change in your super project, and then switched branches,
> and lost your version change.  Perhaps the correct behavior in this case
> would be to only automatically update the submodule version if it didn't
> differ from the superproject version in the "from" branch.
>

Agree. Doing this will make submodule be more consistent with the ordinary file.
Further, when switching to another branch with diffrent recorded
commit about the submodule and the submodule in the from branch has
been modified, just refuse to switch because this can be considered a
conflict and there is no easy way to merge.


-- 
Ping Yin
