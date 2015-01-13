From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: print format-patch usage if there are no arguments
Date: Tue, 13 Jan 2015 10:43:15 -0800
Message-ID: <xmqq387eed30.fsf@gitster.dls.corp.google.com>
References: <1421171662-12164-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 19:43:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB6R7-0003CM-SW
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 19:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbbAMSnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 13:43:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752352AbbAMSnR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 13:43:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9E6E2CC39;
	Tue, 13 Jan 2015 13:43:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GftLtJyBdXYc5SJiuYeWjeG0OIk=; b=fc5wDs
	ARRAUJPFq7ARpw/PaXawZsuxSniqsivN9bL1JORSdIdo22I7O68vHihV79yKFJ98
	9JbOfoASfiam7G64ECvmzU+o9aU+FKeYkoAv6Crgc+XnJKh5pmZ9yPQemruVw2T0
	RYrUaDkMAgg09qXDrkjprmfLvWGDm+Dl9EGLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p9uT6hvlIWdK6baPm0Jcp1Iu2pu6PTVR
	v6YWCw+EGKBqDmAJtvKCCG/GUPrW4DZXe7RH2Oktg9WxLjD0jPR/YKg1XOFD2ISw
	1kWUNjMjzaxZE4RrEC68hIzlIe6YWw5OMjnj/FE46lAbiblk3soiJyyVdYSYV2o4
	VSt0N7ttIgU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C318A2CC38;
	Tue, 13 Jan 2015 13:43:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21AD82CC37;
	Tue, 13 Jan 2015 13:43:16 -0500 (EST)
In-Reply-To: <1421171662-12164-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Tue, 13 Jan 2015 23:54:22 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 092D7AC4-9B54-11E4-9E20-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262346>

Why?
