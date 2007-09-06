From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include a git-push example for creating a remote branch
Date: Thu, 06 Sep 2007 10:42:08 -0700
Message-ID: <7vps0vadxr.fsf@gitster.siamese.dyndns.org>
References: <20070906044408.GA588@spearce.org>
	<buoodggo0l2.fsf@dhapc248.dev.necel.com>
	<20070906050127.GS18160@spearce.org>
	<fc339e4a0709052257m4ddc5784obe64a8b75b79b19@mail.gmail.com>
	<7v8x7ke260.fsf@gitster.siamese.dyndns.org>
	<874pi7dcba.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miles Bader" <miles@gnu.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITLN1-0000gA-H9
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 19:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbXIFRmS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 13:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbXIFRmS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 13:42:18 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbXIFRmR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 13:42:17 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 684B612DBE1;
	Thu,  6 Sep 2007 13:42:32 -0400 (EDT)
In-Reply-To: <874pi7dcba.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	06 Sep 2007 08:48:57 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57914>

Carl Worth <cworth@cworth.org> writes:

> On Wed, 05 Sep 2007 23:30:31 -0700, Junio C Hamano wrote:
>> It is just nobody felt strong enough reason to sugarcoat the
>> normalized syntax with something like:
>>
>> 	git push --create remote foo v1.2.0
>
> Couldn't we just use an initial + to indicate this as well?

Unfortunately, no, because + has already been taken to mean
something completely different.
