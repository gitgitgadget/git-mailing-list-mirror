From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Re: Can I use git protocol to push change to remote repo?
Date: Tue, 16 Dec 2008 16:59:16 +0800
Message-ID: <856bfe0e0812160059k102cd6a7k8d551f9d20010d62@mail.gmail.com>
References: <856bfe0e0812152318h1375401fx944834ad6410835d@mail.gmail.com>
	 <856bfe0e0812152322i3a7fa376h8a35466b7abf82a5@mail.gmail.com>
	 <20081216073835.GA2468@coredump.intra.peff.net>
	 <856bfe0e0812160048l7d901658tca96f5055c69743c@mail.gmail.com>
	 <20081216085205.GB3031@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 16 10:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCVnB-0003um-4T
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 10:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbYLPI7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 03:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbYLPI7T
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 03:59:19 -0500
Received: from mail-gx0-f12.google.com ([209.85.217.12]:44253 "EHLO
	mail-gx0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYLPI7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 03:59:18 -0500
Received: by gxk5 with SMTP id 5so2300306gxk.13
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 00:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8V1G7cwzBw0yj+4tfvO7fwDws0lLj1o+gp6sqM8an8s=;
        b=L85Wsx+yonjgNslJKfDmMSZYwVUzZWI4pm7HlZ3UmLzKITWnT4vQbkM9J7JKCMKw9r
         uo02Cf4+nALsMY4KiQb8QBt8llMoKZaV7jULD7yjxuQK3Vy8SAzlcKXV0uMF7b3pWNjO
         z6dYbu6g/8XX/sphSqRDoK+KwUfFkxpsN1a2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QQM+SC0b0J3L2keeeLJPGdHg/mwjSV8E7w1Hgbzc9v5hYo4u0xGEgPV1FIvxw4fStm
         M/jr374gr9cZvTndEGqWgxtCsl/XRJdUTfyIbh1NZbVYNQ6OIiC1S6KB9NJUrseWGneR
         0y7AklrhJjJig+F794Gwd1A6H2pdM0RfzvfSM=
Received: by 10.151.157.1 with SMTP id j1mr7595267ybo.89.1229417956948;
        Tue, 16 Dec 2008 00:59:16 -0800 (PST)
Received: by 10.150.225.13 with HTTP; Tue, 16 Dec 2008 00:59:16 -0800 (PST)
In-Reply-To: <20081216085205.GB3031@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103262>

Peff,

Yes, you are  right !  I changed the permission of the repo, and it's OK now. :)

Thank you very much for your kindly help !

Emily

On Tue, Dec 16, 2008 at 4:52 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 16, 2008 at 04:48:34PM +0800, Emily Ren wrote:
>
>> It failed with another error, is there anything I missed to config daemon ?
>> $ git push git://host.xz/testgit test_push2
>> updating 'refs/heads/test_push2'
>>   from 0000000000000000000000000000000000000000
>>   to   eebb60caae38a38361d002cdace043124a2fc871
>> Generating pack...
>> Done counting 3 objects.
>> Deltifying 3 objects...
>>  100% (3/3) done
>> Writing 3 objects...
>>  100% (3/3) done
>> Total 3 (delta 0), reused 0 (delta 0)
>> unpack unpacker exited with error code
>> ng refs/heads/test_push2 n/a (unpacker error)
>> error: failed to push to 'git://host.xz/testgit'
>
> Does the user running git-daemon have permissions to write to the repo?
>
> -Peff
>
