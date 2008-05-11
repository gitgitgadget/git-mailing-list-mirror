From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 1/3] rev-parse: add test script for "--verify"
Date: Sun, 11 May 2008 11:35:33 -0700
Message-ID: <7v4p944rka.fsf@gitster.siamese.dyndns.org>
References: <20080511182710.f653991e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun May 11 20:36:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvGPQ-0000Zx-Lx
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 20:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010AbYEKSfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 14:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757957AbYEKSfl
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 14:35:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757833AbYEKSfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 14:35:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F6194EC4;
	Sun, 11 May 2008 14:35:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 944544EC3; Sun, 11 May 2008 14:35:36 -0400 (EDT)
In-Reply-To: <20080511182710.f653991e.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sun, 11 May 2008 18:27:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0DA9535A-1F89-11DD-9552-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81807>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
> new file mode 100755
> index 0000000..a0d14cb
> --- /dev/null
> +++ b/t/t1503-rev-parse-verify.sh
> @@ -0,0 +1,114 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008 Christian Couder
> +#
> +test_description='test git rev-parse --verify'
> +
> +exec </dev/null
> +. ./test-lib.sh

Who gets stuck by attempting to read from the stdin?  I am wondering if
that belongs to "test-lib.sh"...
