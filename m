From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] sha1_name: avoid Yoda conditions
Date: Tue, 30 Apr 2013 15:00:48 -0700
Message-ID: <7vehdrbrvz.fsf@alter.siamese.dyndns.org>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	"Duy Nguyen\" <pclouds@gmail.com>"@b-sasl-quonix.pobox.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:00:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIbY-0004ob-HR
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760582Ab3D3WAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:00:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758281Ab3D3WAv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:00:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD63F1B2BD;
	Tue, 30 Apr 2013 22:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nRZDTPygZUfkKGvp+5vgUDBMj2o=; b=oeN3RR
	mCN8FRtaO6EoAXvQ9l1+ZbA2KC5GHTW9c8R4tEZFfT0s+rfO43wvi6NsTAF9fhmS
	CVwQn3fikGAkiYvajHwHK/HVDXSECTOYYZxNnkRjJpU/56OJSpeqzfUODt+6eTKc
	36JSMQ4y1nkjId47Y4+WyQzUKhqAE+r7lot5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sx8iApuF+2Ct8sRpgRQxl7ZaFZsDcA/+
	5CfWwdvJV2ptJMYZsr6jnrFotkB4pjMkN+UvEmLoqMmWA8ql+/w71T9hEEul20Za
	jMzoqKt5zT/phMdGA3bPZjmEqRNQES3a5c9idEKl8V1HU+qD09bw3iXs8MItBHwg
	Ari0xqEdvZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C44D11B2BC;
	Tue, 30 Apr 2013 22:00:50 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D9261B2BA;
	Tue, 30 Apr 2013 22:00:50 +0000 (UTC)
In-Reply-To: <1367358554-4257-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 30 Apr 2013 16:49:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B779790-B1E1-11E2-BE31-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223021>

What is a Yoda condition?
