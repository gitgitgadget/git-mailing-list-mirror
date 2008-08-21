From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Wed, 20 Aug 2008 21:45:56 -0700
Message-ID: <7vbpznkmbf.fsf@gitster.siamese.dyndns.org>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
 <20080819132803.GA26201@laptop> <48AADDBB.1080203@viscovery.net>
 <fcaeb9bf0808200958u65ad8fa3oa118b88e16c9c50c@mail.gmail.com>
 <7vfxozpeyh.fsf@gitster.siamese.dyndns.org>
 <237967ef0808201914k2cf8ad09s7b7d56dd8ea35d62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 06:47:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW251-0001id-O1
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 06:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbYHUEqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 00:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbYHUEqJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 00:46:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbYHUEqI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 00:46:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FC6554A14;
	Thu, 21 Aug 2008 00:46:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2857154A13; Thu, 21 Aug 2008 00:45:58 -0400 (EDT)
In-Reply-To: <237967ef0808201914k2cf8ad09s7b7d56dd8ea35d62@mail.gmail.com>
 (Mikael Magnusson's message of "Thu, 21 Aug 2008 04:14:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1102D3D4-6F3C-11DD-B712-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Mikael Magnusson" <mikachu@gmail.com> writes:

> I don't know if i somehow have some weird patch merged in, i tried to check
> and didn't find anything, at least. But when i run git merge -s help i get:

Yes, there are some weird patch in 'next'.  Miklos, could you fix the
output format of that thing?
