From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] builtin-fetch.c (store_updated_refs): Honor
 update_local_ref() return value
Date: Tue, 27 May 2008 22:43:04 -0700
Message-ID: <7v4p8jx9uf.fsf@gitster.siamese.dyndns.org>
References: <20080527205348.GC32722@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Wed May 28 07:44:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1ESJ-0006mj-Gw
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 07:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbYE1FnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 01:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbYE1FnS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 01:43:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbYE1FnS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 01:43:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B4C9926BA;
	Wed, 28 May 2008 01:43:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2C7A626B7; Wed, 28 May 2008 01:43:13 -0400 (EDT)
In-Reply-To: <20080527205348.GC32722@wo.int.altlinux.org> (Dmitry V. Levin's
 message of "Wed, 28 May 2008 00:53:49 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F877C802-2C78-11DD-A9BF-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83071>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> Sync with builtin-fetch--tool.c where append_fetch_head()
> honors update_local_ref() return value.
>
> This fixes git-fetch exit status,
> http://bugzilla.altlinux.org/show_bug.cgi?id=15037
> ---

Thanks, but we would also want sign-off and tests, wouldn't we?
