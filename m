From: Clark Williams <clark.williams@gmail.com>
Subject: Re: Odd problem in repository
Date: Tue, 24 Apr 2007 12:53:07 -0500
Message-ID: <462E4403.4070708@gmail.com>
References: <462E3D32.60804@gmail.com> <20070424173048.GA5942@spearce.org> <462E4200.7080206@gmail.com> <20070424174828.GC5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:54:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgPE5-0004bn-6g
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 19:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422936AbXDXRxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 13:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422931AbXDXRxj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 13:53:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:34073 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422910AbXDXRxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 13:53:16 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2293919wxd
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 10:53:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=f0mdr1Oer+cYwzLbqGN+4sXZnKul/xLzG/+MZOcFdvKWZB6Yt3aMF6+EDiWSDRQ23HezSX4rxctTYfLey9/dK338tKdK4I5bDBmt4IFyhhdn7i2iRuFq6hZFCUM9L0oc6OVNSBX8eRlNLFHUVN9nNiXR5aPRy0ZNzc5QiI6Su3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=rcglQBtj2CATfO1NfjAA0xMBicoilAifIxvUQttf7SL4CpbKXX3H/lkbyZ+s/+zmBsLkA7akSM22YWCdnZqLgVdHjiqWa1j+83vw3w9NsuV87qqVae8TnNtcdnHdiLK2NwkQCivAHR+/7t0R2OZP4OzQWmtzYWaZzKoUcaoxEpE=
Received: by 10.70.80.14 with SMTP id d14mr5053919wxb.1177437190605;
        Tue, 24 Apr 2007 10:53:10 -0700 (PDT)
Received: from ?172.16.16.120? ( [66.187.231.200])
        by mx.google.com with ESMTP id h13sm4867456wxd.2007.04.24.10.53.09;
        Tue, 24 Apr 2007 10:53:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <20070424174828.GC5942@spearce.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45481>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Shawn O. Pearce wrote:
> Clark Williams <clark.williams@gmail.com> wrote:
>> But, I'm still confused. After you clone the central repository, with
>> the new layout, why can't I 'mock checkout -f mock-0-6-branch'? Do I
>> need to further qualify it, or create a local branch from it?
> 
> I don't know what the mock command does...  but if you meant:
> 
> 	git checkout -f mock-0-6-branch
> 

Heh, yes that's what I meant.  :)

> then you want to add the origin/ prefix to qualify it, as you want
> the branch from the origin remote.  That should cause your head to
> get detached however:
> 
> 	git checkout -f origin/mock-0-6-branch
> 
> at which point you aren't on any branch at all.  So you might
> want to make your own mock-0-6-branch starting at your origin's
> current version:
> 
> 	git checkout -f -b mock-0-6-branch origin/mock-0-6-branch
> 

Ah, I think that's what I was looking for.

Thanks,
Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFGLkQDqA4JVb61b9cRAt8OAJ9sPWLuiA0n/WKO7EzYH40GhFN0ZgCfY6Mw
J7m60FS67Rj4ESgnVNRfjl8=
=iuic
-----END PGP SIGNATURE-----
