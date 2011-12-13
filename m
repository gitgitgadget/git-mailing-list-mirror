From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] connect.c: drop path_match function
Date: Tue, 13 Dec 2011 04:23:30 +0100
Message-ID: <4EE6C532.9060306@alum.mit.edu>
References: <20111213003925.GA28403@sigill.intra.peff.net> <20111213004959.GD3699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kevin Sawicki <kevin@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 13 04:23:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaIy7-0004ZI-Ey
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 04:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab1LMDXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 22:23:37 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46102 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab1LMDXg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 22:23:36 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDFA7.dip.t-dialin.net [84.190.223.167])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBD3NUcK017989
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Dec 2011 04:23:31 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <20111213004959.GD3699@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186999>

On 12/13/2011 01:49 AM, Jeff King wrote:
> I just did the exact-string match inline in the previous patch. I could
> also have modified path_match to do it. But really, I can't think of a
> worse name for a global function in a system which is all about
> managing content in paths. Unless, you know, it actually matched paths.
> Which it doesn't.

The tacit assumption that a reference is always a file is all over the
code and is often confusing.  My

    [PATCH v2 02/51] refs: rename "refname" variables

is a step towards making the distinction more explicit, at least in the
refs code.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
