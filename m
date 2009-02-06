From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Thu, 05 Feb 2009 21:36:50 -0800
Message-ID: <7vfxis86tp.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de>
 <Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
 <buobptg6tek.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gyles19@visi.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 06:38:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVJQ9-0001x8-L0
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 06:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbZBFFhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 00:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbZBFFhG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 00:37:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbZBFFhE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 00:37:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D3268978F3;
	Fri,  6 Feb 2009 00:36:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4EBED978F2; Fri,
  6 Feb 2009 00:36:51 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B8EB110-F410-11DD-8AFE-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108659>

Miles Bader <miles@gnu.org> writes:

> Joi Ellis <gyles19@visi.com> writes:
>> Because there is no configure script provided, and because my autoconf
>> is considered too old, I simply can't start the build process because
>> I can't generate the missing configure script.
>
> Er, why don't you upgrade to a less ancient version of autoconf...?

Please do not encourage the use of configure/autoconf unnecessarily.

Our Makefile is designed to be usable *without* configure, exactly because
configure/autoconf is often a maintenance (if not portability) nightmare.

Use of configure is tolerated, not encouraged.
