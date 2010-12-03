From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cannot find hash in the log output
Date: Fri, 3 Dec 2010 14:29:24 -0600
Message-ID: <20101203202923.GB15517@burratino>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
 <7v8w07rje3.fsf@alter.siamese.dyndns.org>
 <AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
 <AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
 <20101203175212.GA8267@sigill.intra.peff.net>
 <AANLkTim59JP-fuVTeLwxV0bktbdCq04P8XzxVmbu2Qjd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 21:29:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcGG-0005zc-CS
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 21:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab0LCU3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 15:29:39 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53562 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab0LCU3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 15:29:38 -0500
Received: by qyk11 with SMTP id 11so1274818qyk.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 12:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lEi16IhUaIIvj2cX3ivrpQfn1jlW0YHLQugRz4KbpZY=;
        b=F3mXcYccXrpvMpdT6unBdbr/HoSRGJWpuydLvQ7qPWPQnGYy/Qbi3wTc5DqtWwkK3h
         NqbOOjhjkdiY97Y/LcukhG8k4f2wxX6c7LsnfaW7MiHsYR6zjz6b/uuU3mJl38Z6ckNL
         VvoStPcm75k6Varuw/1I7jggN/Hfdhy1+/Qfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ks2GgaurPRVqo7PRAroMeAgHecwT8dSsG2rSFWaDDtuXinwC3RnHH7D0aeuGJe3dLe
         BL4Wl3/JQDytUBlsLzrtzNy8pf0f9vACEye9pMV5kSVSVc2zVBeFPoq7PsIPWg0gn5og
         rCJa2srsiI5iwOa7B7zfu3OkviYwXDxmD6t5k=
Received: by 10.224.2.146 with SMTP id 18mr1609712qaj.254.1291408177799;
        Fri, 03 Dec 2010 12:29:37 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id u2sm1468633qcq.43.2010.12.03.12.29.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 12:29:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim59JP-fuVTeLwxV0bktbdCq04P8XzxVmbu2Qjd@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162845>

Eugene Sajine wrote:

> Now as this is pretty much clear: don't you think that the information
> about one blob content changed during the merge should be present in
> the merge commit info?

"git rev-list <revs> | git diff-tree --root -c --stdin" might give
some joy.
