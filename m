From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Sun, 27 Jan 2013 18:53:18 -0800
Message-ID: <7vk3qyyq5d.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <7v38xm12kk.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com>
 <7vr4l6yrd3.fsf@alter.siamese.dyndns.org>
 <CAJDDKr75K3RGgU79nrznbpjQMLQGkDs=W8XEofURNsS1X1bvjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzequ-0000Rt-3e
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 03:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551Ab3A1CxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 21:53:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092Ab3A1CxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 21:53:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1419CBDB0;
	Sun, 27 Jan 2013 21:53:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eQ+5ux/jtsvNk6UzZEcJPV7OF8Y=; b=u4/UBm
	gKWjMDBSRnmZ4I2AvvSygIRhKK2mzYUQccz1jxbH7PsUCxSloCU2PpQ7jHEMfeIo
	7mExpclF/+T6JzjCvkWF5sjuw6pJTGW8V4bDv/hCT1SliD5KZrdolCuasSepZnA7
	hl6p5oAi7wW3WoFwkfKaxezlZUGOBiAJA0fLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CHvtUyGnjOxdlguFRdJ+qcAvd5QSJBuL
	s76mCDCJ622VSnQszj7+qO2z7Auz7I0OwbxuZSE47fr3csPm5haKuDHQMkctEidS
	DGaxr8YCpI4b9AgZRXHzng7nS11JOyxU90/gz0TsJFhcWi+gpzK7GalgG549hMTc
	b4TOhUiVr6Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05239BDAE;
	Sun, 27 Jan 2013 21:53:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B8BFBDAC; Sun, 27 Jan 2013
 21:53:20 -0500 (EST)
In-Reply-To: <CAJDDKr75K3RGgU79nrznbpjQMLQGkDs=W8XEofURNsS1X1bvjg@mail.gmail.com> (David
 Aguilar's message of "Sun, 27 Jan 2013 18:41:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFC674F2-68F5-11E2-9A0F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214793>

David Aguilar <davvid@gmail.com> writes:

> Okay, cool, so no need to reroll, ya?

It was more like "please don't switch to incremental yet"; I tweaked
the mode_ok in your v2 and pushed out the result on 'pu' again.

There may later be comments from others that make us realize some
patches need to be rerolled, but nothing from me for now.

Thanks.
