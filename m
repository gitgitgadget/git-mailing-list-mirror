From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/34] Documentation/diff-config: fix description of diff.renames
Date: Sun, 03 Apr 2016 10:25:51 -0700
Message-ID: <xmqqoa9qfvts.fsf@gitster.mtv.corp.google.com>
References: <1459704240-28792-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 19:26:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amlmi-0007Ug-AV
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 19:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbcDCRZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 13:25:56 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752687AbcDCRZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 13:25:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24DA550FC4;
	Sun,  3 Apr 2016 13:25:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dfgCh5hf2rw8DkZb6R6sl8pGBV8=; b=Te0v9A
	9ic8ZTnOA3InVcYUmK0rsEiCAx1nWqXIDEEVT/LbaOWmNH5yxeVdSemaS03mKgwK
	StPaIKcmdbARuF8rEc1QT8mnLJW7+MVWn32oxoQ7l1eTaX1+e+isxLeHFxIs+tAs
	piPqhZcjna6SWUdv5yBEwtL/qBEdxG4+IGkAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a2uAvCNsHF/LWdhDDiDlG3I4ZxYgqtcn
	4xzXB8OGE4DGQg1Rzw4LgjRQszkx243gePFrSC0XfzuFA9Hzcnw2Y2YOpNTnOPAm
	64D45oYMz/e9loAxZV6DGqxtxviG0k9UZEWBZnaJAndNP/GPRUEjvlRnq7BIlhnu
	NGHW7RIBvlg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1326D50FC3;
	Sun,  3 Apr 2016 13:25:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7346F50FBF;
	Sun,  3 Apr 2016 13:25:52 -0400 (EDT)
In-Reply-To: <1459704240-28792-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Sun, 3 Apr 2016 10:23:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D930C78-F9C1-11E5-B685-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290642>

Sorry, please ignore (I had two similarly named scripts, one drives
git-send-email, the other drives something entirely different, and
mistakenly invoked the former when I meant to run the latter).
