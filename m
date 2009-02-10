From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v2] Support "\" in non-wildcard exclusion entries
Date: Tue, 10 Feb 2009 15:37:42 +0100
Message-ID: <20090210143742.GB16478@pvv.org>
References: <20090210121149.GA1226@pvv.org> <alpine.DEB.1.00.0902101354460.10279@pacific.mpi-cbg.de> <20090210125800.GA14800@pvv.org> <alpine.DEB.1.00.0902101402230.10279@pacific.mpi-cbg.de> <20090210142017.GA16478@pvv.org> <alpine.DEB.1.00.0902101525380.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 15:39:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWtll-00053x-Uc
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 15:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbZBJOhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 09:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbZBJOhp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 09:37:45 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:45655 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbZBJOho (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 09:37:44 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LWtk6-00012u-Bx; Tue, 10 Feb 2009 15:37:42 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902101525380.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109247>

On Tue, Feb 10, 2009 at 03:27:43PM +0100, Johannes Schindelin wrote:

> > +
> > +. ./test-lib.sh
> > +
> > +touch \#ignore1 &&
> 
> In other tests, we avoid 'touch' (IIRC it is not available everywhere or 
> some such), and we write ': > \#ignore1' instead.

Will fix it up after seeing if there are some other comments.

> 
> BTW we do not need the # in the name, it could be any letter, right?  
> (Just for my understanding, not as a request to change it.)

So far I have only had to use \ in exclusion rules starting with #,
since they would otherwise be interpreted as comments, but it could be
any character that \ would not change the meaning of. I am not sure
what fnmatch would do with \t, \r and \n for example.

> > +cat >.gitignore <<EOF
> 
> You probably want to use \EOF here.

I am curious, does it matter? Most of the tests use EOF and not \EOF.

- Finn Arne
