From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: Replacing strbuf_getline_lf() by strbuf_getline() in wt-status.c
Date: Sat, 30 Jan 2016 23:49:13 +0100
Message-ID: <56AD3DE9.2000004@moritzneeb.de>
References: <56ACC916.8020008@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 23:49:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPeL5-0004ZD-5D
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 23:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbcA3WtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 17:49:16 -0500
Received: from moritzneeb.de ([78.47.1.106]:48605 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756299AbcA3WtP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 17:49:15 -0500
Received: from [192.168.1.11] (x4db33e5e.dyn.telefonica.de [77.179.62.94])
	by moritzneeb.de (Postfix) with ESMTPSA id 5E5FE1C049
	for <git@vger.kernel.org>; Sat, 30 Jan 2016 23:49:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1454194154;
	bh=/8RwVYs5Lopu1vU7YgyMAtOFZqKE1dst4Myp/lMcUP0=;
	h=Subject:To:References:From:Date:In-Reply-To:From;
	b=lvBoNcH/xLN8PY/xZ2SPSLIJMXfXE0YBfkbR/CJAGq0FaED6ADxRQ1uRwA7pr5n/y
	 6YYtHm3DweZ3lMvE5X7veuxNTt8Fz7AztvOroybWjE6IcVJCTr3dadKH6WgQs9pKxT
	 UaVbsoo0TnInXDncORZK0Zb42eLPoV8KBf+/i7yY=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56ACC916.8020008@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285129>

On 01/30/2016 03:30 PM, Moritz Neeb wrote:
> Currently I am working on replacing strbuf_getline_lf() by
> strbuf_getline() in places where the input is trimmed immediately after
> reading, cf. $gmane/284104, "Notes on the remaining strbuf_getline_lf()
> callers", 2nd point.

This thread turned obsolete, as I decided to post a patch to focus the
discussion a bit more:

    http://thread.gmane.org/gmane.comp.version-control.git/285118

-Moritz
