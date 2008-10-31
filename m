From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 01:20:24 -0700
Message-ID: <7vtzat89br.fsf@gitster.siamese.dyndns.org>
References: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com>
 <1225429753-70109-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Shawn O Pearce <spearce@spearce.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 09:21:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvpGW-0007fG-IX
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 09:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbYJaIUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 04:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbYJaIUi
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 04:20:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbYJaIUh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 04:20:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F6E7772C9;
	Fri, 31 Oct 2008 04:20:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B26F1772C6; Fri, 31 Oct 2008 04:20:31 -0400 (EDT)
In-Reply-To: <1225429753-70109-1-git-send-email-benji@silverinsanity.com>
 (Brian Gernhardt's message of "Fri, 31 Oct 2008 01:09:13 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CBE5C59C-A724-11DD-ABCE-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99562>

Brian Gernhardt <benji@silverinsanity.com> writes:

> Not all /bin/sh have a builtin echo that recognizes -n.  Using printf
> is far more portable.
>
> Discovered on OS X 10.5.5 in t4030-diff-textconv.sh and changed in all
> the test scripts.

I had an impression that OS X was BSDish.  Wasn't "echo -n" a BSDism?
