From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 20:45:25 -0400
Message-ID: <9e4733910606091745m103a8f69ieff197b60d3b7597@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
	 <Pine.LNX.4.64.0606091331170.5498@g5.osdl.org>
	 <9e4733910606091356w391b4fdao23db5b2ce3c3e282@mail.gmail.com>
	 <Pine.LNX.4.64.0606091450180.5498@g5.osdl.org>
	 <46a038f90606091637o6a0194d5yb413237253a372fc@mail.gmail.com>
	 <Pine.LNX.4.64.0606091640200.5498@g5.osdl.org>
	 <9e4733910606091700s49018cd5p3b66f8ef51b22d2e@mail.gmail.com>
	 <Pine.LNX.4.64.0606091710560.5498@g5.osdl.org>
	 <9e4733910606091716q67d4c5f9ra807b712d871e562@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 02:45:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ForbW-0006Fo-VD
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 02:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbWFJAp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 20:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbWFJAp3
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 20:45:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:64879 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030566AbWFJAp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 20:45:26 -0400
Received: by nz-out-0102.google.com with SMTP id m7so327138nzf
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 17:45:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pimtk0zycDZs92Xsx7dq2tr2Hyo6+6tvh7T3yElA7OT8xoeFkTPbP+95K7kck1h01H6STnqkPCGf0ACNdNLBDMRFaqXdIRA8jjWOuv9c0R/5nebK1B4kfOgDBoNdlDn+Nzbun4js12vjXyk0DhspdKmBTwhDsOoTYTt2/h0Ajzw=
Received: by 10.36.215.18 with SMTP id n18mr5011282nzg;
        Fri, 09 Jun 2006 17:45:25 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 9 Jun 2006 17:45:25 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <9e4733910606091716q67d4c5f9ra807b712d871e562@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21575>

They must be running some kind of process accounting at my host. As
soon as I hit 500MB RAM I get killed immediately. It is not from a
signal, I'm catching all of those. Maybe some kind of process
accounting.

I get this on the console:
[1]+  Killed
CVSROOT=~/jonsmirl.dreamhosters.com/mozilla/ cvsps -x --norc -A
mozilla >mozilla.cvsps 2>mozilla.cvspserr

and nothing on stdout or stderr.

kernel string:
 2.4.29-grsec+w+fhs6b+gr0501+nfs+a32+++p4+sata+c4+gr2b-v6.189

-- 
Jon Smirl
jonsmirl@gmail.com
