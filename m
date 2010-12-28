From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] cherry-pick/revert: add support for
 -X/--strategy-option
Date: Tue, 28 Dec 2010 13:37:00 -0600
Message-ID: <20101228193700.GA4303@burratino>
References: <20101211005144.GA6634@burratino>
 <20101227212515.GA32352@burratino>
 <7v7hetyeom.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Justin Frankel <justin@cockos.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 20:37:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXfMU-0000Rd-Oq
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 20:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab0L1Th3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 14:37:29 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33183 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab0L1Th2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 14:37:28 -0500
Received: by vws16 with SMTP id 16so3918989vws.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 11:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GXtkpPxGm5FWKAtT2zcXG6KcdR0EOAL3S14pUhvnwIE=;
        b=nom3vV0mtbQW4Dr7kgElL7NVyi6fbPMOyz2pfasfCiuD1lyppNSGUdOSA2SPyDpgQp
         a0mGkdkIdbGoyCHIfE6cw+LKmuQEjXJ0/4i8f4DCzt+JnppTmcE5Bz3tcw+1rVKZ01cs
         q+zrvLdFoO9Pjx9HBWlcyy/vjaAwUl+jrfBsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mBMZts90kbBAZTep1Sl0g4aNEh+J16oseuvKt6huvqfCG0d6JQEGk4fl5cPnuC34cx
         DK4lbg2WPck29JTa+FvHnU9/pKJec+f979+Fq7MkNr6f8nrx0klQbM0ObqkUVKXITh+3
         G9f16jHn5YnnAsEm3pHDS6i0CeUX41f7cYl8Y=
Received: by 10.220.201.76 with SMTP id ez12mr4182929vcb.201.1293565047998;
        Tue, 28 Dec 2010 11:37:27 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id b6sm2706995vci.0.2010.12.28.11.37.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 11:37:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v7hetyeom.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164286>

Junio C Hamano wrote:

> Pong, if you are pinging me.  I thought you wanted to only discuss it
> first with RFC and meant to follow up on a real-for-inclusion patch.

You thought correctly.  In this case I can't think of any change this
needs on top to make this real for inclusion so I just bumped the
thread.

There were two hints at improvements in this thread (separate topic):
the "git merge" manual could use some discussion of the distinction
between --renormalize and --ignore-whitespace-at-eol, and am, rebase,
stash, and "checkout -m <tree>" ought to have -X plumbed, too.
