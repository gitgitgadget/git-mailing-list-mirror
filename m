From: Baz <brian.ewins@gmail.com>
Subject: Re: sha-1 mismatch using command line sha1sum
Date: Tue, 16 Jan 2007 13:50:30 +0000
Message-ID: <2faad3050701160550g2d3fdf56p64b8ae1ea4d4197e@mail.gmail.com>
References: <200701161342.56431.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 14:50:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6oi8-0002U6-22
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 14:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXAPNuf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 08:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXAPNuf
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 08:50:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:13413 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbXAPNue (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 08:50:34 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2406671nfa
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 05:50:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p0iE87lZQ4p62gVoTbgqlGg0kz8s4HTcoo8v6QTTxGxQohm2B+t/SXk2HidxQcKkKHRSYDBtvRszK2ums8e/D0ksOja7kfcC22JaX3mBVL8x9KxNZ7E01S+rTnLw4PI08HbH4eJJkW4nf9oko4ahpecl6PcekJrYvfL+zUVvG60=
Received: by 10.49.29.3 with SMTP id g3mr5883155nfj.1168955430604;
        Tue, 16 Jan 2007 05:50:30 -0800 (PST)
Received: by 10.66.221.1 with HTTP; Tue, 16 Jan 2007 05:50:30 -0800 (PST)
To: "Andy Parkins" <andyparkins@gmail.com>
In-Reply-To: <200701161342.56431.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36937>

On 16/01/07, Andy Parkins <andyparkins@gmail.com> wrote:
> Hello,
>
> I came across this message:
>
> http://www.gelato.unsw.edu.au/archives/git/0504/0212.html
>
> So I thought, "hey that's interesting, I'll try it".  I was surprised to find
> this:
>
> $ sha1sum .git/objects/f4/b6c6b90fdce12d69e4ad80ff6082405ec8cfb8
> ac4c6f1d36d6e0341486789b32f86ae6f506df35  .git/objects/f4/b6c6b90fdce12d69e4ad80ff6082405ec8cfb8
>
> This is in the latest git repository.
>
> Is this correct, or should we all begin screaming and crying that our
> repositories are woefully corrupt? :-)

That changed some time ago. From the git(7) manpage:

"It's worth noting that the SHA1 hash that is used to name the object
is the hash of the original data plus this header, so sha1sum file
does not match the object name for file. (Historical note: in the dawn
of the age of git the hash was the sha1 of the compressed object.)"

Cheers,
Baz
