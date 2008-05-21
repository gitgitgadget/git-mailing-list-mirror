From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: RE: Git-new-workdir
Date: Wed, 21 May 2008 14:30:42 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794301FC8B2B@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794301FC8B1D@emailmn.mqsoftware.com> <20080521184446.GA23924@bit.office.eurotux.com> <MnNeABMJjOQ8gdG6gY5zubSC3c5X2sDYBwcI1MotmXFvW3kUNXzB5A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Luciano Rocha" <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Wed May 21 21:31:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyu2R-0003t5-D2
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 21:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711AbYEUTap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 15:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758459AbYEUTao
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 15:30:44 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:12689 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226AbYEUTao convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 15:30:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <MnNeABMJjOQ8gdG6gY5zubSC3c5X2sDYBwcI1MotmXFvW3kUNXzB5A@cipher.nrlssc.navy.mil>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git-new-workdir
Thread-Index: Aci7eHjpXWeoqcOdTEanbAjJE4i6ggAAExvg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82569>

 

> From: Brandon Casey [mailto:casey@nrlssc.navy.mil] 
> My take on it...
> 
> If you want to have _multiple_different_ branches checked out 
> from the _same_ repository, and do development in all of 
> them, then git-new-workdir is the right choice.
> 
Yes, that's precisely what we want to do.  So according to your
experience, we're making the right choice then.

> If you want to have the _same_branch_ checked out in multiple 
> work directories, then cloning with -s is what you want. In 
> this case I assume development will be performed in the 
> original repo, and the clones will do a pull to update.
> 
Ok, for us this would probably be rare, but good to know.

> Personally, I have found the git-new-workdir script to 
> satisfy any need which caused me to even think about cloning 
> with -s. I am hoping the functionality of git-new-workdir 
> will be folded into git porcelain at some point (ahem J Schindelin).
> 
We'd like that too ;-)

> -brandon
> 
> 

Cheers,
Craig
