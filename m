From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 19:20:25 -0500
Message-ID: <a4X38z5PMKaSj4KeLKBBqWb9elMD_Pp1n1eMqdmujRqMrr9xtvQAfA@cipher.nrlssc.navy.mil>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com> <20080916233220.GA14173@coredump.intra.peff.net> <alpine.LNX.1.10.0809161738010.17105@suse104.zenez.com> <20080916234624.GA14405@coredump.intra.peff.net> <alpine.LNX.1.10.0809161811100.17105@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Arjen Laarhoven <arjen@yaph.org>,
	git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 02:21:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfknn-00075l-0b
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 02:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbYIQAUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 20:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbYIQAUj
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 20:20:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42475 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYIQAUj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 20:20:39 -0400
Received: by mail.nrlssc.navy.mil id m8H0KP1r030579; Tue, 16 Sep 2008 19:20:25 -0500
In-Reply-To: <alpine.LNX.1.10.0809161811100.17105@suse104.zenez.com>
X-OriginalArrivalTime: 17 Sep 2008 00:20:25.0582 (UTC) FILETIME=[2E5EB8E0:01C9185B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96059>

Boyd Lynn Gerber wrote:

> If I use gdiff or make gnu diff and put it in /usr/local/bin/ and change
> the path to have /usr/local/bin first it does not fail/.
> 
> I have a /usr/gnu/bin/... where I have gdiff linked to diff.

You must have done something like this in the past when you were testing
previous versions since the test_cmp variable has not changed.

So, for future reference either have a diff that understands '-u' in your
path, or set the test_cmp environment variable.

-brandon
