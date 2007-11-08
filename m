From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit: cleaning up after using git branch delete commands
Date: Thu, 8 Nov 2007 09:18:35 +0000
Message-ID: <b0943d9e0711080118q47441844hc25758f733e9af65@mail.gmail.com>
References: <9e4733910711070606t2c558ac9ob4c729d5baca8fb9@mail.gmail.com>
	 <tnxwssuyug1.fsf@pc1117.cambridge.arm.com>
	 <9e4733910711070811y72f96a90i4db9acdf93aa765c@mail.gmail.com>
	 <20071108055302.GA11230@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3Xx-0007aP-UF
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757578AbXKHJSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 04:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757285AbXKHJSh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:18:37 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:41001 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757578AbXKHJSf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 04:18:35 -0500
Received: by rv-out-0910.google.com with SMTP id k20so93406rvb
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 01:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DX95RKi0H+keY0z841mxUkj9NNIanI+1JabjD4hmnUM=;
        b=rKpGN+1b5r5JUs4Hi4jZsHkBZ9Otxhr0p67UdqfVM03q4Ffi+L1bdoxMC7a/YmQTHRUngT9aRS9kqs8y80gWk+VZv/qYMlyvWwhcKgTTv5acOihSD/zjFMHVnoRQSqJiOct3QDcUFvvGhas+896ADh1rvKafqMXbQtPdvtp16Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B9QnvKX5dFw8wv0fYr5QP5g3U9EDSSHYgTAKqUvPPbEjtRt71CFu4WlmxySDuAV57T/1Z5RpPjkAzJEcf0UUVrHrRQvHDSzs6TNJUWJr27JXk7TjbZhMaigtqsDVQabr9ghAD+F6JLBVdZZXMaMna38Xz3idhxgN+oCRMNqh5BM=
Received: by 10.140.163.3 with SMTP id l3mr133018rve.1194513515166;
        Thu, 08 Nov 2007 01:18:35 -0800 (PST)
Received: by 10.140.170.16 with HTTP; Thu, 8 Nov 2007 01:18:35 -0800 (PST)
In-Reply-To: <20071108055302.GA11230@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63973>

On 08/11/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-11-07 11:11:42 -0500, Jon Smirl wrote:
>
> > how about a 'stg gc' command that gets rid of all the inaccessible
> > clutter?
>
> "stg assimilate" already has the job of fixing up stuff after the use=
r
> has used git commands to move HEAD around. I think it would make sens=
e
> to teach it to do this too -- and then rename it "stg repair" or
> something. That way, there's one command to fix every kind of "damage=
"
> that git can do to stgit.

"repair" sounds better than "gc" (which might also be confused with
the "git gc" command).

> Alternatively, "stg branch --create" and "stg init" and whoever else
> is bothered by the clutter could simply remove it themselves. That
> would be even more user-friendly, I guess.

I did some fixes for branch --delete but, since I use StGIT almost
exclusively, haven't thought that we need to relax the branch creation
as well.

--=20
Catalin
