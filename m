From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 23 Apr 2008 10:03:16 +0800
Message-ID: <46dff0320804221903u6d5a3b51q171a89e8b920183a@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804220659j66dea3fehc2a9bdcdc0371025@mail.gmail.com>
	 <200804221655.11914.Josef.Weidendorfer@gmx.de>
	 <46dff0320804221013m2ff0320am31b7f8beb5f26f1b@mail.gmail.com>
	 <alpine.DEB.1.00.0804221827330.4460@eeepc-johanness>
	 <46dff0320804221827g6579919fid69d581256de90e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 04:04:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoUL6-0005PW-DH
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 04:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759606AbYDWCDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 22:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756568AbYDWCDS
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 22:03:18 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:55451 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829AbYDWCDR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 22:03:17 -0400
Received: by an-out-0708.google.com with SMTP id d31so655355and.103
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 19:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uwyZe3oo0pfuiH2SB4o7UrKUKzliqOWqkEtpvl7URTc=;
        b=t6PIPOrapijx3L+GavWsvtn3Pe3u+m2bmVqgF+D5XwGOEFF0K2nUC/3+Sha2l01osI718OZXHlF4orHBgEAPI4h8sbOYSlzo6kHv5h8nzUqTWN1X0Iz283yMx58Kg+zLrgH8QZrp1UicgYenQOFNddw2YIeGEhlsqFHeT64L8zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YdphHspDevJLs+vULpiLTuFKZpR1yLxdrW0tzpinNf9iw8LscoL4q6sKYhnV52BRgU6tyFYNS50xgbynK0ADsTTxXDWCJavRt1shw8/ljtpvNOU8ulJuQ0oYI1v53RfSbpMyFV0FHOmDPSfAfaD4mTkHyUncSbBv4X1wNQH2yqc=
Received: by 10.100.227.6 with SMTP id z6mr1731830ang.41.1208916196803;
        Tue, 22 Apr 2008 19:03:16 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 19:03:16 -0700 (PDT)
In-Reply-To: <46dff0320804221827g6579919fid69d581256de90e1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80183>

On Wed, Apr 23, 2008 at 9:27 AM, Ping Yin <pkufranky@gmail.com> wrote:
>
> On Wed, Apr 23, 2008 at 1:28 AM, Johannes Schindelin
>  <Johannes.Schindelin@gmx.de> wrote:
>  > Hi,
>  >
>  >
>  >  On Wed, 23 Apr 2008, Ping Yin wrote:
>  >
>  >  > If we go back to a old HEAD or switch to another branch with changed
>  >  > path for a submodule, what should 'git submodule update' do? I think
>  >  > entries in .gitmodules should take precedence.
>  >
>  >  Literally the most common reason for a _different_ .gitmodules in an older
>  >  revision is that the repository was moved to another machine.
>  >
>  >  In this case, your suggestion is actively wrong.
>  >
>  Another common reason is the adjustment of repository directory in the
>  central environment

I'm wrong, this is the case that  *url* changes.

>  so i said *path*, not *url*. I agree what Josef said in the the
>  following reply: "It makes no sense to have submodule path
>  configuration in .git/config, as it has to be in sync with the current
>  commit". So it should be bettter to store path info only in
>  .gitmodules instead of $GIT_DIR/config
>

The case that *path* changes is the submodule is moved to a new path
in some commit. But it is a very rare case.


-- 
Ping Yin
