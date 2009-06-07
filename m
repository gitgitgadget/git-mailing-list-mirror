From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] symlinks.c: small style cleanup
Date: Sun, 07 Jun 2009 09:30:41 -0700
Message-ID: <7veitwatvy.fsf@alter.siamese.dyndns.org>
References: <1244374385-5253-1-git-send-email-barvik@broadpark.no>
	<alpine.DEB.1.00.0906071616060.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 07 18:30:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDLGk-0006sr-K3
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 18:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbZFGQal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 12:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbZFGQak
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 12:30:40 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56815 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbZFGQak (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 12:30:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090607163042.EHEB18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 7 Jun 2009 12:30:42 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 14Wi1c0014aMwMQ044Wir9; Sun, 07 Jun 2009 12:30:42 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=DnFrL4mDmCYA:10 a=LCWNMYM6zlcA:10
 a=Mmszn6ggPnGju_I_i5EA:9 a=NkS3PNNJkk--3fnv9MoqTlft9twA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.DEB.1.00.0906071616060.26154@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Sun\, 7 Jun 2009 16\:16\:47 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120979>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 7 Jun 2009, Kjetil Barvik wrote:
>
>> Add {}-braces around an else-part, where the if-part already has
>> {}-braces.
>
> This is the wrong way round.  We prefer _not_ to add unnecessary braces, 
> but do tolerate them from time to time.

I am at fault not spelling this out so far, but we prefer to match the
kernel style of having {} around a single-statment "else" body when the
corresponding "if" side needs one (or vice versa).
