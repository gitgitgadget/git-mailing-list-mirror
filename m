From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Mon, 4 Feb 2008 12:59:52 +0100
Message-ID: <8c5c35580802040359v1a5d8c42xfbc592245a8917c2@mail.gmail.com>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com>
	 <1201975757-13771-1-git-send-email-hjemli@gmail.com>
	 <alpine.LSU.1.00.0802021815510.7372@racer.site>
	 <8c5c35580802021047o41a7de9fi84a6b33f0f779e2e@mail.gmail.com>
	 <7vwsplporv.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0802040024030.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 13:00:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLzzu-0008J3-39
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 13:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbYBDL7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 06:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbYBDL7x
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 06:59:53 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:64265 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbYBDL7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 06:59:53 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2909111wah.23
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 03:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wSKwIDWrDu0XNs5K2Zo39ZJa532Jmcc6wfWbu3PEH/A=;
        b=j2gEwv0yLfciNTClUbcFnIGMiigEkPLK+xwH8Edy6hFiMFuBCiiszuJVDvwLFvdiWJpNa4l1cKPmDHonvhtxBzpYlm04anbFMpJBKriQNjNnkKO9ppfmA6RzZGjK234dX8vDORiuxMN68CIaQNOK8eCOoyr0GnKpAbV9oXnU7rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nhnXq5lAZ2BglyrVEiAhmpNltOjR6Wnm1Lp8v2gULAHLiM4tdWV6om6u7pwZ3FC3To0QKYIOJeaIBjSr24x0LWkrcDXUoS6XWiSLEt3aeaZxMqcUQBkAd1PPHV0LYARLscLjL2UT2NTpYvuMZkgNjj9L1zLUE3B0QInv3fif35k=
Received: by 10.115.74.1 with SMTP id b1mr6798945wal.93.1202126392407;
        Mon, 04 Feb 2008 03:59:52 -0800 (PST)
Received: by 10.115.73.7 with HTTP; Mon, 4 Feb 2008 03:59:52 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802040024030.7372@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72493>

On Feb 4, 2008 1:24 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 3 Feb 2008, Junio C Hamano wrote:
> > For now I haven't picked up any of the "how about this way"
> > revisions.
>
> Yeah, I think all my comments have been addressed...  Lars, care to send a
> new version?

Sure, but we should come to a conclusion on "GITDIR" vs. "GIT_DIR" vs.
"gitdir" vs. "directory" vs. "ref". The reason I used "GITDIR" was to
keep the door open for additional parameters in the "gitfile" (but it
should obviously have been "GIT_DIR" for that usage since its value is
used to specify $GIT_DIR). If it's more likely that we'll use this as
a general substitute for symlinks, I think "ref" is better due to the
existing symbolic refs.

My preference would be "GIT_DIR" (or "git_dir") since we also might
want the "WORKDIR_HASH" Shawn mentioned.

-- 
larsh
