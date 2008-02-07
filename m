From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Using thunderbird to post/apply patches?
Date: Fri, 8 Feb 2008 12:42:09 +1300
Message-ID: <46a038f90802071542j765a8501kc57b065f22c734b2@mail.gmail.com>
References: <46a038f90802071521n674b61c2t5e4d4c740375b951@mail.gmail.com>
	 <alpine.LSU.1.00.0802072333120.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 00:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNGOF-0006eI-09
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 00:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945AbYBGXmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 18:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757318AbYBGXmN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 18:42:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:12793 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757049AbYBGXmL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 18:42:11 -0500
Received: by ug-out-1314.google.com with SMTP id z38so797332ugc.16
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 15:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=w/e8pYqlkksl9Cqd8xo99Sho1xLGqybzNZBn//csp7E=;
        b=XC4+3ifoWJovAJK6lkEQehJwULH/nxoHSUM5rWWXV5cx5IDsTCSiMFMDEo74pR8SUNdr7QwXQtjV/kg/GRDw7NFR6cbfgRVCNgiRgItcY+CyXXVknmneHAphi0c1iciYEvpF8gQRi/lL24T2NQGcuB+GA7NvckN23XwTsLaclvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lxLMU2kS8E/Futo3WI/VhuPgvW6pGs0ZTlkVHGfDFwjOXpkO1xSQbK1ZFQGKqd6l67JL2aO8orggcCoa5LxL4R3gnHRIfiAvpQu8SMy8ZGo2yCltDNo1r4AL0b+vT+I6/mcr8nAgcyhyPFMdzPLu+aD9+S+uSLeFz5PYrpkWUtY=
Received: by 10.66.221.5 with SMTP id t5mr4654961ugg.83.1202427729466;
        Thu, 07 Feb 2008 15:42:09 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Thu, 7 Feb 2008 15:42:09 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802072333120.11591@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73020>

On Feb 8, 2008 12:34 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> The "Thunderbird" section in Documentation/SubmittingPatches should help
> here.

If that's state-of-the-art then thunderbird hasn't gotten any better
since I last tried. Shame.

> >  - Feed an email I am reading to git-apply-mbox so that if it's
> > reasonably formatted as a patch it will do the right thing and apply
> > it.
>
> Recently, git-am learnt to apply mails in maildir format.  Thunderbird
> uses maildir format internally, if I am not mistaken.

It uses mbox - but the delimiter is somewhat broken, so sometimes
git-am fails to split the emails correctly.

A pretty sad story overall. Grumble...


m
