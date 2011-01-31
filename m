From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Mon, 31 Jan 2011 15:06:53 -0800
Message-ID: <7vd3nc4qr6.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <201101312244.10047.trast@student.ethz.ch>
 <AANLkTin2kTW85UC1r_1LUDVLiexcVDvt--9ndnXZ2ARS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 00:07:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk2q1-0003kb-HS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 00:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264Ab1AaXHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 18:07:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262Ab1AaXHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 18:07:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C67C4291;
	Mon, 31 Jan 2011 18:07:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0yygbSnPxUz4CySoWCEHMb00ibQ=; b=Vw4HTg
	JbmJ1Ks5R17+SkG989BXbM4nH+xuSjcGe9+yfFCVcQ09A/spb28hIB17hHSncBFf
	T7YUL/E/cudCvcgFq+nEqcLvJqXJds//aZsbic77bDZDEB89YmZIEX+TU4kL8LId
	17S6UXv2/b0IWz+ly2bYXQ8Hv6YwTvEw+6Wy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ScDsxbWtTgWym/L5FOHxLDji8X0eQcT1
	CY1JEpQ1+SZzpXVv1PwRWe6gB1YaNS6ZRaMMS/9K9IofnFua1IHbudGwxCw/SOtD
	ae5IGbLemOiLFrzgPtG4Zag/Njo+s1KkiNyA6jApEIBYzMebG1EFlMN8rtoiGvyL
	/Y/dbFDDnAE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF3AF4290;
	Mon, 31 Jan 2011 18:07:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DEA53428F; Mon, 31 Jan 2011
 18:07:47 -0500 (EST)
In-Reply-To: <AANLkTin2kTW85UC1r_1LUDVLiexcVDvt--9ndnXZ2ARS@mail.gmail.com>
 (Eugene Sajine's message of "Mon\, 31 Jan 2011 17\:27\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EDCDA768-2D8E-11E0-A8A9-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165772>

Eugene Sajine <euguess@gmail.com> writes:

> IMHO there is no need to introduce the variable. If it will start
> update both FETCH_HEAD and the remote-tracking branches since 1.8 it
> will not break any code, because it is added functionality...

Then you didn't understand the risks section, did you?  Thomas clearly
illustrated with an example where the script _expects_ origin/master to
stay the same after "git fetch origin master".
