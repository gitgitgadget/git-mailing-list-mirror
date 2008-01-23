From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 07:56:37 -0500
Message-ID: <20080123125637.GB7415@mit.edu>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <7vabmxqnz8.fsf@gitster.siamese.dyndns.org> <7v63xlqnd0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801231221120.5731@racer.site> <85lk6giv4k.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 13:58:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHfB3-0001LA-7O
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 13:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbYAWM53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 07:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbYAWM53
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 07:57:29 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:35847 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959AbYAWM52 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 07:57:28 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0NCudcJ026470;
	Wed, 23 Jan 2008 07:56:39 -0500 (EST)
Received: from closure.thunk.org (c-66-30-1-139.hsd1.ma.comcast.net [66.30.1.139])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0NCucJw027540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Jan 2008 07:56:38 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JHf9h-0007Pw-U8; Wed, 23 Jan 2008 07:56:37 -0500
Content-Disposition: inline
In-Reply-To: <85lk6giv4k.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71536>

On Wed, Jan 23, 2008 at 01:28:27PM +0100, David Kastrup wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Both issues (and the config variable issue Linus raised) are easily
> > helped with: store not only the hashmap in the extension, but also an
> > identifier for the hash method used.
> 
> For a reasonably implemented hash algorithm, computing the hash should
> be cheaper than reading it from disk.
> 
> So storing precomputed hashes is not worth the trouble.

Yes, but if on Mac OS systems when the git repository is stored on an
HFS+ system, the hash algorithm gets changed to one which forces
Unicode strings which HFS+ happens to "normalize" into the same hash
bucket pre- and post- normalization, it might not be cheap any
more....

       	  	      	    	   	     - Ted
