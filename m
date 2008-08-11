From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (GITK BUGFIX)] gitk: Allow safely calling nukefile from a
 run queue handler.
Date: Mon, 11 Aug 2008 13:44:10 -0700
Message-ID: <7vd4kfwacl.fsf@gitster.siamese.dyndns.org>
References: <42d19ab224653b2e6988d7209a8d3e87e19858f8.1218207346.git.christian@jaeger.mine.nu> <200808091313.52528.angavrilov@gmail.com> <217ad8e755d8d51e2ec0f06b4bffa0864976f7e4.1218277122.git.christian@jaeger.mine.nu> <200808091441.50444.angavrilov@gmail.com> <489D7E67.5050205@jaeger.mine.nu> <489F8FAE.2040201@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:45:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSeGV-0001da-HK
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 22:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbYHKUoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 16:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbYHKUoR
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 16:44:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbYHKUoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 16:44:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 877065B809;
	Mon, 11 Aug 2008 16:44:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EED4F5B805; Mon, 11 Aug 2008 16:44:12 -0400 (EDT)
In-Reply-To: <489F8FAE.2040201@jaeger.mine.nu> (Christian Jaeger's message of
 "Mon, 11 Aug 2008 03:02:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 43035C44-67E6-11DD-8B7C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91996>

Christian Jaeger <christian@jaeger.mine.nu> writes:

> I wrote:
>> BTW here's a patch to your patch to make it apply on top of 1.6.0.rc2:
>
> Note to self: how could I be so naive to assume Git didn't offer a
> solution to that. I've missed the -3 option to git am.

Not only that, it is customary to offer gitk and git-gui patches to the
upstream (i.e. not against git.git).  I essentially pull from them and
without ever modifying their parts inside git.git.
