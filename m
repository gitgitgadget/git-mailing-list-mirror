From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --contains flag to git tag
Date: Thu, 22 Jan 2009 09:17:46 -0800
Message-ID: <7viqo76z0l.fsf@gitster.siamese.dyndns.org>
References: <1232501631-21531-3-git-send-email-goulding@vivisimo.com>
 <4448209.246381232501828959.JavaMail.root@scalix.vivisimo.com>
 <20090121032058.GG21473@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jake Goulding <goulding@vivisimo.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:19:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ3D3-0001oe-RB
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 18:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbZAVRRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 12:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbZAVRRx
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 12:17:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbZAVRRx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 12:17:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C1C2C92B11;
	Thu, 22 Jan 2009 12:17:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5AA4B92B0C; Thu,
 22 Jan 2009 12:17:48 -0500 (EST)
In-Reply-To: <20090121032058.GG21473@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed, 21 Jan 2009 04:20:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A0F2818-E8A8-11DD-8D36-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106774>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Jan 20, 2009 at 08:37:09PM -0500, Jake Goulding <goulding@vivisimo.com> wrote:
>> Please let me know what else I have inevitably messed up, and I shall
>> endeavor to fix and resubmit. 
>
> Please document your improvements in Documentation/git-tag.txt and don't
> forget to add a testcase to t7004-tag.sh.

Thanks for saving me time ;-)
