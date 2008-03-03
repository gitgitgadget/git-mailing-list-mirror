From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] allow git-am to run in a subdirectory
Date: Sun, 2 Mar 2008 22:26:51 -0500
Message-ID: <76718490803021926w29a6a44bha9fd22c48c94250a@mail.gmail.com>
References: <20080301062255.GA27538@coredump.intra.peff.net>
	 <7vprue6ghc.fsf@gitster.siamese.dyndns.org>
	 <20080301081235.GA31855@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 04:27:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW1L2-0003D8-Uy
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 04:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552AbYCCD0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 22:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756514AbYCCD0z
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 22:26:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:44995 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186AbYCCD0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 22:26:54 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1750818ugc.16
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 19:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=z6p4EDD1/guK5yosVTGcKaxl06F7DqVI21+avPlvZjw=;
        b=CqB4BOc0Xx0byXPCScTJfWGK4ivcMRjJkSsLE3W3nhwcOfaURSZSYZ147NOvqN2tKNBQYByk7P1LMJ5ENDEivDZcSE7gLr/rG7qUwU1DpglVY+Ptf4Zp4Z0CGy1I1GIDFMVWlZzbZWOSBSKI+Rjqn1GS5RJ/JchRYb97oYphaE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qjcVbNdo95iYXhp5iKCa4429r31sePAs02ZCeXvW4g/YA+hT34JsFHX3Rwu/65xREquU7l7uq4ffLdrolSuL+pCt5+cxzwqI5WtG/fxxDmZsD4s5fD0O42sA8Q8rFJrTsy+h9+6TBkHLbnhqHyLsV2o1elZ3d0oFvNUywb+yi8g=
Received: by 10.114.126.1 with SMTP id y1mr109668wac.41.1204514811372;
        Sun, 02 Mar 2008 19:26:51 -0800 (PST)
Received: by 10.114.13.5 with HTTP; Sun, 2 Mar 2008 19:26:51 -0800 (PST)
In-Reply-To: <20080301081235.GA31855@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75878>

On Sat, Mar 1, 2008 at 3:12 AM, Jeff King <peff@peff.net> wrote:
>  The problem is that I need to turn the original "$@" into a new "$@"
>  that is correctly prefixed, which requires proper quoting.

Perhaps rev-parse could be taught to optionally convert relative
paths to absolute?

j.
