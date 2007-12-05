From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git config: Don't rely on regexec() returning 1 on non-match
Date: Wed, 05 Dec 2007 11:34:40 -0800
Message-ID: <7vy7c9orzj.fsf@gitster.siamese.dyndns.org>
References: <1196867484-22188-1-git-send-email-B.Steinbrink@gmx.de>
	<Pine.LNX.4.64.0712051513570.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 05 20:35:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J001V-0006wj-0z
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbXLETet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbXLETet
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:34:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60745 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbXLETes (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:34:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C266E2F2;
	Wed,  5 Dec 2007 14:35:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CBD49D3D0;
	Wed,  5 Dec 2007 14:35:04 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712051513570.27959@racer.site> (Johannes
	Schindelin's message of "Wed, 5 Dec 2007 15:14:11 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67184>

Thanks.  I'll apply but http://git.pastebin.com/m24a4e277 feels somewhat
safer and less intrusive.
