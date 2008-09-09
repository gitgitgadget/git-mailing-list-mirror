From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/4] receive-pack: make it a builtin
Date: Tue, 09 Sep 2008 16:47:55 +0200
Message-ID: <48C68C9B.8070402@gnu.org>
References: <1220948830-3275-1-git-send-email-gitster@pobox.com> <1220948830-3275-2-git-send-email-gitster@pobox.com> <1220948830-3275-3-git-send-email-gitster@pobox.com> <48C64138.3020406@gnu.org> <7v63p59z3w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 16:50:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd4Wu-0000Or-Ku
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 16:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbYIIOsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 10:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYIIOsI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 10:48:08 -0400
Received: from main.gmane.org ([80.91.229.2]:54599 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbYIIOsG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 10:48:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kd4Ve-000898-SG
	for git@vger.kernel.org; Tue, 09 Sep 2008 14:48:02 +0000
Received: from 195.176.178.209 ([195.176.178.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 14:48:02 +0000
Received: from bonzini by 195.176.178.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 14:48:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 195.176.178.209
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <7v63p59z3w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95391>

>> So how do I
>>
>>         receive-pack = /home/bonzinip/bin/git-receive-pack
>>
>> now?  Using libexec or ".../bin/git receive-pack" is fine, I just would
>> like to know it and see it in the release notes.
> 
> Please check your Makefile (I'm too lazy to double check); don't we
> install these server side programs in $(bindir)?

Yes, I interpreted the obsolete comment in Makefile

# ... and all the rest that could be moved out of bindir to gitexecdir

as s/could be/were/, but there is a special rule in install to place
these in $(bindir).

Paolo
