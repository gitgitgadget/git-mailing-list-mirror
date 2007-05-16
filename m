From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Opinions on bug fix organisation
Date: Thu, 17 May 2007 09:51:55 +1200
Message-ID: <46a038f90705161451v3bf2c04agb95c03f14f236e76@mail.gmail.com>
References: <200705161138.30134.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 23:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoRPe-0003fJ-0t
	for gcvg-git@gmane.org; Wed, 16 May 2007 23:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121AbXEPVv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 17:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759572AbXEPVv5
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 17:51:57 -0400
Received: from ag-out-0708.google.com ([72.14.246.248]:46512 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbXEPVv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 17:51:56 -0400
Received: by ag-out-0708.google.com with SMTP id 23so395470agd
        for <git@vger.kernel.org>; Wed, 16 May 2007 14:51:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YFYxz5SyA0UpWJ3Xlu1gTGpxsQGBFqO9tsmM8mM8hrgtF6/JDYnHxmsQYlK9Di/UvQfImORD+w7GSZAZCjNdAoFJ4iDtmesHiOVG3n21+Gz5NRZWxcPwuia4DWO62s53LDTRJ1r6raUqoDO49yGNK9GZAjUMutZDYwO/m2d7Dgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IMrkxRQ9sQyLC+S55jqOXzLgKP0QHJuyjLXLpIBdwj5lTeSa5+/rSurkDAV3W5ccPPy2EvLVX91+7vAhOqjeRMmlqSQH0mCY6ySItAS+BdBD4uz2opIyRSduXSyUxxPK0zeii5icDtu1uvcfQpkwRZkv+gLmkLdFnkoxAbm5w7M=
Received: by 10.90.118.12 with SMTP id q12mr8946107agc.1179352315666;
        Wed, 16 May 2007 14:51:55 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Wed, 16 May 2007 14:51:55 -0700 (PDT)
In-Reply-To: <200705161138.30134.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47461>

On 5/16/07, Andy Parkins <andyparkins@gmail.com> wrote:
> I quite like option 2 because it records intent - i.e. "I wish I could have
> gone back and changed this revision, but I can't", but it makes a more
> complicated history.

I prefer just letting history show what happened, rather than try to
get too smart about it ;-) -- and use branches and merges for
experimental or feature work. Once a feature or experimental branch is
merged into master, further work happens on master (unless there are
other reasons for it to be maintained).

Bugfixes are part of the life of the maint and master branches.
Imagine your "option 2" being used to maintain git's maint branch.
Some bugs live in the code for 6 months. The merge graph would be
unreadable... and generally the project history would be really hard
to make sense of.

Most "special" practices around branches kind-of work in the
minimalistic case, but break down badly in real-life sized projects...

cheers,


martin
