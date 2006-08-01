From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Diff format in packs
Date: Tue, 1 Aug 2006 13:03:56 +1200
Message-ID: <46a038f90607311803k2418cd64r2fe7b0f79bd26915@mail.gmail.com>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com>
	 <ealruh$sq9$1@sea.gmane.org>
	 <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
	 <46a038f90607311747j947c786s6af2fe637dbde89d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 03:04:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7ig0-0008Cy-3R
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 03:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWHABD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 21:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWHABD6
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 21:03:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:34758 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751547AbWHABD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 21:03:57 -0400
Received: by nf-out-0910.google.com with SMTP id x30so84787nfb
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 18:03:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZUOmitUQE86wTE/TqnZN0gUebhDQabTy2ucwBLo3mxOcFdoWdICsfx7xQPU8qPwzHC/QbUd0WjL9pT3+dWpyqfFAFb1pa14MOmTwgdTmV73d8jEOSD6/V2Z6beSndHN/RM0Wr78VpsC6kHzf04apC9NkAEHk3Q0APhGKkzOLbWM=
Received: by 10.78.116.19 with SMTP id o19mr84894huc;
        Mon, 31 Jul 2006 18:03:56 -0700 (PDT)
Received: by 10.78.120.17 with HTTP; Mon, 31 Jul 2006 18:03:56 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <46a038f90607311747j947c786s6af2fe637dbde89d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24560>

On 8/1/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> just get all the file versions out of the ,v file and into the GIT
> repo, then do find .git/objects/ -type f | git-pack-objects. You don't
> have to even think of generating the packfile yourself.

Well, that's a bit of a lie, using bare find won't quite work, but if
you look up the "Repacking many disconnected blobs" thread, there's a
good discussion of packing objects that are not related to trees yet.

martin
