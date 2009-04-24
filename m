From: James Cloos <cloos@jhcloos.com>
Subject: Re: [PATCH 1/1] Improve progress display in kB range.
Date: Fri, 24 Apr 2009 18:20:45 -0400
Message-ID: <m3tz4dhewa.fsf@lugabout.jhcloos.org>
References: <cover.1240115957.git.cloos@jhcloos.com>
	<d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
	<alpine.LFD.2.00.0904210054190.6741@xanadu.home>
	<m3skk2szgv.fsf@lugabout.jhcloos.org>
	<alpine.LFD.2.00.0904211319570.6741@xanadu.home>
	<m3d4b5oj76.fsf@lugabout.jhcloos.org>
	<m34owgoj08.fsf@lugabout.jhcloos.org>
	<7vljps324a.fsf@gitster.siamese.dyndns.org>
	<m3ab68mi3q.fsf@lugabout.jhcloos.org>
	<m3zle5hkpa.fsf@lugabout.jhcloos.org>
	<alpine.LFD.2.00.0904241722220.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:25:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxTqF-0003bY-8h
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 00:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837AbZDXWYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 18:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbZDXWYV
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 18:24:21 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:4862 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbZDXWYV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 18:24:21 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 72168401C3; Fri, 24 Apr 2009 22:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1240611860;
	bh=OobdjvJsP7eX0l3pl8r6XqEBBnALs6VJMP/GkaR0xXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=rfVk1ENHm+/6I/XAFaFz0B0U4P8beO1BfWsQXNrY0F4vYCvrTuALnx9xzAx4a5aZl
	 glQp/NXTd/8hFKVwrGNevJVn7AtBA3UqLJtYnXhPoelfEWhZjW4MhkhaLHr6J1Q+Dk
	 hus9HMZXaR9j2MZjIVAn03nUoDh2nn2yhfzo9FyY=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id B276246147; Fri, 24 Apr 2009 22:21:11 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.00.0904241722220.6741@xanadu.home> (Nicolas Pitre's
	message of "Fri, 24 Apr 2009 17:46:15 -0400 (EDT)")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:29:090424:nico@cam.org::jXOtKmUVclKQPTZ9:0000iz5aC
X-Hashcash: 1:29:090424:git@vger.kernel.org::gGaZoOFvJMrjP2ig:00000000000000000000000000000000000000000L1ifw
X-Hashcash: 1:29:090424:gitster@pobox.com::Tn/qLe3CbDf6+Lf0:00000000000000000000000000000000000000000006SF62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117501>

>>>>> "Nicolas" == Nicolas Pitre <nico@cam.org> writes:

>> Will a patch which does round-to-nearest (instead of the current
>> round-to-zero) be accepted?

Nicolas> Sure.  What about this (untested):

Nicolas> +		int x = total + 5243;  /* for rounding */
Nicolas> +		int x = total + 5;  /* for rounding */

That looks correct.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
