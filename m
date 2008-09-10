From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 10:30:59 +0200
Message-ID: <48C785C3.9010204@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 10:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdL7X-0007ik-7K
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 10:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbYIJIbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 04:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbYIJIbF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 04:31:05 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:44125 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbYIJIbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 04:31:04 -0400
Received: by gxk9 with SMTP id 9so13012148gxk.13
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 01:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=leBP8AQuMzURLlJbUnQUiLEM8ekQ5Cepl7zOqqdK+Sc=;
        b=FcKvcQBeKXq6DBPfpqfN6alaqQ0z5+2oFYJUXPzIVNUqYljupLKwv7ld/nVF75sjvs
         /7Ph0tvn/W7FpSA7xLOv/fd1iFTtLoI6iP/vm8lC9JoHepeimHTMqtefn9Gho1bNx1Rt
         TORC3CE57bR8S3vZcc+wsJGJmYEP+l0Ws22z4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=bAzpJoujnn4pERIwE8BUjFhye0s7mWqH649JSUn7yojSsquJ9G/fPF88CO00Gtolce
         E0zq7d09VaXVUZlPjrypo9MvITCWp1og+mtUFRBqdqbpOxTGmHU9P1yjrZkpI1oqdoMo
         WN83OnxBbG/2UYM/J/i++qhCHt6npTB2GnSRo=
Received: by 10.86.26.11 with SMTP id 11mr716598fgz.12.1221035461455;
        Wed, 10 Sep 2008 01:31:01 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id 12sm7025814fgg.0.2008.09.10.01.31.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 01:31:00 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95497>

Linus Torvalds wrote:
> 
> On Wed, 10 Sep 2008, Stephen R. van den Berg wrote:
>> As you might have noticed, the actual process of pulling/fetching
>> explicitly does *not* pull in the objects being pointed to.
> 
> .. which makes them _local_ data, which in turn means that they should not 
> be in the object database at all.

Not really local data.  More like _weakly referenced_ data.  If it is
there, cool.  If it is not there, no big deal.

Paolo
