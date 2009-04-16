From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the diff option --no-defaults
Date: Thu, 16 Apr 2009 09:52:50 -0700
Message-ID: <7v4owok0bh.fsf@gitster.siamese.dyndns.org>
References: <1237600853-22815-1-git-send-email-keith@cs.ucla.edu>
 <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de>
 <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu>
 <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de>
 <20090409084903.GA18947@coredump.intra.peff.net>
 <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de>
 <20090410080155.GB32195@coredump.intra.peff.net>
 <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de>
 <20090416083443.GA27399@coredump.intra.peff.net>
 <alpine.DEB.1.00.0904161124000.10279@pacific.mpi-cbg.de>
 <20090416094154.GA30479@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Keith Cascio <keith@CS.UCLA.EDU>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 16 18:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuUra-00088g-Bv
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 18:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757649AbZDPQxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 12:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757048AbZDPQxE
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 12:53:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723AbZDPQxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 12:53:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3AAE6AB361;
	Thu, 16 Apr 2009 12:52:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0B76CAB35C; Thu,
 16 Apr 2009 12:52:51 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 09EDB510-2AA7-11DE-8734-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116712>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 16, 2009 at 11:25:08AM +0200, Johannes Schindelin wrote:
>
>> > This feels very hack-ish to me, but perhaps this is a case of "perfect
>> > is the enemy of the good".
>> 
>> I have a strong feeling that none of our diff/rev options can sanely take 
>> a parameter looking like "--defaults" or "--no-defaults".
>> 
>> But I do not have the time to audit the options.  Maybe you have?
>
> Right now, I think we are safe. A few options like "--default" do take a
> separated string argument, but saying "--default --no-defaults" seems a
> little crazy to me (besides being confusing because they are talking
> about two totally unrelated defaults).

Maybe you guys have already considered and discarded this as too hacky,
but isn't it the easiest to explain and code to declare --no-defaults is
acceptable only at the beginning?
