From: James Cloos <cloos@jhcloos.com>
Subject: Re: [RFC PATCH] builtin-log: Add options to --coverletter
Date: Sat, 16 May 2009 13:35:46 -0400
Message-ID: <m3my9dhrw5.fsf@lugabout.jhcloos.org>
References: <1242349041.646.8.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat May 16 19:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5O29-00057w-O8
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 19:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbZEPRsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 13:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbZEPRsu
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 13:48:50 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:1512 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbZEPRsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 13:48:50 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id DA26A400A8; Sat, 16 May 2009 17:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1242496130;
	bh=PzetRuHoq4A331zJbakwE2klHPXRIDDpfOag5jQZHNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=PvHf1nnl/Ub3QYXYl2HKYtUvDquhLrNi95VdJDmnO3Brxg0amPkUMFcsW66aIEH8Y
	 jg/ML/FF3oLrdTfGw0pP39a1LiPyxYVLQJR7TXFD4hxyEI+SxkheUo/3OVvc/ELlSl
	 Ziej/QPn0ANGNPB7Dx2+R1Doa+9DJTCHXdjDtp44=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 7F0BD6354B; Sat, 16 May 2009 17:36:11 +0000 (UTC)
In-Reply-To: <1242349041.646.8.camel@Joe-Laptop.home> (Joe Perches's message
	of "Thu, 14 May 2009 17:57:21 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:29:090516:joe@perches.com::cwEtsT07JRO/BlCc:0CUsg3
X-Hashcash: 1:29:090516:git@vger.kernel.org::Gq3tJu5mxLLWcRCb:00000000000000000000000000000000000000000X/SDu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119369>

>>>>> "Joe" == Joe Perches <joe@perches.com> writes:

Joe> Currently the coverletter options for wrapping long lines
Joe> in the shortlog are: on, wrap as position72, with fixed indents.

Joe> I think these defaults can produce poor looking output.

Joe> This patch allows these to be optionally specified on the
Joe> command line with --cover-letter[=wrap[,pos[,in1[,in2]]]]

Joe> I'm not sure this is the right approach though.

If one wants to be really cool, one could borrow the relevant code from
GNU fmt(1).  (Be sure to grab from a release before the switch to GPL3.)

GNU fmt(1) uses an algorithm based on TeX's and produces *much* better
results than anything else I've seen.

It is currently distributed as part of coreutils.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
