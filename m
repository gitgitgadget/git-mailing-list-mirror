From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git pull REMOTE" question
Date: Tue, 21 Aug 2007 21:35:59 -0700
Message-ID: <7vy7g4jids.fsf@gitster.siamese.dyndns.org>
References: <fc339e4a0708212123p6e922b4cy3f5f19bfafafa395@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Miles Bader" <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 06:36:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INhx3-0006lb-0N
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 06:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbXHVEgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 00:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbXHVEgN
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 00:36:13 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbXHVEgN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 00:36:13 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 514C4124A2F;
	Wed, 22 Aug 2007 00:36:33 -0400 (EDT)
In-Reply-To: <fc339e4a0708212123p6e922b4cy3f5f19bfafafa395@mail.gmail.com>
	(Miles Bader's message of "Wed, 22 Aug 2007 13:23:52 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56350>

"Miles Bader" <miles@gnu.org> writes:

> Is there a way to set things up so that "git pull REMOTE"
> automatically merges fetched branches when doing a non-default pull?

The branch to be merged currently is determined per branch.
You can just say "git pull usb master".
