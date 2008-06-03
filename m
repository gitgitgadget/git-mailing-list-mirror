From: James Cloos <cloos@jhcloos.com>
Subject: Re: git-fetch vs ipv6 routing issues
Date: Tue, 03 Jun 2008 19:56:01 -0400
Message-ID: <m3prqygjiv.fsf@lugabout.jhcloos.org>
References: <m38wxq1hou.fsf@eagle.jhcloos.com>
	<alpine.LRH.1.10.0806010924340.27605@yvahk3.pbagnpgbe.fr>
	<m3wsl6guqg.fsf@lugabout.jhcloos.org>
	<alpine.LRH.1.10.0806032242050.10782@yvahk3.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 01:57:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3gNf-0006Ja-JL
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 01:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbYFCX4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 19:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbYFCX4j
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 19:56:39 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:2876 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYFCX4i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 19:56:38 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 42A6740124; Tue,  3 Jun 2008 23:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1212537397; bh=UWs3Ch7/0W0JQZsMThNF1mich7cVf3BGpBenc91lw
	9g=; h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MwTTaM6wqDwOCH+Xmyma2vCN23gEHad4eS12M
	Wr7J4PfeyMV1/i9hPd0n0X2Hf95MihziV+ksvfAkovRpj58LWInpqW01/WAgiwZraNC
	Zu5JnssW+iWDV5SmO5ttGX1WFOtPHBWD15aIgn64kzcX0F+Y06WMMMyCE59pF8vATdM
	=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 9F3A02103CF; Tue,  3 Jun 2008 23:56:24 +0000 (UTC)
In-Reply-To: <alpine.LRH.1.10.0806032242050.10782@yvahk3.pbagnpgbe.fr> (Daniel
	Stenberg's message of "Tue, 3 Jun 2008 22:50:16 +0200 (CEST)")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2007 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83731>

>>>>> "Daniel" == Daniel Stenberg <daniel@haxx.se> writes:

Daniel> Eeek. I really disagree with this suggestion. CURLOPT_CONNECT_ONLY
Daniel> means you only (TCP or over proxy) connect and nothing more. That
Daniel> would force git to implement a lot of HTTP details that libcurl
Daniel> already provides.

OK.  Then I misread that section of the curl_easy_setopt(3) man page.

I do think git should be able to do this even when compiled against
legacy versions of libcurl, though.

(Of course, even better would be the ability to aviod http altogether.
But some projects I track are only available via http urls....)

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
