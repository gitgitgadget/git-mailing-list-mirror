From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: add a -y shortcut for --no-prompt
Date: Sat, 28 Mar 2009 01:56:02 -0700
Message-ID: <7veiwivxel.fsf@gitster.siamese.dyndns.org>
References: <1237962599-29625-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 10:00:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnUPP-0001FX-Fv
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 10:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbZC1I4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 04:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbZC1I4L
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 04:56:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbZC1I4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 04:56:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 730D0A5F0B;
	Sat, 28 Mar 2009 04:56:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7AC20A5F06; Sat,
 28 Mar 2009 04:56:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 46BB4DDA-1B76-11DE-955E-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114941>

David Aguilar <davvid@gmail.com> writes:

> This is another consistency cleanup to make git-difftool's options
> match git-mergetool.
> ...
> @@ -60,11 +60,11 @@ sub generate_command
>  			$ENV{GIT_DIFF_TOOL} = substr($arg, 7);
>  			next;
>  		}
> -		if ($arg eq '--no-prompt') {
> +		if ($arg eq '-y' || '--no-prompt') {

This was the typo that broke 'pu'; I fixed it up and re-queued the series.
