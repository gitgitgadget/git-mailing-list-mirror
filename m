From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 00:24:26 -0400
Message-ID: <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 06:24:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8rEw-0004YO-ES
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 06:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWHDEY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 00:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWHDEY3
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 00:24:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:30750 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030248AbWHDEY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 00:24:28 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1218636nfb
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 21:24:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RX/G4sU1IIKru1+QoL4kp+/CZwYBlLqAi+OR6UNjT6Hlp0x+b72RwUaOQZSAyThtPllN/4q3QUMVQ/X1jExdQzGiosEQHNbGxlK2wPWC61nHo4qEuOhdLWWu4/5F3bOVY1q79FdpYh+usBazFJ/RlPYhMYBE8LFrMUwEfV8FumA=
Received: by 10.78.132.12 with SMTP id f12mr1408570hud;
        Thu, 03 Aug 2006 21:24:26 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Thu, 3 Aug 2006 21:24:26 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24771>

I am converting all of the revisions from each CVS file into git
objects the first time the file is parsed. The plan was to run repack
after each file is finished. That way it should be easy to figure out
the deltas since everything will be a variation on the same file.

So what's the best way to pack these objects, append them to the
existing pack and then clean everything up for the next file? I am
parsing 120K CVS files containing over 1M revs.

After I get all of the objects written and packed later code is going
to write out the trees.

-- 
Jon Smirl
jonsmirl@gmail.com
