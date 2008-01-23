From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-gui: Use gitattribute "encoding" for file content display
Date: Tue, 22 Jan 2008 21:55:05 -0800
Message-ID: <7v7ii1ozly.fsf@gitster.siamese.dyndns.org>
References: <20080123054709.GA13166@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Michele Ballabio <barra_cuda@katamail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 06:56:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHYaj-0006gn-RY
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 06:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbYAWFzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 00:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbYAWFzf
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 00:55:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbYAWFze (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 00:55:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 864AB1376;
	Wed, 23 Jan 2008 00:55:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D57121373;
	Wed, 23 Jan 2008 00:55:23 -0500 (EST)
In-Reply-To: <20080123054709.GA13166@spearce.org> (Shawn O. Pearce's message
	of "Wed, 23 Jan 2008 00:47:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71512>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> git-gui: Use gitattribute "encoding" for file content display
>
> Most folks using git-gui on internationalized files have complained
> that it doesn't recognize UTF-8 correctly.  In the past we have just
> ignored the problem and showed the file contents as binary/US-ASCII,
> which is wrong no matter how you look at it.

Hmmm.

At least for now in 1.5.4, I'd prefer the way gitk shows UTF-8
(if I recall correctly latin-1 or other legacy encoding, as long
as LANG/LC_* is given appropriately, as well) contents without
per-path configuration without introducing new attributes.
