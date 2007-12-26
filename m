From: David Brown <git@davidb.org>
Subject: Re: [PATCH] git-send-email: Generalize auto-cc recipient mechanism.
Date: Tue, 25 Dec 2007 19:39:29 -0800
Message-ID: <20071226033929.GA29406@old.davidb.org>
References: <1198216860-487-1-git-send-email-git@davidb.org> <1198532163-25308-1-git-send-email-git@davidb.org> <7vk5n2o58p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org, Joel Becker <Joel.Becker@oracle.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 04:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7N7d-0004i3-Os
	for gcvg-git-2@gmane.org; Wed, 26 Dec 2007 04:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbXLZDjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2007 22:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbXLZDjd
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Dec 2007 22:39:33 -0500
Received: from mail.davidb.org ([66.93.32.219]:59394 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbXLZDjd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2007 22:39:33 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J7N7B-00081R-UI; Tue, 25 Dec 2007 19:39:29 -0800
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Joel Becker <Joel.Becker@oracle.com>
Content-Disposition: inline
In-Reply-To: <7vk5n2o58p.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69239>

On Tue, Dec 25, 2007 at 01:04:54PM -0800, Junio C Hamano wrote:

>+# If explicit old-style ones are specified, they trump supress-cc
>+if (defined $suppress_from) {
>+	$suppress_cc{'self'} = $suppress_from;
>+}
>+if (defined $signed_off_cc) {
>+	$suppress_cc{'sob'} = !$signed_off_cc;
>+}

This changes the default behavior to --no-signed-off-cc, if nothing is
specified.  I'll see if I can add something that will set that if no
suppress-cc's are set.

Patch to follow shortly.

David
