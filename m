From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-merge: fix a typo in an error message
Date: Mon, 27 Apr 2009 09:37:16 -0700
Message-ID: <7vljpm59z7.fsf@gitster.siamese.dyndns.org>
References: <20090413181008.GA8273@linux.vnet>
 <20090413231250.GA16990@genesis.frugalware.org>
 <20090427154151.GA9380@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 18:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyTpe-0007bX-2O
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 18:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261AbZD0QhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 12:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755468AbZD0QhW
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 12:37:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273AbZD0QhV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 12:37:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C08512CEA;
	Mon, 27 Apr 2009 12:37:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8941212CE7; Mon,
 27 Apr 2009 12:37:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AE06CDDA-3349-11DE-AE91-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117690>

Allan Caffee <allan.caffee@gmail.com> writes:

> Hello Junio,
>
> On Tue, 14 Apr 2009, Miklos Vajna wrote:
>
>> On Mon, Apr 13, 2009 at 02:10:08PM -0400, Allan Caffee <allan.caffee@gmail.com> wrote:
>> > -		die("Could open %s for writing", git_path("MERGE_MSG"));
>> > +		die("Could not open %s for writing", git_path("MERGE_MSG"));
>> 
>> Acked-by: Miklos Vajna <vmiklos@frugalware.org>
>
> Is this one ready for maint?  (The issue dates back to 1c7b76be.)

Indeed it is; I do not know how this one slipped.

Thanks.
