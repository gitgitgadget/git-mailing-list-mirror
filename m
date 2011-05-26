From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] setup: Provide GIT_PREFIX to built-ins
Date: Thu, 26 May 2011 10:45:35 -0700
Message-ID: <7vfwo1xsn4.fsf@alter.siamese.dyndns.org>
References: <1306381034-44190-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
	<avarab@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 19:46:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPedE-0003Gk-Ta
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 19:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166Ab1EZRpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 13:45:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab1EZRpv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 13:45:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 083085849;
	Thu, 26 May 2011 13:47:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lNURhjoB4E5Zpq8YUgUDu+iSmmA=; b=ZKkO/E
	FFOrqwQVaa9K3p3a76uBnSC1cFoNm3erYG8COdfUZTcBIXkBmidgdJcpfFNClERX
	bxRyeTyqx0OrbFIZY6Z4j7n3IIS3OPLIZbTigg6m28OtbIFghEyreIgUPXSPCe3V
	J2lzbvT87oOs60AFfsg+8gtx0tB6x/UKanFWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SUOscDBLuFKAgr6ya4Lf9h4WqDdtaWMg
	8mvAFgR9C9GHRyapjWX28i3OSl2FCxK8Kg/AHQd5IrIvTSRgr/o7VHDBo84saprW
	nBHiJ4wZ0w8eGIPzL0feCQ8yN/CRJJF71BFEH8Hbl7PDRpBhFVyD9xZLdhyfMeyY
	w/fUDkUgZgQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AA0255842;
	Thu, 26 May 2011 13:47:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0953D583D; Thu, 26 May 2011
 13:47:44 -0400 (EDT)
In-Reply-To: <1306381034-44190-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Wed, 25 May 2011 20:37:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 479E68AA-87C0-11E0-8074-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174552>

David Aguilar <davvid@gmail.com> writes:

> GIT_PREFIX was added in 7cf16a14f5c070f7b14cf28023769450133172ae so that
> aliases can know the directory from which a !alias was called.
>
> Knowing the prefix relative to the root is helpful in other programs
> so export it to built-ins as well.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>
> The original version of this patch did not set GIT_PREFIX
> to an empty string when prefix returns NULL.
> Now we do.

Thanks.  Should I add "Helped-by: MJG"?
