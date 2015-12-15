From: Junio C Hamano <gitster@pobox.com>
Subject: [RFPR] updates for 2.7?
Date: Tue, 15 Dec 2015 15:09:44 -0800
Message-ID: <xmqqtwnjcnrb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Dec 16 00:09:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8yjA-0008FI-6i
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 00:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933822AbbLOXJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 18:09:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932463AbbLOXJr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 18:09:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A0D8F32A54;
	Tue, 15 Dec 2015 18:09:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=p
	COxzCh0wVqBeiBfjCZt/9yTvB8=; b=ESDj/9czqy/ihlr6tsugZldBa24uVBbU1
	fKvdPjVqgWJqThowv25RO45kkBSa6dQVB9mBVPSu8qhSSJkeHX7vi7JbyWwqXfig
	OBLRIDyJXZixx1IuprSqENjmc+9QKZUBViuriADCGTu7t5Qjtd/YJUobuDsOUf/A
	4WuqpBX6iM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=KQI97HJPkR6bhf+9EtyMk+SHGDnPff26HBoH6Qrm+qR7qamp60I6E8g1
	fQwhleFYUaVZDbe/9vwlxQGKJ6gpjGDe+w5innYUkAV9mUvD4Ait0FfaWIv/h04k
	SNVdcxuxn0sdt2l2MYc+fKVPljN+WxmEmfuoZ+jIklcOzjWsUzI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 972F532A52;
	Tue, 15 Dec 2015 18:09:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1A84832A49;
	Tue, 15 Dec 2015 18:09:46 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EEBD6C40-A380-11E5-932F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282504>

Git 2.7-rc1 has just been tagged, and the remainder of the year will
be for the stabilization, fixes to brown-paper-bag bugs, reverts of
regressions, etc., but I haven't seen updates to the various
subsystems you guys maintain for some time.  Please throw me "this
is a good time to pull and here are the updates" message in the
coming few weeks.

Thanks.
