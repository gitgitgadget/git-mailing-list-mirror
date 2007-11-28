From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 13:58:59 -0800
Message-ID: <795F24E6-9145-4007-95EB-DB63D9F6295A@midwinter.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>  <7vmyszb39s.fsf@gitster.siamese.dyndns.org>  <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>  <20071128092234.GA12977@diana.vm.bytemark.co.uk> <9e4733910711280713n6b439866m55bea4824efd959@mail.gmail.com> <Pine.LNX.4.64.0711281600320.5349@iabervon.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:59:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUwG-0003go-CS
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 22:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649AbXK1V7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 16:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756360AbXK1V7F
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 16:59:05 -0500
Received: from tater.midwinter.com ([216.32.86.90]:59192 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755966AbXK1V7D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 16:59:03 -0500
Received: (qmail 2393 invoked from network); 28 Nov 2007 21:59:01 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=X4XSQrx1e1WL1MEMXd034DT0j6q8Asj+fIInyM5QGH4pZrd8mRS29n8gcym69Yxd  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 28 Nov 2007 21:59:01 -0000
In-Reply-To: <Pine.LNX.4.64.0711281600320.5349@iabervon.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66434>

On Nov 28, 2007, at 1:47 PM, Daniel Barkalow wrote:
> (That is, "git rebase -i" seems
> to work fine for making changes to a single logical patch series,  
> all of
> whose patches are prepared locally and aren't independantly named in  
> some
> particular fashion; the things that aren't handled are "I need to  
> replace
> the pull of netdev.git with a new pull of netdev.git" or "I need to
> replace '[PATCH] fix-the-frobnozzle-gadget' with
> '[PATCH v2] fix-the-frobnozzle-gadget'.)

I use rebase -i for that last case and it works fine -- I mark the  
appropriate commit as "edit" in the patch list and the rebase stops  
there, at which point I can update the patch in any way I see fit:  
tweak it a bit, replace it with a different change entirely, change  
the commit message, etc. What's missing from rebase -i in that  
respect? I guess it's not as easy to script for automated patch  
replacement.

-Steve
