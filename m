From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 18:54:16 +0200
Message-ID: <e5bfff550707150954j6b1fcf6fs66b19d76db8461b1@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
	 <e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
	 <20070715083529.6855a858.seanlkml@sympatico.ca>
	 <e5bfff550707150758h7a9e893frb068d4a9508bc3b2@mail.gmail.com>
	 <20070715110415.33692142.seanlkml@sympatico.ca>
	 <e5bfff550707150858i1825e01clf0897ad4db319373@mail.gmail.com>
	 <20070715121600.792982ef.seanlkml@sympatico.ca>
	 <e5bfff550707150927l745926f0nab04ad82dff913@mail.gmail.com>
	 <20070715123422.9a431506.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jul 15 18:54:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA7MT-0005px-2w
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 18:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759372AbXGOQyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 12:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758777AbXGOQyR
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 12:54:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:22418 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756613AbXGOQyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 12:54:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1308814wah
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 09:54:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=amOqBvF/UOj9Acs0Z6mmwTv4njHDOo3Ewu9ShQqfL8KVEEKgeXJ+AsH23IjRT3slrKd+BHco8+SAZ+YiNQffak1imVM8qMHhqnFQh3WndSiCf5v1dlLREg1wkS+dK2p1DNmxrxCMR7JusTPr7DbACEyJDRjSEBhp3CSh/x1oN2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CcuO66JOUxWQPqmG5coKHpP++qXRUHdZmxBWh1QUasLz36dhV1aU0gVeGg4WN1SVsxd+7ifTUYvZjPp18DWp+4xYjkptjxA5inj7u755JUYTV5bG1+q1dlOrbGVv8NBsYRXr/YRivWNZPksRo1W+NM/V85fRpv8q7u0mDEnm/dM=
Received: by 10.114.175.16 with SMTP id x16mr3419907wae.1184518456190;
        Sun, 15 Jul 2007 09:54:16 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 15 Jul 2007 09:54:16 -0700 (PDT)
In-Reply-To: <20070715123422.9a431506.seanlkml@sympatico.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52572>

On 7/15/07, Sean <seanlkml@sympatico.ca> wrote:
>
> Just tested this case here with "git log --parents --pretty=raw -z -r -p"
> and git prints out: "\ No newline at end of file"  followed by a newline
> and then the NUL.
>

Thanks. I think I will use your scheme so. But I really hope it's a
temporary workaround before git prints sizes with messages.

Thanks
Marco
