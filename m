From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH] mergetools/meld: Use --help output to detect --output
 support
Date: Fri, 10 Feb 2012 16:30:09 -0600
Message-ID: <20120210223008.GC20703@unpythonic.net>
References: <20120209191742.GA20703@unpythonic.net>
 <CAJDDKr58LV9EDJZP+3S0YfyTOXFgJWD6nm=AiA19MkyBF-wb_g@mail.gmail.com>
 <20120210082106.GA7871@burratino>
 <7vwr7unzs8.fsf@alter.siamese.dyndns.org>
 <20120210215755.GL19216@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 23:30:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvyyx-0006MW-SP
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 23:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760286Ab2BJWaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 17:30:10 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:32817 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753300Ab2BJWaK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 17:30:10 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id 2D4B3218028; Fri, 10 Feb 2012 16:30:09 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20120210215755.GL19216@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190470>

I can confirm that this iteration of the patch (meld --help | grep)
worked for me on meld 1.1.1, meld 1.1.5, and meld 1.3.0.  Note however
that none of these are versions of meld that do support the --output
flag.

Tested-by: Jeff Epler <jepler@unpythonic.net>

Jeff
