From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] make commit --interactive lock index
Date: Thu, 29 May 2008 21:17:01 +0200
Message-ID: <483F012D.3060308@gnu.org>
References: <E1K1eXH-00063c-Bt@fencepost.gnu.org> <alpine.DEB.1.00.0805291343120.13507@racer.site.net> <483EABD8.3050600@gnu.org> <alpine.DEB.1.00.0805291454270.13507@racer.site.net> <483EC079.1050008@gnu.org> <20080529175157.GB5596@steel.home> <483EEF57.6060304@gnu.org> <20080529185617.GC5596@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 21:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1ndN-00038V-4d
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 21:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbYE2TRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 15:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754458AbYE2TRF
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 15:17:05 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:20474 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbYE2TRE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 15:17:04 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2731578mue.1
        for <git@vger.kernel.org>; Thu, 29 May 2008 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=AiXi0AMOe2/hQxcITMVjSeWjWSDMPKBqe+XEt8ofY8w=;
        b=CvqUDmMCrijcFz0ynwg5/IMeJUlVXF98NMdpBwhs/psIV+fdNzOmNE6ZUqWrh2a4BtEUMEbOAamOs/TNN2M0Pf/+lyMOuneIHERxvdufyzNGQCI8wBxvJimTZPOPy6DO5MK5uXqkBrlIhf5NtHyajkB4Tn95rBoiyTstlellOt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=Y6c7u3fRmgHEWA4pCpOj7DUijYP/iLKWS8BzD7kf1nF3mTzlgrsGp/6HydE7tY1cpehZC1rAXX6wwb4GEMAnYqEX4HpzToEYgij4Z0p+2XLVR6cMeaEnmcjz+w16YiZftUF/Nw50B+pcau+eWv2UV8yIsNPprbFxSXn8tDGBlts=
Received: by 10.103.24.11 with SMTP id b11mr3030546muj.77.1212088621181;
        Thu, 29 May 2008 12:17:01 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id u9sm6158569muf.12.2008.05.29.12.16.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 12:17:00 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <20080529185617.GC5596@steel.home>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83240>

Alex Riesen wrote:
> Paolo Bonzini, Thu, May 29, 2008 20:00:55 +0200:
>>>> The "if() die ()" thingie is already in builtin-commit.c, so we won't 
>>>>  ever get a pathspec in the "add --interactive" case.  If we do,   
>>>> something else has already been done incorrectly before -- not by the 
>>>>  user but by the programmer.
>>> What could that be?
>> Nothing, but it documents to whoever reads the code what is the path  
>> that will be taken.  Anyway if it happened it would be very bad.
> 
> Why is a comment not enough?

I tend to use comment if it is more interesting to express the condition 
in English, and asserts if it is more interesting to express it as code.

Paolo
