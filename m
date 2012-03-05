From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Allow Overriding GIT_BUILD_DIR
Date: Sun, 04 Mar 2012 22:33:11 -0800
Message-ID: <7vaa3v4kwo.fsf@alter.siamese.dyndns.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Mon Mar 05 07:33:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4RU7-0002OQ-85
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 07:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab2CEGdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 01:33:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754916Ab2CEGdP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 01:33:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EF3945C8;
	Mon,  5 Mar 2012 01:33:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=qvV3j4FbLyXmQNWG8kCnVIteajY=; b=s69ZxAN8vi58rl43fq7z
	A7fiUh8yxhzwyKIpKJ+hIypuM2O4vJbjIQNNyoROwjPhZGfnH3Lqf0SBTP2J7t+7
	7HRLD/j3JJqFejFSe4LZzMhIJXfYE9cS/RITAHpGlCO7gsc0iOx9lmW6GgilpDQG
	0YzZj6e14LZFthj1D6K2Mt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=kv+LZwgJOTG+rfi+zCORKodhD5IGy803XzcZ1DgfYOv9hd
	hzJsaesOssDxna8rBZmSf2OJdWfX2a2oQABTunWTjd8EDkjHwcqR5pSXLcpY3uGg
	xlJ20rhCuqFUxoXV2lmHveER7lOW2vYXWRLgk91BGnNUrfEgcSaOHUf6QQNNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7746B45C7;
	Mon,  5 Mar 2012 01:33:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17DE645C5; Mon,  5 Mar 2012
 01:33:12 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1544E38C-668D-11E1-B914-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192209>

Both of your changes seem to have broken indentation to use 8-SP at
the beginning of some (but not all) lines instead 1-HT.  I'll queue
a fixed up version and push the result out in 'pu' later, so please
double check to make sure I didn't screw up.

Thanks.
