From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: --edit option for git-merge
Date: Mon, 30 Jan 2012 10:15:50 -0800
Message-ID: <7vhazdcazt.fsf@alter.siamese.dyndns.org>
References: <1327930670-32396-1-git-send-email-adrian.weimann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adrian Weimann <adrian.weimann@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:15:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrvlm-0006oa-3H
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244Ab2A3SPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 13:15:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237Ab2A3SPw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:15:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3179666A3;
	Mon, 30 Jan 2012 13:15:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m/pNecO8MKkaAIfRk86NGrV5Plc=; b=Sz/DrM
	QONVaGLMcOQnIpIEPsUSB14q0tf4AoTAHK/9Q3OWNJ6/Q6Y7V1LdpI1ZiVx+A/Q1
	Atnreukpy8f56I11tEULk+JRoGZhucqy0YoudIYS+p3coVom+fPnVUx7gEK1FXqi
	s5WYVrgLvvAI+oa4Lc62H8EAW1kAZNE9VX0GM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MbmBKMQPynPysUUMkZxI1J56qBfcnD30
	7OksOd0onCXef9KuCpyt2wkn927BW154uGktbck6HlIJ27FrHGvmR21DZcZ0SJEn
	CjJ+NJNnebIMe8W6owIPolU1XEA5QqYOqJgNU0rnFgnV1PfmFOHrxr47k1Vmt8Vv
	VBHfDQb1A48=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28DAE66A2;
	Mon, 30 Jan 2012 13:15:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B464766A1; Mon, 30 Jan 2012
 13:15:51 -0500 (EST)
In-Reply-To: <1327930670-32396-1-git-send-email-adrian.weimann@googlemail.com> (Adrian
 Weimann's message of "Mon, 30 Jan 2012 14:37:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 715193D0-4B6E-11E1-8081-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189387>

Thanks.

Once we start suggesting --edit, don't we also need to suggest --no-edit,
which I think is more important for two reasons.
