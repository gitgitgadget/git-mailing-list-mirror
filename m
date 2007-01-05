From: "Chris Lee" <chris133@gmail.com>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 09:19:35 -0800
Message-ID: <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	 <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
	 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
	 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 05 18:19:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2sjE-0002eN-Bj
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 18:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422629AbXAERTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 12:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422630AbXAERTh
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 12:19:37 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:46105 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422629AbXAERTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 12:19:36 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7144250wxd
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 09:19:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O+iM7A6E/d4EyVv+eu9aWYI4ydV2aw7G+g2D5yky8IbrfvChcYxrnMuXL2drhJotL9I+Q0IRoJGisZcgxWCOZFCWsn1Moyf4NzStuWbddm7lg/KnTLUF0n5lg6zU1tcRofRExRSF7lrbboy8wtVBkxWOlBE+1dslh4S230Awc4c=
Received: by 10.90.68.15 with SMTP id q15mr980077aga.1168017575918;
        Fri, 05 Jan 2007 09:19:35 -0800 (PST)
Received: by 10.90.81.19 with HTTP; Fri, 5 Jan 2007 09:19:35 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <7v1wmalez6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36009>

So, first up:

Using git-verify-pack from master does not fail. It actually does
verify the pack (after a pretty decent wait.) I should have tried
master first before sending out the first mail. :)

It takes about eleven minutes for git-verify-pack to complete, but it
does run to completion. So something that changed between 1.4.1 and
master made everything great again.

I haven't tried git-prune yet, but I'll report back with the results
from that next.

Junio: Did you still want me to try those steps with that patch
anyway, even though it works on master?
