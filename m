From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Set proxy override with http_init()
Date: Wed, 27 Feb 2008 11:18:16 -0800
Message-ID: <7voda2us1z.fsf@gitster.siamese.dyndns.org>
References: <20080227072012.GA23423@glandium.org>
 <1204097780-29581-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 20:19:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURoJ-0001dT-DU
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbYB0TSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 14:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbYB0TSd
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:18:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbYB0TSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 14:18:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 671D416C6;
	Wed, 27 Feb 2008 14:18:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 244CA16C5; Wed, 27 Feb 2008 14:18:25 -0500 (EST)
In-Reply-To: <1204097780-29581-1-git-send-email-mh@glandium.org> (Mike
 Hommey's message of "Wed, 27 Feb 2008 08:36:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75286>

Mike Hommey <mh@glandium.org> writes:

> In transport.c, proxy setting (the one from the remote conf) was set through
> curl_easy_setopt() call, while http.c already does the same with the
> http.proxy setting. We now just use this infrastructure instead, and make
> http_init() now take the proxy url as argument.
>
> At the same time, we make get_http_walker() take a proxy argument too, and
> pass it to http_init(), which makes remote defined proxy be used for more
> than get_refs_via_curl().
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---

Thanks.  I am kicking this to Daniel for a review ;-).
