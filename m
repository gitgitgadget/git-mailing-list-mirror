From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 2/2] Rename suffixcmp() to ends_with() and invert
 its result
Date: Tue, 19 Nov 2013 22:04:38 +0100 (CET)
Message-ID: <20131119.220438.1634671089949485179.chriscool@tuxfamily.org>
References: <20131117083930.4177.79411.chriscool@tuxfamily.org>
	<20131119191322.GA4212@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, apenwarr@gmail.com,
	Johannes.Schindelin@gmx.de, peff@peff.net, max@quendi.de, ae@op5.se
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 19 22:04:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VisTW-00028K-O6
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab3KSVEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:04:43 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36043 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053Ab3KSVEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:04:42 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 2B91569;
	Tue, 19 Nov 2013 22:04:39 +0100 (CET)
In-Reply-To: <20131119191322.GA4212@google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238042>

From: Jonathan Nieder <jrnieder@gmail.com>
> Christian Couder wrote:
> 
>> And in vcs-svn/fast_export.c there was already an ends_with()
>> function that did the same thing. Let's used the renamed one
>> while at it.
> 
> Yes, despite the change in signature this shouldn't slow anything
> down.  Thanks.
> 
> For what it's worth,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

To avoid spamming the list again, I am going to send the following
patches from the 86 patch long series to replace prefixcmp() with
starts_with():

[PATCH v2 00/86] replace prefixcmp() with starts_with()
[PATCH v2 01/86] strbuf: add starts_with() to be used instead of prefixcmp()
[PATCH v2 02/86] diff: replace prefixcmp() with starts_with()
[PATCH v2 08/86] transport*: replace prefixcmp() with starts_with()
[PATCH v2 40/86] environment: replace prefixcmp() with starts_with()
[PATCH v2 86/86] strbuf: remove prefixcmp() as it has been replaced with starts_with()

If there are no problems with them, then I will suppose that most of
the patches are ok and probably send them all unless I am asked not
to.

Cheers,
Christian.
