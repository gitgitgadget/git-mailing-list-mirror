From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unexpected git-cherry-pick conflict
Date: Sat, 22 Dec 2007 00:20:38 -0800
Message-ID: <7vsl1vywbt.fsf@gitster.siamese.dyndns.org>
References: <20070405071615.2915.6837.reportbug@acer>
	<20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
	<6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
	<20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0706131354250.4059@racer.site>
	<20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0706131543140.4059@racer.site>
	<20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0707071949440.4093@racer.site>
	<20071221103743.2210.qmail@80f7ec9d6d380d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 09:21:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5zbg-0006lf-6a
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 09:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbXLVIUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 03:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbXLVIUv
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 03:20:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbXLVIUu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 03:20:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AB40E5C12;
	Sat, 22 Dec 2007 03:20:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 24B345C11;
	Sat, 22 Dec 2007 03:20:45 -0500 (EST)
In-Reply-To: <20071221103743.2210.qmail@80f7ec9d6d380d.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Fri, 21 Dec 2007 10:37:43 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69125>

Gerrit Pape <pape@smarden.org> writes:

> On Sat, Jul 07, 2007 at 09:58:08PM +0100, Johannes Schindelin wrote:
>> On Mon, 25 Jun 2007, Gerrit Pape wrote:
>> > Hi, did you get to this yet?, not to stress you, just to make sure we 
>> > don't forget about it.
>> 
>> Okay. Since now both you and Junio asked for it, and I made today a Git 
>> day for me, I looked into this.
>
> Hi, the discussion on this topic unfortunately didn't result in a patch.

I know.  Unfortunately the code structure in merge-recursive
around directory-file conflict handling needs major surgery to
fix this, and it won't be until somebody really sits down and
rethink the issue. I've been quietly working on some ideas and a
small nascent part of it is in 'pu' (or 'offcuts', perhaps, I do
not remember offhand), but it will take time.
