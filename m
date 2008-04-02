From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] add pre-auto-gc hook for git-gc --auto (try2)
Date: Wed, 02 Apr 2008 12:07:46 -0700
Message-ID: <7vtzik848t.fsf@gitster.siamese.dyndns.org>
References: <cover.1207049697.git.vmiklos@frugalware.org>
 <7vhceldv12.fsf@gitster.siamese.dyndns.org>
 <20080402011447.GO3264@genesis.frugalware.org>
 <7vwsngaoqg.fsf@gitster.siamese.dyndns.org>
 <20080402190240.GV3264@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 21:09:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh8Kc-0006Vx-Tk
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 21:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbYDBTIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 15:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756787AbYDBTIF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 15:08:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737AbYDBTIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 15:08:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C05212CAD;
	Wed,  2 Apr 2008 15:07:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E24422CA6; Wed,  2 Apr 2008 15:07:48 -0400 (EDT)
In-Reply-To: <20080402190240.GV3264@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed, 2 Apr 2008 21:02:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78703>

Miklos Vajna <vmiklos@frugalware.org> writes:

> What is your opinion here?
>
> 1) Just don't add such an empty template for pre-auto-gc.
