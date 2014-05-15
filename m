From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-show: fix 'git show -s' to not add extra terminator after merge commit
Date: Thu, 15 May 2014 09:33:08 -0700
Message-ID: <xmqqwqdngfy3.fsf@gitster.dls.corp.google.com>
References: <20140514221245.GA22918@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu May 15 18:33:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkybG-0006G0-5n
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbaEOQdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:33:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52289 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbaEOQdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:33:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D23715013;
	Thu, 15 May 2014 12:33:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4OHvZ94JBIhJNkzx6Zv8iFWgr4U=; b=BVeAQ9
	IOTgo/jVelZQmU0p2ytniKFKDc1qN8nEV2E/TUokqpKJXxe8Qcc2zVin3F7UOXDe
	BTOti3yj3Twio8xVpncUA29m0JcInkW+gY7pJHh6R+grBgNfVi3NXQkceWSrecgo
	XQ3n/u+gwUi1OT58p4a1x2MQcmjYOWtk22FIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U+YOjH3nQuyLJeRD34E4C7bm0B4j9vKz
	IS3x9GoVDVZEMlzubiuqi2VHOPKlE1u9vh9YDnx4KtUPxzxVFxndpB8T/z0MZ0Wf
	XiifsjY85uow31Wz/XldgKRiySb3nYz8a/N4M5+FUFu0Dg8YnSX+q7XP22zTle9v
	S4LdNrxJ3CI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 362A215012;
	Thu, 15 May 2014 12:33:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6508016FAE;
	Thu, 15 May 2014 12:33:10 -0400 (EDT)
In-Reply-To: <20140514221245.GA22918@wheezy.local> (Max Kirillov's message of
	"Thu, 15 May 2014 01:12:45 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9A3976AA-DC4E-11E3-AEBB-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249110>

Thanks, will replace the topic.
