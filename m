From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 10:45:49 +0200
Message-ID: <48C8DABD.40201@gnu.org>
References: <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl> <20080910151015.GA8869@coredump.intra.peff.net> <20080910215045.GA22739@cuci.nl> <20080910215410.GA24432@coredump.intra.peff.net> <20080910223427.GB22739@cuci.nl> <20080910225518.GA24534@coredump.intra.peff.net> <20080910231900.GF22739@cuci.nl> <48C8A9A4.7030906@gnu.org> <20080911075539.GA27089@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Theodore Tso <tytso@MIT.EDU>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 10:47:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdhpR-0007Rl-Ms
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 10:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbYIKIp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 04:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbYIKIp5
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 04:45:57 -0400
Received: from gv-out-0910.google.com ([216.239.58.186]:43360 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbYIKIp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 04:45:56 -0400
Received: by gv-out-0910.google.com with SMTP id e6so171459gvc.37
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=hmxGs9mnojfynYgkmTYzb7Z1P2O//rPvWMqirQZYG0w=;
        b=BiEap9ifH3sEM7xjs1fUQZjrEB/2BfFZmwlGzVCwOzlvgMe6SBaMXUZhQ+viOCdrBE
         LJ+pdiSUND/8MDdqc6grqeKcbCQrll2KrGOUDuKCIxjHe1MjmMhMbleN/v5bezxJSTna
         gVmEcduwR4Y7bNXWuqoStbkAlFKkEOHzx3VAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=Rht+d5rQy1kHS6xV9s90WoS/BUh3VzuJRqAtdEPeYiYJ4fEvRYZDJeI75dehDux9mD
         0vd2KFiKGerhxiyD3nE1HB8FHzDWIxgsSHZpNzkWMtmeGG42eMAQ2JOpR3QGCpP6lWpr
         UrdVn6/zJQidG8v+1nztX8FWSRI5tFDV9ucZQ=
Received: by 10.86.68.2 with SMTP id q2mr1811891fga.43.1221122752334;
        Thu, 11 Sep 2008 01:45:52 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id d4sm10339586fga.5.2008.09.11.01.45.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 01:45:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080911075539.GA27089@cuci.nl>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95597>


>> I actually like the commit notes idea, but then I wonder: why are the
>> author and committer part of the commit object?  How does the plumbing
>> use them?  Isn't that metadata that could live in the "notes"?  And so,
> 
> we already *have* the non-mutable version of the notes, it's called the
> header of the commit message.

Yes, that was my point.  I don't see how the author and committer fit in
the header of the commit message, if the origin does not.

Paolo
