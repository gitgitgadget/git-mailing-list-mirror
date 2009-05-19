From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 2/3] commit: add function to unparse a commit and its parents
Date: Tue, 19 May 2009 16:02:25 +0900
Message-ID: <buozld9o9ry.fsf@dhlpc061.dev.necel.com>
References: <20090517153647.6403.44036.chriscool@tuxfamily.org>
	<7v3ab3exht.fsf@alter.siamese.dyndns.org>
	<200905190616.30132.chriscool@tuxfamily.org>
	<7vws8d8y8i.fsf@alter.siamese.dyndns.org>
	<m3r5ylk347.fsf@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 09:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6JLc-00018k-W1
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 09:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZESHCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 03:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZESHCk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 03:02:40 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:43427 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbZESHCj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 03:02:39 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n4J72QKH014846;
	Tue, 19 May 2009 16:02:26 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Tue, 19 May 2009 16:02:25 +0900
Received: from dhlpc061 ([10.114.114.140] [10.114.114.140]) by relay21.aps.necel.com with ESMTP; Tue, 19 May 2009 16:02:25 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 9D4C852E30F; Tue, 19 May 2009 16:02:25 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <m3r5ylk347.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Mon, 18 May 2009 23:35:45 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119496>

Jakub Narebski <jnareb@gmail.com> writes:
>> 	git push $there 04a8c^2:master
>
> First, I have always thought that you cannot push arbitrary SHA-1
> (arbitrary commits) in git; you can only push via refs. Isn't it true?

Hmm, you could try it...

[Pushing random commits has always worked for me though.]

-miles

-- 
The secret to creativity is knowing how to hide your sources.
  --Albert Einstein
