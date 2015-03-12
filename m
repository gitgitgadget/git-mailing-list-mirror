From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: fix some mis-organized options in "-h" listing
Date: Thu, 12 Mar 2015 12:10:38 -0700
Message-ID: <xmqq61a62frl.fsf@gitster.dls.corp.google.com>
References: <20150312181509.GA20987@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 20:10:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW8VK-0005gm-Ue
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 20:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbbCLTKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 15:10:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751773AbbCLTKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 15:10:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EBC63FF82;
	Thu, 12 Mar 2015 15:10:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MyLFPecqLe8iXWaYwsLptsAEsZk=; b=ZhQZt/
	3w8+j1YWjwkbUc5LTfwO1yauEJEWZD0BQwUIEmogtV0Kj3RCKp8sllnavEpt+Yym
	x2wEY5oN0Y1MyPWWT7SIOFRTJE5gW4M++4CfuZ66tbw3Wku49aE8Szc5E1COiI0X
	IyW26iJrEq+aY6/lcwSCrOqsQDGFu20skca/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AudM21I3qW85UthnTrwxZ9D8dkd20muK
	3h4NyKg1DeqjfX1m6dqBf/8oZMOVlqgFcxL1GK1pS8SfXsjSgqxlWjIhxXw1xUZQ
	UF/ZHJxVHMIYbvYKjLvythJTyV5izU+mFZ6mmGHOdXElVnnZpsKLZqaHt2GCn0Pb
	cN/cfrWEfow=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 042C93FF81;
	Thu, 12 Mar 2015 15:10:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D4EA3FF7C;
	Thu, 12 Mar 2015 15:10:39 -0400 (EDT)
In-Reply-To: <20150312181509.GA20987@peff.net> (Jeff King's message of "Thu,
	12 Mar 2015 14:15:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 78A12F12-C8EB-11E4-8A11-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265369>

Thanks.

Even though this dates back to d96e3c15 (tag: add --column,
2012-04-13), I do not think it is worth backporting it to v1.7.x
series, so I'll queue the fix for a bit newer maintenance track,
perhaps for v2.1.x and above.
