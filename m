From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 22:00:25 +0200
Message-ID: <20070716200024.GD16878@cip.informatik.uni-erlangen.de>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <vpqd4yss1vo.fsf@bauges.imag.fr> <469BC17D.60806@slamb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 22:01:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAWki-00016G-SE
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 22:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762654AbXGPUA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 16:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762629AbXGPUA2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 16:00:28 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:56091 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762009AbXGPUA0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 16:00:26 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 16CDC3F435; Mon, 16 Jul 2007 22:00:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <469BC17D.60806@slamb.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52712>

Hello,

> so I think this patch is the best that can be done.

is there a reason why we call unlink and not remove?

	Thomas
