From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
 with no changes written
Date: Wed, 3 Feb 2010 10:04:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002031003250.3099@intel-tinevez-2-302>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>  <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>  <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>  <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com> 
 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>  <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>  <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>  <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de> 
 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>  <alpine.DEB.1.00.1002030056480.4985@pacific.mpi-cbg.de> <76c5b8581002021609i4c05d039k35979757fbb74676@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 10:04:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcbAD-00021U-3R
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 10:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756302Ab0BCJEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 04:04:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:41630 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754170Ab0BCJEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 04:04:33 -0500
Received: (qmail invoked by alias); 03 Feb 2010 09:04:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp052) with SMTP; 03 Feb 2010 10:04:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1O6cxym21G55Phv4I0jGFy4NufGnu17RnTWWYfl
	xPIOquFHMZDTZa
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76c5b8581002021609i4c05d039k35979757fbb74676@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68000000000000005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138815>

Hi,

On Tue, 2 Feb 2010, Eugene Sajine wrote:

> > Sorry, your "if message was not saved, abort" is so out of line with 
> > any program I use that this would be highly confusing (maybe 
> > "complicated" was the wrong choice of words).
> 
> Frankly, i think it is in line with "git commit" and that's the only 
> thing that matters here as I have no idea what programs you're talking 
> about.

It's not. 'git commit' will abort if you delete all _and save_. So it is 
not the saving part, it is the deleting all part. And that's exactly how 
rebase -i works, or add -e: if you delete all and save, it aborts.

Ciao,
Dscho
