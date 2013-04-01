From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/12] pretty: support %>> that steal trailing spaces
Date: Mon, 01 Apr 2013 11:39:10 -0700
Message-ID: <7vvc86hz8x.fsf@alter.siamese.dyndns.org>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 20:39:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMjdv-0000da-PL
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 20:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758202Ab3DASjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 14:39:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085Ab3DASjO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 14:39:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9305911500;
	Mon,  1 Apr 2013 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4KHexEo8ORjRTvMIML0UP5lpk9E=; b=umz6G/
	dCdSKXcIiRM2LJKqaF+ggc+koS/ntpK/IOZFC8v8lap7CXuW/H2OQ4rzp1MDSnRN
	3Rls1Um3K299OYxA37obPxirjcxueWzbWxOm1Tj9JqwgIYqCMPf+P3iYbhAiAayk
	3BatUlvRCmyyyqH9toMyamxwGoE/lxstsKTrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YQmcHjEK+SvTjTrwHsdp7QHhaGCl4mne
	praq9/mEIT1tybdgftXAl4IZTJrVh4XX+tu6dj2+n6SBOL1vyEL48vi0vVTDdtee
	5obQCO5rdiOW0q0RwXfVlZa6sqqQZvZiXGUMBjEEw2WojRsw7imOSSdeOvneBJ+S
	JhOLwMfyqt4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A501114FF;
	Mon,  1 Apr 2013 18:39:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07686114FE; Mon,  1 Apr
 2013 18:39:12 +0000 (UTC)
In-Reply-To: <1364636112-15065-13-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 30 Mar
 2013 16:35:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72F0DACE-9AFB-11E2-9F43-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219700>

The last three patches are a lot of fun.  It would be nice to have
some test vectors for them.

Thanks.
