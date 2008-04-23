From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 23 Apr 2008 09:27:37 +0800
Message-ID: <46dff0320804221827g6579919fid69d581256de90e1@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804220659j66dea3fehc2a9bdcdc0371025@mail.gmail.com>
	 <200804221655.11914.Josef.Weidendorfer@gmx.de>
	 <46dff0320804221013m2ff0320am31b7f8beb5f26f1b@mail.gmail.com>
	 <alpine.DEB.1.00.0804221827330.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 03:28:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoTmg-0006DX-DH
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 03:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759141AbYDWB1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 21:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756770AbYDWB1j
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 21:27:39 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:10749 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbYDWB1i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 21:27:38 -0400
Received: by an-out-0708.google.com with SMTP id d31so654170and.103
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 18:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JNFZb8er4oEfa+/Q3pUrQ6rqyRkWgH10Oz0y75RiJ7I=;
        b=Z867xzF9QurkAyJX0or1FT39hMX4290pAXSwrmlR6sTtdCxEVd1eU2qO7fgu4TqfUE++tUYHLqPexiWERdKfWT8zEy63f6GybgQlkFNWRHmbClaS3PJrIpibK2+f0njPKYJ54w/9IeoDkGf/J2RsnDxyYI47jpSTolg+bC2aBEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YCZY4baLu6vSreKGtfcp6ZSQ7nTGVR2QOSbpm99sucmEXxe5sowuS10/R8zlIkCAQwmdQZ9VjDCckqRcRtCXfTwUAwPN8tesXM0+TVgtFxM21kd/sL1+nu52McHZfUrzRCt2AF57aUIm33YDY3vvZ0RPRELlGkJDYgUAdyt0/j0=
Received: by 10.100.206.11 with SMTP id d11mr1666398ang.29.1208914057162;
        Tue, 22 Apr 2008 18:27:37 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 18:27:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804221827330.4460@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80180>

On Wed, Apr 23, 2008 at 1:28 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Wed, 23 Apr 2008, Ping Yin wrote:
>
>  > If we go back to a old HEAD or switch to another branch with changed
>  > path for a submodule, what should 'git submodule update' do? I think
>  > entries in .gitmodules should take precedence.
>
>  Literally the most common reason for a _different_ .gitmodules in an older
>  revision is that the repository was moved to another machine.
>
>  In this case, your suggestion is actively wrong.
>
Another common reason is the adjustment of repository directory in the
central environment
so i said *path*, not *url*. I agree what Josef said in the the
following reply: "It makes no sense to have submodule path
configuration in .git/config, as it has to be in sync with the current
commit". So it should be bettter to store path info only in
.gitmodules instead of $GIT_DIR/config


-- 
Ping Yin
