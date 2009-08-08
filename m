From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] add missing long options to 'git push bash
 completion'
Date: Sat, 08 Aug 2009 12:50:31 -0700
Message-ID: <7v4osidr08.fsf@alter.siamese.dyndns.org>
References: <9f50533b0908080156n3e990a69lc54e8ab4f0422d0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 21:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZrwL-0000b7-H9
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 21:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbZHHTun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 15:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbZHHTun
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 15:50:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbZHHTun (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 15:50:43 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D19F37F6;
	Sat,  8 Aug 2009 15:50:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABE5A37F4; Sat,  8 Aug
 2009 15:50:37 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C2951656-8454-11DE-B5B2-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125303>

Emmanuel Trillaud <etrillaud@gmail.com> writes:

> according to git-push(1), the following long-options are missing to the bash
> completion :
> --porcelain
> --thin
> --no-thin

Does it even make sense to complete --porcelain in interactive session?

For that matter, I think being able to control --thin/--no-thin outlived
their usefulness.  Have you ever used them to toggle this aspect of the
behaviour per invocation?
