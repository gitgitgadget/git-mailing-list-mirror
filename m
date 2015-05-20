From: Faheem Mitha <faheem@faheem.info>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 23:54:01 +0530 (IST)
Message-ID: <alpine.DEB.2.11.1505202341170.9343@orwell.homelinux.org>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org> <vpq382rkvzf.fsf@anie.imag.fr> <d21002e0fa92b03c3d417c8996328563@www.dscho.org> <CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 20 20:24:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv8fB-0002qw-Rh
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 20:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbbETSYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 14:24:13 -0400
Received: from rs145.luxsci.com ([64.49.212.113]:51056 "EHLO rs145.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbbETSYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 14:24:12 -0400
Received: from orwell.homelinux.org (triband-mum-59.183.37.231.mtnl.net.in [59.183.37.231])
	(authenticated bits=0)
	by rs145.luxsci.com (8.14.4/8.14.9) with ESMTP id t4KIO9IX003695
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 20 May 2015 14:24:11 -0400
Received: from faheem (helo=localhost)
	by orwell.homelinux.org with local-esmtp (Exim 4.84)
	(envelope-from <faheem@faheem.info>)
	id 1Yv8f1-0001Yx-42; Wed, 20 May 2015 23:54:07 +0530
X-X-Sender: faheem@orwell.homelinux.org
In-Reply-To: <CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-Lux-Comment: Message t4KIO9IX003695 sent by user #87163
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269488>


Hi Stefan,

Thank you for the reply, but I don't follow what conclusion you are 
drawing, if any.

On Wed, 20 May 2015, Stefan Beller wrote:

> $ git clone https://github.com/fmitha/SICL
> cd SICL
> $ git show 280c12ab49223c64c6f914944287a7d049cf4dd0
> fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4dd0
> $ git show 12323213123 # just to be sure to have a different error
> message for non existing objects.
> fatal: ambiguous argument '12323213123': unknown revision or path not
> in the working tree.
>
> $ mv .git/objects/pack/pack-d56da8c18f5aa915d7fe230efae7315a0101dc19.pack .
> $ rm .git/objects/pack/pack-d56da8c18f5aa915d7fe230efae7315a0101dc19.idx
> $ git unpack-objects < pack-d56da8c18f5aa915d7fe230efae7315a0101dc19.pack
> $ git show 280c12ab49223c64c6f914944287a7d049cf4dd0
> fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4dd0
> $ ls .git/objects/28/0*
> .git/objects/28/01fef08b1dccf9725dde919a7373748a046cb7
> .git/objects/28/03d8c1cb3275979ff2d8408450844f6a78a70d
> .git/objects/28/0663a93d702a7fcb0dd36f461397f6b50ba01e
> .git/objects/28/068e2656dd4bac61050e870712578032af9144
> .git/objects/28/074e890d6ff2bb61eb7796bc500b6d8e344ad2
> .git/objects/28/08596ac465cf8a819a9b13ad2f855e9a8a3235
> .git/objects/28/098184d1ba97453227c18628cdf13087b6bce2
> .git/objects/28/0ba19c68b26ee7c799ef8ca09d540a5ad7a5b2
> .git/objects/28/0d66213173f0ae7aaae8684f3efcb1f8790792
> .git/objects/28/0da35374c32303cbd726bef9847f18d7428d5e
>
> There is no file 28/0c... however.

So, is the repos corrupt or not? Also, I don't understand why you say

     There is no file 28/0c... however.

Why would you expect there to be? I don't see it mentioned in that list.

I apologise for my ignorance. I don't really know anything about git. I 
just happened to encounter this error.

                                                   Regards, Faheem Mitha
