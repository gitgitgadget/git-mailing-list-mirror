From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Enable parallel tests
Date: Fri, 08 Aug 2008 03:33:46 -0700
Message-ID: <7vtzdvdcdx.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vvdycf17a.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808081225000.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 12:35:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRPJC-0004gE-4b
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 12:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbYHHKdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 06:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbYHHKdz
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 06:33:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbYHHKdy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 06:33:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4662250C2D;
	Fri,  8 Aug 2008 06:33:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 41EEC50C2C; Fri,  8 Aug 2008 06:33:48 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808081225000.9611@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Fri, 8 Aug 2008 12:26:20 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7E975886-6535-11DD-805B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91651>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 7 Aug 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > Parallel mode also triggers removal of the trash directory in the test 
>> > itself if everything went fine, so that the trash directories do not 
>> > pile up only to be removed at the very end.
>> 
>> I think making the tests remove their own mess makes sense regardless.
>
> When I add tests, I first run the appropriate t/t*.sh, then expect what is 
> in trash directory, then extend the test.  So at least I need an option to 
> keep the directory.

That's easy.  I do the same as you but do so by disabling "test_done" ;-)
