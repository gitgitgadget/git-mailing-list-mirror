From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix big left-shifts of unsigned char
Date: Thu, 18 Jun 2009 01:21:52 -0700
Message-ID: <7vbpomymsf.fsf@alter.siamese.dyndns.org>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org>
	<alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de>
	<E1MG32S-0004C6-8A@fencepost.gnu.org>
	<alpine.LFD.2.01.0906142118250.3305@localhost.localdomain>
	<E1MH3bD-0004g2-97@fencepost.gnu.org>
	<alpine.LFD.2.01.0906171543120.16802@localhost.localdomain>
	<alpine.LFD.2.01.0906171654310.16802@localhost.localdomain>
	<alpine.DEB.1.00.0906181012050.4848@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:22:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCt6-0002kw-I8
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbZFRIWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbZFRIWH
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:22:07 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59682 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbZFRIWG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:22:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618082152.WITW25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 18 Jun 2009 04:21:52 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5LMs1c0014aMwMQ03LMsi5; Thu, 18 Jun 2009 04:21:52 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=Gr-KWXMJ2JgA:10 a=CKMB1DcyhXxqZDxC8noA:9
 a=P5AeE36gEMXzT8xiWXwUqY4KtVcA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.DEB.1.00.0906181012050.4848@intel-tinevez-2-302> (Johannes Schindelin's message of "Thu\, 18 Jun 2009 10\:12\:37 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121812>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 17 Jun 2009, Linus Torvalds wrote:
>
>> This is _not_ tested in any way. And I got bored with getting rid of 
>> 'unsigned char' variables, so I by no means did all of them, just the 
>> first few that caugth my grepping eye.
>
> I wonder if there is a mode of 'sparse' which could spot these buggers.

That's a very good meta question ;-)
