From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] git-pull: fix fetch-options.txt to not document 
 --quiet and --verbose twice in git-pull.txt
Date: Mon, 07 Sep 2009 13:08:31 -0700
Message-ID: <7vr5uimsao.fsf@alter.siamese.dyndns.org>
References: <9f50533b0909070534q2375a793mf5d676b519eae69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 22:08:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkkW6-0005KD-GL
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 22:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbZIGUIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 16:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbZIGUIg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 16:08:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbZIGUIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 16:08:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E6FD248F55;
	Mon,  7 Sep 2009 16:08:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wChQz/yw6vaSnBJjskg8Hip/S5Q=; b=IzdDVu
	gi4nPkNhXNHZT7CDcYiOxHZYFAaQn/6gDdLUTNp1f3yF7oP1azASLLp4saTKolfS
	Y/nht4YLROBQwqrNluaEq2CTzsyC0JP2mv+kellIXqc79xz0k/YIjJpZWBILQ88m
	aQIUs5F8mCuAZbI30plLbhEPNSlLzm9wpZyT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TMkZH5FZmAbEFmQhoW/yNDhVo+Hrdq7U
	W/F4T9cFSQ4mzXsDaLpOjPizQbGMVse7pJIHgStCe1UeEGqjEuz5jfZNEW+EXNSn
	ajN2y0Ev+UNLpg+3Psv4EkOQk1q08C2OgRmGxL9ZW8Y0MltL37wzrSN5msuz1psM
	3ku8DziUzdk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C907D48F54;
	Mon,  7 Sep 2009 16:08:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C63AC48F53; Mon,  7 Sep 2009
 16:08:32 -0400 (EDT)
In-Reply-To: <9f50533b0909070534q2375a793mf5d676b519eae69@mail.gmail.com>
 (Emmanuel Trillaud's message of "Mon\, 7 Sep 2009 14\:34\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 398B561A-9BEA-11DE-8742-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127946>

The patch seems to be severely whitespace damaged the same way as in the
previous round.
