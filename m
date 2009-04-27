From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add semicolon to curly brace group in main Makefile
Date: Sun, 26 Apr 2009 23:21:44 -0700
Message-ID: <7vhc0aaa6f.fsf@gitster.siamese.dyndns.org>
References: <1240799808-7340-1-git-send-email-markdrago@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mark Drago <markdrago@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 09:52:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyKFe-0007Cb-EZ
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 08:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbZD0GVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 02:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628AbZD0GVx
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 02:21:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbZD0GVw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 02:21:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 73BBFAD99E;
	Mon, 27 Apr 2009 02:21:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1F6A3AD99D; Mon,
 27 Apr 2009 02:21:46 -0400 (EDT)
In-Reply-To: <1240799808-7340-1-git-send-email-markdrago@gmail.com> (Mark
 Drago's message of "Sun, 26 Apr 2009 22:36:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B21E9B56-32F3-11DE-BD59-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117600>

Mark Drago <markdrago@gmail.com> writes:

> This semicolon is technically required by bash and indeed caused a syntax error
> on a system that I came across running, an admittedly very old, bash-2.04.0.
>
> http://www.gnu.org/software/bash/manual/bashref.html#Command-Grouping
>
> Signed-off-by: Mark Drago <markdrago@gmail.com>

Thanks; it is not specific to bash.  At the end of compound_list before
the Rbrace at the end of brace_group, a separator is required.
