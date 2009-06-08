From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to pack-objects
Date: Sun, 07 Jun 2009 19:27:03 -0700
Message-ID: <7v1vpva2a0.fsf@alter.siamese.dyndns.org>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
	<alpine.LFD.2.00.0906051224510.3906@xanadu.home>
	<c77435a80906070625i4daaa69bi134df765d7a77cdf@mail.gmail.com>
	<alpine.LFD.2.00.0906071225060.3906@xanadu.home>
	<c77435a80906070947u9bf8ce9m9d59f86e5a5f18ab@mail.gmail.com>
	<c77435a80906071155g5530ccdel286907b7c6022838@mail.gmail.com>
	<alpine.LFD.2.00.0906071637530.3906@xanadu.home>
	<c77435a80906071504u16a46e03w6dfde9a3e694a5ec@mail.gmail.com>
	<alpine.LFD.2.00.0906072043400.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Edelen <sirnot@gmail.com>, sam@vilain.net,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jun 08 04:29:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDUbd-0001R8-Lw
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 04:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbZFHC1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 22:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbZFHC1D
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 22:27:03 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52547 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbZFHC1C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 22:27:02 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608022704.RPYG25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Sun, 7 Jun 2009 22:27:04 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1ET31c00C4aMwMQ04ET35m; Sun, 07 Jun 2009 22:27:04 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=TJDA8ZRpxMcA:10 a=uQz08ezL5i8A:10
 a=6VC1-P1-AAAA:8 a=dsbXSU0wl4HFLZpRhr8A:9 a=ZBcHA4MPsVVJd_gtO0_fh9Vp9igA:4
 a=LRnQQUT8V1QA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.00.0906072043400.3906@xanadu.home> (Nicolas Pitre's message of "Sun\, 07 Jun 2009 20\:50\:24 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121030>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 8 Jun 2009, Nick Edelen wrote:
>
>> man I can sure be blind at times...  alright fixed the latter two
>> comments.  I changed the test file because that particular test wanted
>> upload-pack to fail through the revision walker, which it could only
>> now do if shallow objects were involved.
>
> OK.  However, since now we have 2 different paths for creating object 
> list instead of only one (the existing one in upload-pack and the one in 
> pack-objects), I'd prefer if you could add another test case to make 
> sure the pack-objects path also fails appropriately.
>
> The rest looks fine to me, and with the test issue fixed you could add 
> my:
>
>   Acked-by: Nicolas Pitre <nico@cam.org
>
> to your next submission.  Oh and you might change the subject prefix to 
> [PATCH] as well since I think this won't be WIP anymore.

True and true.  Thanks.
