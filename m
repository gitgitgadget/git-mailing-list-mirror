From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/githooks: Fix linkgit
Date: Fri, 01 Mar 2013 10:19:17 -0800
Message-ID: <7vsj4ff0ey.fsf@alter.siamese.dyndns.org>
References: <1362158637-931-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 19:19:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBUYd-0007q6-5b
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 19:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448Ab3CASTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 13:19:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247Ab3CASTU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 13:19:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDF3DBB71;
	Fri,  1 Mar 2013 13:19:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dsd5bxjy7SGL6CBD5H98pSr0NpM=; b=SC06h4
	8D2dYDwp7QK00DOyfhUW+FXTAcWAyCwwf19QjsRMGO0HepbV7FwmbUxo9TtJvLPZ
	3eqh8sRVNHJA8ja8jGdi5tLWv1JhiL2AU/Lg7isaOgFXImhOGAoeMuLb/dVOkbGj
	csOkefnvdnZaEsBqNWZBOG56NvalH35cm8p80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f4WlwI472sf6nRSGwvKPX8TnxCgfx3aG
	0gldU5uO/pTQ6HU+gztcZt6Gphm4wwM/Vte3k+3V57BjdhkjwHDldaqh86F0s5ow
	FpwI3Nh/DLO7wUPN5DiFDvQr45KDS6wgc7jtAMYD8ebxML6DJXIPCOB2mJQ9x1L7
	J+vxgpC7Idw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2D70BB70;
	Fri,  1 Mar 2013 13:19:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6576ABB64; Fri,  1 Mar 2013
 13:19:19 -0500 (EST)
In-Reply-To: <1362158637-931-1-git-send-email-andrew.kw.w@gmail.com> (Andrew
 Wong's message of "Fri, 1 Mar 2013 12:23:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88AF4426-829C-11E2-9970-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217287>

Thanks.  "grep linkgit *.html" in the installed documentation area
tells me that this is the only instance that needs to be fixed.
