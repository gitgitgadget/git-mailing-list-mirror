From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Diffing M$-Word
Date: Tue, 04 Aug 2009 21:31:31 +0200
Message-ID: <4A788C93.10402@kdbg.org>
References: <4A70AE1F.7070004@idmcomp.com> <36ca99e90907291345r188a2182n77a2fd5cb55a8bc4@mail.gmail.com> <4A71F2F1.4060605@idmcomp.com> <20090801111227.GA26029@gmail.com> <4A7841BF.5060308@idmcomp.com> <4A7869BD.5010209@lhanke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dr. Lars Hanke" <lars@lhanke.de>
X-From: git-owner@vger.kernel.org Tue Aug 04 21:32:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYPjz-0001UZ-DO
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 21:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbZHDTbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 15:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754503AbZHDTbk
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 15:31:40 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:12286 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405AbZHDTbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 15:31:40 -0400
Received: from [77.119.171.106] (77.119.171.106.wireless.dyn.drei.com [77.119.171.106])
	by bsmtp.bon.at (Postfix) with ESMTP id 2EFA6A7EB3;
	Tue,  4 Aug 2009 21:31:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A7869BD.5010209@lhanke.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124804>

Dr. Lars Hanke schrieb:
> At work I have to write a lot of reports using M$-Word and found that 
> git is capable of managing these in an easy and meaningful way. However, 
> diffing of course does not work. I checked the web for solutions, but 
> somehow, I did not hit the correct search pattern.

I use a dual solution. I defined catdoc as a textconv filter so that I can 
see textual changes in gitk; and I use my winworddiff crude hack that I 
posted here

http://thread.gmane.org/gmane.comp.version-control.git/59288

as a external diff program (note: *not* a difftool). With these, I can 
limp along sufficiently.

-- Hannes
