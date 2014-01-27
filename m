From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] doc: remote author/documentation sections from more pages
Date: Sun, 26 Jan 2014 16:34:51 -0800
Message-ID: <20140127003451.GC9450@google.com>
References: <1390779829-24168-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 27 01:35:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7aAM-0001rz-UU
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 01:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbaA0AfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 19:35:01 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:36453 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbaA0Ae7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 19:34:59 -0500
Received: by mail-bk0-f43.google.com with SMTP id mx11so2487727bkb.16
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 16:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Pam1F8/LWZsa1D4+FwF339vMV/qzbRValI4sbypEFxs=;
        b=KI08jk8gt3HinqcQgWhAcI2xzedA6WAaXN8hTPehHo6BCqz35/tiN3KF6ta6lzzkaF
         iGiXSMAcSDxQQAYgIv9Eiald0S0+Evitr+vwTTVbsXylQYAXv3J8yNv17gSeOereFrBA
         AHNxkDGPN3zSuO5Gj5tMpYZTNoo2tFAwT/+EvzFHKtEZmpZc8mQ7oIX1qz3bifPfBmKl
         bT52v+CbTXEc/VzLz+aikE7c/gcZrRwYTfuMfjGJN0CK+F3kJuibUR2DdifttJHZyZ1/
         9gHT3Y7rQ3bs7qnZ6LQRqV4w4gXonKgtp49DrRWfd1HCuyI/A2K1hxSUMg5530hq04EA
         fTaA==
X-Received: by 10.204.251.67 with SMTP id mr3mr20733739bkb.11.1390782898109;
        Sun, 26 Jan 2014 16:34:58 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id kk3sm11622891bkb.12.2014.01.26.16.34.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 26 Jan 2014 16:34:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390779829-24168-1-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241122>

Michael Haggerty wrote:

> We decided at 48bb914e (doc: drop author/documentation sections from
> most pages, 2011-03-11) to remove "author" and "documentation"
> sections from our documentation.  Remove a few stragglers.

Thanks.

This puts two blank lines where there was previously one in some cases
in the source above the GIT ("part of the git suite") section.  I
don't think that matters.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
