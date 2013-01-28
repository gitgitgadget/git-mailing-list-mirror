From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Sun, 27 Jan 2013 18:08:59 -0800
Message-ID: <7v38xm12kk.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:09:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzeA1-0004y2-LT
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 03:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801Ab3A1CJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 21:09:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab3A1CJC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 21:09:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1803CCA58;
	Sun, 27 Jan 2013 21:09:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=34vKWMajK1XFVihT1OjhgxSGtHg=; b=sBeslR
	GPm+fLMs7yRXy+dq2v/HTRHfuMIwgkd/7YvgNqN7VGr/8CwGfvbhpBclpVfMIwty
	2hNazU5qBoy+++M9evzsyWRaC1l2dRwZ4OcSxEGmK5n2xW9UR7ByVlhGl3aSa2Ta
	tpsKgd1kTZblWdhUmrpbHnSyMVJaMvjoe+Ltw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SFCNuTdim+5yDeF9M/tipw9AwLcRiyHZ
	AT6kdlwhGiWF9ViH/3J+U3ZuACKPs6OgSo7fGhSoHeCbJHwszYVOk5l6DcJCPG/E
	U3/wuz1ODsw1LwZ/9EgYoY2pSalNkhP/SwdBXK1ydJennpK4cvaMI0fiX5AxV6f0
	9pduElw4ZK8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D588CA57;
	Sun, 27 Jan 2013 21:09:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 933D9CA56; Sun, 27 Jan 2013
 21:09:01 -0500 (EST)
In-Reply-To: <1359334346-5879-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 27 Jan 2013 16:52:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEF225E8-68EF-11E2-92D2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214785>

I think our works crossed, while I was tweaking the previous series
to push out as part of 'pu' you were already rerolling.  Could you
compare this series with what I pushed out and see if anything you
missed?  I think I fixed the (a && b || c && d) issue in the version
I pushed out, but it is still there in this series.
