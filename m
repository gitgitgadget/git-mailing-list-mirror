From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-add --intent-to-add (-N)
Date: Thu, 21 Aug 2008 22:59:26 -0700
Message-ID: <7vtzddd1z5.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7viqtukbec.fsf@gitster.siamese.dyndns.org>
 <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org>
 <Pine.GSO.4.62.0808211608020.26161@harper.uchicago.edu>
 <Pine.GSO.4.62.0808212304200.9108@harper.uchicago.edu>
 <alpine.LNX.1.00.0808220023170.19665@iabervon.org>
 <Pine.GSO.4.62.0808220015190.11259@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Fri Aug 22 08:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWPhN-00072r-Ma
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 08:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbYHVF7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 01:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbYHVF7e
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 01:59:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbYHVF7d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 01:59:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AA3EE67FA0;
	Fri, 22 Aug 2008 01:59:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E3BA867F9F; Fri, 22 Aug 2008 01:59:28 -0400 (EDT)
In-Reply-To: <Pine.GSO.4.62.0808220015190.11259@harper.uchicago.edu>
 (Jonathan Nieder's message of "Fri, 22 Aug 2008 00:32:01 -0500 (CDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7DB54948-700F-11DD-A665-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93256>

Jonathan Nieder <jrnieder@uchicago.edu> writes:

> Wait, is [1/3] meant to create that strong of an illusion?  That is,
> should has_sha1_file pretend the object is present, too?

AFAIR has_sha1_file() is actually used to write out the object for real
after you have been pretending it exists, so no.

Didn't I already tell you that you seem to have picked only one out of _three_
patch series?
