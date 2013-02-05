From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/13] contrib/subtree: Remove --annotate
Date: Mon, 04 Feb 2013 21:17:51 -0800
Message-ID: <7vobfzwd8g.fsf@alter.siamese.dyndns.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
 <1360037173-23291-14-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>,
	John Yani <vanuan@gmail.com>,
	"David A. Greene <greened@obbligato.org>"@b-sasl-quonix.pobox.com
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 06:18:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2avA-0001rX-Ob
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 06:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829Ab3BEFRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 00:17:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab3BEFRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 00:17:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBD1FBF81;
	Tue,  5 Feb 2013 00:17:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hkPztfg1X/L3uXOJMiN9pv/Dqf0=; b=AyTO/5
	4vB2tvrZEAiDwNicN4omX4X2Ndm1VbvFgd2pD/oMcTp+RuQrrDOPBCTiqrrLRAuq
	zOTUnxXsDyHIGTaeOXAd0mx6qgwmg94Yx3RH5S8iA9UBnphyR6F/UJ6jKeqDecnh
	LoDI7EG/mbXmMDMvhKKVSLPGInnSq0tc+o7A8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G0EWMNVGkNM+zihIOTQeAHgwiCSh/qzK
	OGdTWrOunTcKCan2mWUyRNLvjscGeUvig6zZzVro3pohZxT9NsV4juLzwQC232ru
	o8L1Xr17KiEDYcRkKrQdq6IL5Nj/H6jzo5/xPK9/aVLjYjWCrNn8DRL/oLkRSrqJ
	Ln6R2U4LTwU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B04DFBF80;
	Tue,  5 Feb 2013 00:17:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23745BF7F; Tue,  5 Feb 2013
 00:17:53 -0500 (EST)
In-Reply-To: <1360037173-23291-14-git-send-email-greened@obbligato.org>
 (David A. Greene's message of "Mon, 4 Feb 2013 22:06:13 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6462E35E-6F53-11E2-99EA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215461>

"David A. Greene" <greened@obbligato.org> writes:

> From: "David A. Greene" <greened@obbligato.org>
>
> Remove --annotate.  This obviates the need for an --unannotate
> command.  We really want a more generalized commit message rewrite
> mechanism.

That may be a good goal as the end result, but wouldn't it be a bit
unhelpful to remove these before adding such a "more generalized"
mechanism to replace them?
