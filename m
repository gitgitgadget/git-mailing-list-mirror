From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cloning fails
Date: Tue, 08 Apr 2008 11:51:05 -0700
Message-ID: <7vbq4kmb8m.fsf@gitster.siamese.dyndns.org>
References: <cb8016980804080600se489c8bv5b79186be284163f@mail.gmail.com>
 <20080408131347.GB22623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Abraham Arce <abraham.arce.moreno@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 08 20:52:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjIvV-0007Uv-9a
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 20:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbYDHSvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 14:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756024AbYDHSvV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 14:51:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965AbYDHSvU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 14:51:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 82DD710EEB;
	Tue,  8 Apr 2008 14:51:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B05DA10EE7; Tue,  8 Apr 2008 14:51:14 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79016>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 08, 2008 at 08:00:20AM -0500, Abraham Arce wrote:
>
>> While cloning git repository
>> 
>> git clone http://www.kernel.org/pub/scm/git/git.git
>> 
>> I've received the following message:
>> 
>> got 33682a5e98adfd8ba4ce0e21363c443bd273eb77
>> error: Couldn't get
>> http://www.kernel.org/pub/scm/git/git.git/refs/tags/gitgui-0.6.0 for
>> tags/gitgui-0.6.0
>> The requested URL returned error: 404
>> error: Could not interpret tags/gitgui-0.6.0 as something to pull
>
> This works just fine for me. Which git version are you using? Does the
> problem still exist if you try again? If that URL did in fact return a
> 404, it sounds more like a kernel.org problem.

Mirroring lag among www servers, methinks.
