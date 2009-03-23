From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] check_ref_format(): tighten refname rules
Date: Mon, 23 Mar 2009 09:03:42 -0700
Message-ID: <7vd4c86xb5.fsf@gitster.siamese.dyndns.org>
References: <cover.1237791716.git.gitster@pobox.com>
 <345e795e1891c628ad8356b730fade9f7a81e2f6.1237791716.git.gitster@pobox.com>
 <20090323135901.GB9732@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 17:09:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llmhs-0000Ox-IF
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 17:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759800AbZCWQDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 12:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759864AbZCWQDx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 12:03:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759725AbZCWQDv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 12:03:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AB9DBA4672;
	Mon, 23 Mar 2009 12:03:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 89321A4670; Mon,
 23 Mar 2009 12:03:45 -0400 (EDT)
In-Reply-To: <20090323135901.GB9732@spearce.org> (Shawn O. Pearce's message
 of "Mon, 23 Mar 2009 06:59:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31F3FD9E-17C4-11DE-83CD-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114327>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> This changes the rules for refnames to forbid:
>> 
>>  (1) a refname that contains "@{" in it.
>>  (2) a refname that ends with a dot.
>
> How about also "that end in .lock" ?

Yeah, people can add more as follow-up patches.  The primary purpose of
this series is to clean-up places that the new %name notation (or ~name or
whatever) needs to hook into.
