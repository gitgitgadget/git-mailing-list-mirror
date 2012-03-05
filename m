From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 3/3] Add threaded versions of functions in symlinks.c.
Date: Mon, 5 Mar 2012 12:00:07 +0100
Message-ID: <87eht7pb2g.fsf@thomas.inf.ethz.ch>
References: <cover.1330740964.git.jaredhance@gmail.com>
	<cover.1330785363.git.jaredhance@gmail.com>
	<e86eea36804fcf764ba9c3940a3cceb13b5a2c4b.1330785363.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 12:00:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4VeO-0000aB-0y
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 12:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab2CELAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 06:00:11 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:44512 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756518Ab2CELAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 06:00:10 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 12:00:07 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 12:00:07 +0100
In-Reply-To: <e86eea36804fcf764ba9c3940a3cceb13b5a2c4b.1330785363.git.jaredhance@gmail.com>
	(Jared Hance's message of "Sat, 3 Mar 2012 09:40:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192226>

Jared Hance <jaredhance@gmail.com> writes:

>  int check_leading_path(const char *name, int len)
>  {
> -	struct cache_def *cache = &default_cache;	/* FIXME */
> +    return threaded_check_leading_path(&default_cache, name, len);
> +}

This hunk is indent-by-space damaged.

Otherwise the patch looks good to me.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
