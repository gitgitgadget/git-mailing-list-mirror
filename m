From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Merge format documented?
Date: Mon, 23 Mar 2009 10:17:07 +0100
Message-ID: <49C75393.3030700@viscovery.net>
References: <200903230419.50000.agruen@suse.de> <7vtz5k99tr.fsf@gitster.siamese.dyndns.org> <200903230818.20044.agruen@suse.de> <7viqm08ymb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 10:19:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlgJN-0008LU-MA
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 10:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366AbZCWJRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 05:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756713AbZCWJRI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 05:17:08 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54391 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981AbZCWJRH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 05:17:07 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LlgHF-0001mE-F1; Mon, 23 Mar 2009 10:17:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7F8216C4; Mon, 23 Mar 2009 10:17:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7viqm08ymb.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114267>

Junio C Hamano schrieb:
> Andreas Gruenbacher <agruen@suse.de> writes:
> 
>> On Monday, 23 March 2009 4:50:24 Junio C Hamano wrote:
>>> Andreas Gruenbacher <agruen@suse.de> writes:
>>>> is the format that git normally uses for indicating merge conflicts in
>>>> files (the <<< === >>> markers) documented somewhere?  How exactly does
>>>> it differ from the diff3 format (<<< ||| === >>>)?  Diff3's -m mode seems
>>>> to come close to what git does, except that git doesn't produce the |||
>>>> section:
>>> It is an imitation of output from "merge" program of RCS suite Paul you
>>> know maintains ;-)
>> So it's the same format except that diff3's ||| section isn't shown. I was 
>> wondering if there are any additional tricks.
> 
> No additional tricks.

I think there's one additional trick: git moves common parts of the
conflict section outside of the conflict markers, and it even splits the
sections into two if there are common parts between two conflicting lines.

(But that doesn't change how the conflict markers look.)

-- Hannes
