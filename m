From: Junio C Hamano <gitster@pobox.com>
Subject: Re: renaming a file into a directory causes a pull error on older
 repos
Date: Tue, 18 Mar 2008 23:31:53 -0700
Message-ID: <7vlk4f442u.fsf@gitster.siamese.dyndns.org>
References: <20080316043138.GA7942@kroah.com>
 <7vlk4ganti.fsf@gitster.siamese.dyndns.org> <20080319015156.GA8874@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:42:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4B8-0002JK-AT
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416AbYCSTfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756412AbYCSTfE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:35:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756401AbYCSTfB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:35:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A8F1E2ECD;
	Wed, 19 Mar 2008 02:31:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 27B1A2ECA; Wed, 19 Mar 2008 02:31:55 -0400 (EDT)
In-Reply-To: <20080319015156.GA8874@kroah.com> (Greg KH's message of "Tue, 18
 Mar 2008 18:51:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77513>

Greg KH <greg@kroah.com> writes:

> I've tried to create a simple script to duplicate this problem, and I
> really can not do it at all, including trying to modify the file that
> got clobered by the directory name.  Odd.  I need to look at that repo
> and verify what I did to make sure it wasn't my fault here...

You might have noticed that I've tried it as well.

And it is never your fault.  If git prevented you from trashing your local
modifications, that is a good thing that it errored out.
