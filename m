From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] document submodule sync --recursive
Date: Fri, 04 Dec 2015 13:08:13 -0800
Message-ID: <xmqqvb8drkg2.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kaX4ZM++jhPcpU0T8eYDobME=iNtbH3KceWbQOOavpHnA@mail.gmail.com>
	<1449175262-3724-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, cederp@opera.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:08:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4xaX-000779-3i
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 22:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbbLDVIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 16:08:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754371AbbLDVIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 16:08:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 82EBF316BF;
	Fri,  4 Dec 2015 16:08:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=TYniBm
	P2f0zWTes2nSTAb/ho9aQL5Pc1Ldp7jrsRXBmzKwlpBdqpP8iyhjfuqNTok++N2U
	EX0pRuPVqYhsMsPazoVUyCBoAhsHyWrvHWRCALrN2pXaOxA5mhQIpyDFv3BHOAD9
	Bo4GY2oJenGZ0fZNeb26vcKYzKAUHIT0zVjn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UfCwdfF8zfuVZFC+Zf0g6ST6tu4m8jdr
	K24leSgUAbtnQcBAo6uHFPAH44/2Thk5EkRI5s095pnOxb2PxMuSjLpcmTe97TWn
	qliugprYOnfhRcIdQCxRreeL1o4WhVOubBH6IkyhPXET/3GsNY+oEorWC/5IG50X
	8unoCCz34Uw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7ACBD316BE;
	Fri,  4 Dec 2015 16:08:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F268E316BD;
	Fri,  4 Dec 2015 16:08:14 -0500 (EST)
In-Reply-To: <1449175262-3724-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 3 Dec 2015 12:41:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 225AABEE-9ACB-11E5-9E2C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282004>

Thanks, will queue.
