From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Sat, 06 Dec 2008 19:45:35 -0800
Message-ID: <7vwsecejhc.fsf@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
 <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
 <20081128192033.GF23984@spearce.org>
 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0811281938250.19665@iabervon.org>
 <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>
 <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>
 <alpine.LNX.1.00.0811301509070.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Dec 07 04:47:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9AcB-0005Ka-0N
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 04:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbYLGDqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 22:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbYLGDqH
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 22:46:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbYLGDqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 22:46:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DCDC218471;
	Sat,  6 Dec 2008 22:46:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 405151847F; Sat, 
 6 Dec 2008 22:45:47 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0811301509070.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 30 Nov 2008 16:26:19 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 924BE834-C411-11DD-A122-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102488>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> As I said, CE_VALID implies all files are present.
>
> My first question is whether this actually should be true.

If the user says "Please pretend that I have never touched this file",
which is what "assume unchanged" is all about, I think we should not
notice if the user removes one of such files from the working tree, just
like we don't notice (rather, pretend not to notice) if the user modified
it.

I am inclined to think that we should rather treat that as a bug.
