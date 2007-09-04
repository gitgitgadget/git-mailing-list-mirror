From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Add post-merge hook.
Date: Tue, 04 Sep 2007 13:52:06 -0700
Message-ID: <46DDC576.3080708@midwinter.com>
References: <11885136172952-git-send-email-jjengla@sandia.gov> <7v7inc7hao.fsf@gitster.siamese.dyndns.org> <1188923110.6192.15.camel@beauty> <7vmyw2ny05.fsf@gitster.siamese.dyndns.org> <1188934573.6192.35.camel@beauty> <7vodgimc53.fsf@gitster.siamese.dyndns.org> <1188937975.6192.59.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Josh England <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISfNf-00084F-QP
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 22:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbXIDUwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 16:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbXIDUwI
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 16:52:08 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:35906 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753474AbXIDUwH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 16:52:07 -0400
Received: (qmail 29038 invoked from network); 4 Sep 2007 20:52:06 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=ZboW/NADQlGgOZRDEHqEF8DAcwG6KDr1BIsv3DkoD3mPLui34X189JBAjBj7q2GF  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 4 Sep 2007 20:52:06 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <1188937975.6192.59.camel@beauty>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57644>

Josh England wrote:
> I'm thinking that it
> will be sufficient to pass a flag indicating whether the working tree
> has been modified or not.  The flag can be set for normal merge and
> fast-forward merges, and unset for up-to-dates and squash merges.
>   

Squash merges modify the working tree. In fact, that's *all* they do -- 
they don't commit anything.

-Steve
