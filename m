From: Mike Hommey <mh@glandium.org>
Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 5 Oct 2007 16:30:14 +0200
Organization: glandium.org
Message-ID: <20071005143014.GA18176@glandium.org>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 16:33:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdoE2-0004gz-9h
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 16:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbXJEOcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 10:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbXJEOcN
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 10:32:13 -0400
Received: from vawad.err.no ([85.19.200.177]:37249 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945AbXJEOcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 10:32:12 -0400
Received: from aputeaux-153-1-40-157.w82-124.abo.wanadoo.fr ([82.124.132.157] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IdoDS-00054l-6A; Fri, 05 Oct 2007 16:31:46 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1IdoBy-0004lM-ED; Fri, 05 Oct 2007 16:30:14 +0200
Content-Disposition: inline
In-Reply-To: <20071005142507.GL19879@artemis.corp>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60087>

On Fri, Oct 05, 2007 at 04:25:07PM +0200, Pierre Habouzit <madcoder@debian.org> wrote:
> The option parser takes argc, argv, an array of struct option
> and a usage string.  Each of the struct option elements in the array
> describes a valid option, its type and a pointer to the location where the
> value is written.  The entry point is parse_options(), which scans through
> the given argv, and matches each option there against the list of valid
> options.  During the scan, argv is rewritten to only contain the
> non-option command line arguments and the number of these is returned.
> 
> Aggregation of single switches is allowed:
>   -rC0 is the same as -r -C 0 (supposing that -C wants an arg).

I like options aggregation, but I'm not sure aggregating option arguments
is a good idea... I can't even think of an application that does it.

Mike
