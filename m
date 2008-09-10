From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 17:37:05 +0200
Message-ID: <48C7E9A1.5080409@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <48C785C3.9010204@gnu.org> <alpine.LFD.1.10.0809100830570.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:38:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdRlq-0002Qt-9E
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 17:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbYIJPhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 11:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYIJPhL
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 11:37:11 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:46922 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbYIJPhK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 11:37:10 -0400
Received: by gxk9 with SMTP id 9so13948264gxk.13
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=u6RlS1FmXmBXjaJ4Qk2klEWdPj9qakhstnNsLklzn/w=;
        b=epkeXkPxEtLlUoIcGpqcYksT6L/Uxlyx7fr8IbS75ARDKGuY/dxpNB1gbRSB+n8TU3
         v7e4S3pjJ5vfh9/7QGd4vDGUBsL822r6sKfVRuhTu6JbGm0tDXGvX0fQcoHEQiW1jvDo
         9eSB3FReiIZdHs/cwzWKseWq0/pnRPz6eOI58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=T/fBB3qTIr0IT5fcC02wQWFhavANPA44mjVt6nL7+U8nY0HeQ//D2yKvNFchYEH2jH
         Q3AHN3KId7keXpmj868/AoY7IufAgSuh509+9UfnH9h2V+lCL9cGALu5oFa0iojv3wnp
         GGhRkE3033yAgvCSVVjn0MtfuE7Zgodz2sYoQ=
Received: by 10.86.95.20 with SMTP id s20mr1067659fgb.49.1221061027550;
        Wed, 10 Sep 2008 08:37:07 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id 12sm7591910fgg.0.2008.09.10.08.37.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 08:37:06 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <alpine.LFD.1.10.0809100830570.3384@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95532>

Linus Torvalds wrote:
> 
> On Wed, 10 Sep 2008, Paolo Bonzini wrote:
>> Not really local data.  More like _weakly referenced_ data.  If it is
>> there, cool.  If it is not there, no big deal.
> 
> You think it's "cool".
> 
> I think it is "unreliable, random, and depends on the phase of the moon".

I think that shallow clones are not any different from this.  If the
required piece of history is there, cool.  If they're not there, no big
deal.

I understood the hyperbole, but I think that it's not unreliable,
because all it relies on is the uniqueness of SHA1 values.

Paolo
