From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Fri, 11 May 2007 13:27:19 +0200
Message-ID: <8c5c35580705110427o4de686e8qdb37f6a2da0043e4@mail.gmail.com>
References: <vpq7irfengj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>, "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 11 13:27:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmTHS-00046u-3S
	for gcvg-git@gmane.org; Fri, 11 May 2007 13:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472AbXEKL1V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 07:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757509AbXEKL1V
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 07:27:21 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:35094 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757472AbXEKL1U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 07:27:20 -0400
Received: by nz-out-0506.google.com with SMTP id o1so954307nzf
        for <git@vger.kernel.org>; Fri, 11 May 2007 04:27:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=YdC9lsW46L2dNv02iikHfx0BBE5PlAwlfgerxV2zjk3ewjcvDYl5bbR0QFuZe/FEMyqkulhFa8u4ozKBk+9TEFHyvYX7O5UPx/3+b+wa3pV/Z/LO4qhK0Sq+68sjxdGuUH5D6HPtEiSNNavLhO/2ntEIzD83VopWvT3MSOZGCb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=M+uENUXKuQPhV2Zyo67h5s34bioJG9dqtMLCzAyQBMWS7/VhPYl63pm4Blj9/PUwyaDFUebMDqvh/Q3f4OnlgM+WIjy+npDfK2VLOiAoz3Gt4Hio/vtAf6MZo9DL+eu7bMJXaOngaEP2NCUeQBYRBJpWVBP3pmyNRf6tkv7IsQM=
Received: by 10.114.124.1 with SMTP id w1mr936094wac.1178882839542;
        Fri, 11 May 2007 04:27:19 -0700 (PDT)
Received: by 10.114.234.19 with HTTP; Fri, 11 May 2007 04:27:19 -0700 (PDT)
In-Reply-To: <vpq7irfengj.fsf@bauges.imag.fr>
Content-Disposition: inline
X-Google-Sender-Auth: d163a4d98438255a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46953>

On 5/11/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Hi,
>
> I'm using git-svn, which usually works fine, but I occasionally get
> this:
>
> $ git-svn dcommit
>         A       file1
>         A       file2
> Network connection closed unexpectedly: Connection closed unexpectedly at /path/to/git-svn line 401

Is this happening if you dcommit a file in a new directory?

The reason I'm asking is that I see the same problem in that
situation, but my svn repo is on a windows box, accessed over
svn://url, so I just assumed it was a problem on the remote end (the
service dies). But the problem always goes away if I commit the new
directory using the svn client before doing git-svn dcommit again....

--
larsh
