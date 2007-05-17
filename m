From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 02:09:29 +1200
Message-ID: <46a038f90705170709j7eb23d4fy6811fc2985dd888d@mail.gmail.com>
References: <20070515201006.GD3653@efreet.light.src>
	 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
	 <Pine.LNX.4.64.0705161232120.6410@racer.site>
	 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
	 <Pine.LNX.4.64.0705170152470.6410@racer.site>
	 <vpq8xbnlmdv.fsf@bauges.imag.fr>
	 <46a038f90705170610mf9c9b0eu7b40af709469a601@mail.gmail.com>
	 <Pine.LNX.4.64.0705171445100.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 17 16:09:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hogfh-00079H-KW
	for gcvg-git@gmane.org; Thu, 17 May 2007 16:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbXEQOJc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 10:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755946AbXEQOJc
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 10:09:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:35360 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930AbXEQOJb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 10:09:31 -0400
Received: by wx-out-0506.google.com with SMTP id h31so551772wxd
        for <git@vger.kernel.org>; Thu, 17 May 2007 07:09:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FZd2KNtGPrgYrIw9tMfavtw10CS5HY691Ed9GAuSY5r/NUd4aJyicgJZBBkvbxbIYu8Gut4e6qEbRaeeZaH4Ez4IZFZkImJRogs6tHp1gngpN09ZGlYeXr890Z7JEApOvDLdUMwc58c2d0/9UbVow5pVIYDAroFMhVFu2OwF1o8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ioATR2l/eQL9sJUi/ZhnMQoZUQnbqKv81X77KJhQCD/8SM3qUDe3bccljGBAgc9ML7tlrDofxWpwoQtoUoB60hvmxMI5YzfNnBbruEh5Hl2xqeJ3ubSCvl9Uzfg8f2/4lpqCu/dwCpa5uKKB6u2bBZnOLNn5geaMFU2X58iejlk=
Received: by 10.90.116.6 with SMTP id o6mr456034agc.1179410969089;
        Thu, 17 May 2007 07:09:29 -0700 (PDT)
Received: by 10.90.75.15 with HTTP; Thu, 17 May 2007 07:09:29 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705171445100.6410@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47525>

On 5/18/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> If you have a solution for that problem, please enlighten me: I don't.

Ok - worst case scenario - have a minimal hints file that tells me the
ranges to fetch all commits and all trees. To reduce that Add to the
hints file data to name the hashes (or even better - offsets) for the
delta chains that contain commits+trees relevant to all the heads -
minus 10, 20, 30, 40 commits and 1,2,4,8 and 16 days.

So there's a good chance the client can get the commits+trees needed
efficiently. For blobs, all you need is the index to mark the delta
chains you need.

cheers,


m
