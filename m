From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] clone: forbid --bare --separate-git-dir <dir>
Date: Thu, 10 Jan 2013 19:15:58 -0800
Message-ID: <7v1udse7f5.fsf@alter.siamese.dyndns.org>
References: <1357465670-32766-1-git-send-email-pclouds@gmail.com>
 <1357873799-17413-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Niedier <jrnieder@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 04:16:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtV6c-0007kR-93
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 04:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab3AKDQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 22:16:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34520 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237Ab3AKDQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 22:16:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33448BE08;
	Thu, 10 Jan 2013 22:16:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=fHF6h/
	T/6YT1UM+NvyP8RZC0OadS+nA7U5gTbPEIsiD50HE6D+hMscmx97grzruyGUqVtF
	EZSFQXQTJ80wgLRjg6xKMghsiX5fT3MueZpkJZ7ITRHTGAJ9N8WaCidwS9gAYh4H
	d9c0bGm/najoDmbqOPfzeU4SabzVsIby2o1IU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZvgwDRlV6okLyZjDEuMz87MQuiIEpoDo
	Ca173LLAOd1IVmDJKe0e6JOu2kNofjuvdzHybz//UFYqAdtICjPPVo55oSbDHGVt
	f7S/mfua8zkUAspp6HDASMzkM4XhihKrWuduexuRwyS2ipiO8zOT94XfbvJhxeX1
	hBgxWiUJH74=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06117BE05;
	Thu, 10 Jan 2013 22:16:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0976BDF8; Thu, 10 Jan 2013
 22:16:03 -0500 (EST)
In-Reply-To: <1357873799-17413-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 11 Jan
 2013 10:09:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CC2D580-5B9D-11E2-92CE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213167>

Thanks.
