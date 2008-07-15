From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] index-pack: Honor core.deltaBaseCacheLimit when
 resolving deltas
Date: Tue, 15 Jul 2008 11:48:20 -0700
Message-ID: <7vabgj0yrv.fsf@gitster.siamese.dyndns.org>
References: <20080715031800.GD1700@spearce.org>
 <20080715044534.GA2794@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 20:49:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIpad-0008Ve-Mw
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 20:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbYGOSsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 14:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbYGOSsc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 14:48:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbYGOSsb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 14:48:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DDFE22CA7E;
	Tue, 15 Jul 2008 14:48:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 43F7D2CA78; Tue, 15 Jul 2008 14:48:22 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9DEDBD00-529E-11DD-B75B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88586>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  Version 2 plugs the case Nico noticed, where the patch was causing
>  the exact behavior it was trying to prevent while recovering from
>  what it did to avoid the excessive memory usage in the first place.

Thanks both; it makes sense.
