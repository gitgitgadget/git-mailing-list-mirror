From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix testcase failure when extended attributes are in
 use
Date: Sun, 19 Oct 2008 22:52:23 -0700
Message-ID: <7vd4hv4xuw.fsf@gitster.siamese.dyndns.org>
References: <20081011154107.GA14994@riemann.deskinm.fdns.net>
 <20081014021016.GB14994@riemann.deskinm.fdns.net>
 <7vbpxig4fb.fsf@gitster.siamese.dyndns.org>
 <20081019122419.GA2015@riemann.deskinm.fdns.net>
 <7viqro73w5.fsf@gitster.siamese.dyndns.org>
 <20081019234723.GB2015@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, heikki.orsila@iki.fi
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Mon Oct 20 14:59:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrnjL-0007wU-Ob
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 07:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbYJTFwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 01:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbYJTFwk
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 01:52:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbYJTFwj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 01:52:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 879E871774;
	Mon, 20 Oct 2008 01:52:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 413BC71773; Mon, 20 Oct 2008 01:52:30 -0400 (EDT)
In-Reply-To: <20081019234723.GB2015@riemann.deskinm.fdns.net> (Deskin
 Miller's message of "Sun, 19 Oct 2008 19:47:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4CA30B94-9E6B-11DD-B150-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98664>

Deskin Miller <deskinm@umich.edu> writes:

> I hope I've made the case for the necessity of a patch (if nothing else, t1301
> fails 10/16 tests on my system without some sort of patch), and I'll happily
> agree that stripping any printable is a better choice.  Thanks for the
> feedback; FWIW, your suggested patch here is
>
> Tested-by: Deskin Miller <deskinm@umich.edu>

Thanks.  Applied to 'maint' and will appear in the next pushout (but not
tonight).
