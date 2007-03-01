From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] defaults for where to merge from (take 3)
Date: Thu, 01 Mar 2007 02:27:14 -0800
Message-ID: <7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
References: <es450f$d58$1@sea.gmane.org>
	<Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
	<45E68897.8000607@lu.unisi.ch>
	<81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
	<45E68EDE.2090405@lu.unisi.ch>
	<81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
	<45E69297.8070001@lu.unisi.ch>
	<81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
	<45E69EEE.8070905@lu.unisi.ch>
	<81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 11:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMiVJ-0003aX-Hj
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 11:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbXCAK1Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 05:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbXCAK1Q
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 05:27:16 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:41290 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964875AbXCAK1P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 05:27:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301102716.RZCU2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 05:27:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VNTE1W0061kojtg0000000; Thu, 01 Mar 2007 05:27:15 -0500
In-Reply-To: <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
	(Alex Riesen's message of "Thu, 1 Mar 2007 11:12:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41076>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 3/1/07, Paolo Bonzini <paolo.bonzini@gmail.com> wrote:
>> > Actually, how about making the default configurable _AND_ have
>> > the --no-track option (for scripting)?
>>
>> Fine by me.  And also --track in case you want to try it out.  ;-)
>
> Ack. Thanks!

Having both --track and --no-track options is a nice touch to
give scripts dependable behaviour.  Well done.

>> Patch attached.  --remove-section will go in a separate patch.
>
> Still think it is a very dangerous operation.

I am going to bed now, but I would appreciate if the list could
help Paolo:

 (1) with styles.  I have only given a cursory look at the
     patch, but I think people already know what I like and not
     like.

 (2) by reviewing the changes to the .config writer.  That
     traditionally has been one of the more fragile parts of the
     system, and I am reluctant to look at it.

 (3) come up with a version that is easier-to-apply (including
     sending an in-line patch).

I would just feel better to see a patch like this, which is a
significant improvement to the system, to be properly signed-off
by the submitter.

Also it would be nice if you guys can fight it out about the
default value for 'tracked'.  I do not think _I_ can defend the
position to create these tracking configurations by default to
old timers (especially the ones that do not follow the git
mailing list), as I am not convinced (not yet, anyway).
