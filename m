From: "Eric Raible" <raible@gmail.com>
Subject: Re: RFH: gitk equivalent of "git log -p --full-diff file.cpp"
Date: Mon, 6 Oct 2008 20:45:53 -0700
Message-ID: <279b37b20810062045j1bf7a4b3tf2c246ae8d29b045@mail.gmail.com>
References: <279b37b20810061904n4f50f650l81590cb6fd239282@mail.gmail.com>
	 <20081007022705.GA4496@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, paulus@samba.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 05:47:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn3XM-0003N0-Bz
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 05:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbYJGDpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 23:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753067AbYJGDpy
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 23:45:54 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:45867 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbYJGDpx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 23:45:53 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3169767wfd.4
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AZsQdV2bfIRlzO1UbFG2REACLIEwbleV0aLh8Gq6s7I=;
        b=eo1mXGs3mYz3l4+DpA1v1k00f82aNhOc9hLttk5jpgh5fIADuh6TjcULRvctVeOFS1
         UJEWEZNMdd03duR9I7qROtL0eCRkxwI5DssSSRKDVuSlQCbPQSkU71+maS7ykWk4Hpyn
         OneHpPNO4oisTEy9Zm/sC7Kg9yJvXKOw8J3eU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=crDWoie3FSCSeDwBJR/V6K6JMKs//vq/sqpGpVrdBN+CANjPurfS28HChrEemUGXgI
         4DWAmkUTcywrrOl98tqgF7W1k6533nMz4BMGMTZSqCdCO0mE6TdEmFJYyDCcwfmDCZiD
         ZCqBzpLydOd5tC4mcMg8f90hxJceaopGf7y4c=
Received: by 10.142.154.20 with SMTP id b20mr2344887wfe.222.1223351153111;
        Mon, 06 Oct 2008 20:45:53 -0700 (PDT)
Received: by 10.142.177.12 with HTTP; Mon, 6 Oct 2008 20:45:53 -0700 (PDT)
In-Reply-To: <20081007022705.GA4496@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97662>

On Mon, Oct 6, 2008 at 7:27 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 06, 2008 at 07:04:14PM -0700, Eric Raible wrote:
>
>> Anyway what I'm looking for is the gitk equivalent of:
>>
>>     git log -p --full-diff file.cpp
>
> Try turning off the option "Limit diffs to listed paths" in the
> preferences menu (or adding "set limitdiffs 0" to your ~/.gitk).

Yes, that's exactly what I was looking for.

Thanks - Eric
