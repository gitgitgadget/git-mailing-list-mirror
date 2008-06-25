From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] factorize pack structure allocation
Date: Tue, 24 Jun 2008 20:22:36 -0700
Message-ID: <7vtzfi6vwj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806241851420.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:23:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLbm-0002iM-2l
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbYFYDWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754852AbYFYDWu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:22:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbYFYDWt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:22:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B697816B4C;
	Tue, 24 Jun 2008 23:22:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1CFF116B4A; Tue, 24 Jun 2008 23:22:44 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FC8F1E88-4265-11DD-B039-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86206>

Nicolas Pitre <nico@cam.org> writes:

> New pack structures are currently allocated in 2 different places
> and all members have to be initialized explicitly.  This is prone
> to errors leading to segmentation faults as found by Teemu Likonen.

Thanks.  This is a much better equivalent to the "probably fixed with
this" patch you sent earlier ;-)
