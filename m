From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: Clean up sha1 file writing
Date: Wed, 24 May 2006 20:14:12 +0200
Message-ID: <E1Fixs4-0005pD-10@moooo.ath.cx>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 24 20:14:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FixsA-0005xV-01
	for gcvg-git@gmane.org; Wed, 24 May 2006 20:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWEXSOP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 14:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWEXSOP
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 14:14:15 -0400
Received: from moooo.ath.cx ([85.116.203.178]:28349 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932373AbWEXSOO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 14:14:14 -0400
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20697>

> checking for partial writes
Just out of interest: is this to be safe on any OS or should this
be checked always?

> +		size = write(fd, buf, len);
> +		if (!size)
> +			return error("file write: disk full");
Shouldn't write to a full disk return -1 with ENOSPC?
