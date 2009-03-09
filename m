From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: push problem for new repo on repo.or.cz
Date: Mon, 09 Mar 2009 18:11:21 +0100
Message-ID: <49B54DB9.9010407@drmicha.warpmail.net>
References: <49B53DAF.9080004@drmicha.warpmail.net> <20090309165139.GV8940@machine.or.cz> <alpine.DEB.1.00.0903091758390.6358@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 18:13:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgj2F-0006TH-1L
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 18:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbZCIRLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbZCIRLe
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 13:11:34 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:41751 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751625AbZCIRLe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 13:11:34 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 278DB2EBF3E;
	Mon,  9 Mar 2009 13:11:32 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 09 Mar 2009 13:11:32 -0400
X-Sasl-enc: 2hnI169P0z65G8QfUwySJA0/YhzrVAavt9eA2lWkkHV8 1236618691
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6AFCD3BABA;
	Mon,  9 Mar 2009 13:11:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090305 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0903091758390.6358@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112721>

Johannes Schindelin venit, vidit, dixit 09.03.2009 17:59:
> Hi,
> 
> On Mon, 9 Mar 2009, Petr Baudis wrote:
> 
>> On Mon, Mar 09, 2009 at 05:02:55PM +0100, Michael J Gruber wrote:
>>> I have problems pushing into a new project on repo.or.cz. My user 
>>> (mjg) is added in the admin interface, the key is correct because I've 
>>> been using it for a while already for other projects (forks though). 
>>> I'm using a qualified refspec. What else could be wrong on my side, 
>>> assuming it's not the scripts on repo.or.cz? My git is 1.6.2.
>> your user has actually not been added in the admin interface, please try 
>> again.
> 
> Indeed.  I should have checked before giving a smart-ass answer ;-)
> 
> Note: when adding a user, you have to enter the admin password...  Failing 
> that, you will see exactly the same form, but a red warning saying that 
> the user has not been added.

Uhm, what I had done:

- added the user
- got back the same admin form /which now listed mjg as a user which had
been added/ (with a checkmark)
- after the push failed, went to the form again, hit update again, still
saw mjg listed as a user for the project.

So, there was no red warning, instead there was a confirmation.

OK, I went back now. mjg was not listed any more. Added it (again), now
things work, I'm happy, I shut up.

Well, what may have happened was that the red warning was displayed at
the top of the paage while the confirmation was listed at the bottom.

In any case, thanks for hosting!

Cheers,
Michael
