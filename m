From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Use correct grammar in diffstat summary line
Date: Thu, 02 Feb 2012 10:24:19 -0800
Message-ID: <7v8vklxfe4.fsf@alter.siamese.dyndns.org>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <7vhaza2qjw.fsf@alter.siamese.dyndns.org> <20120202142255.GA25871@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 19:24:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1Ke-0004ij-Fz
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 19:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069Ab2BBSYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 13:24:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38546 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314Ab2BBSYX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 13:24:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F59659A8;
	Thu,  2 Feb 2012 13:24:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qCYDYXvvtVqtCJMiu2e9vioVC7w=; b=G9kIgu
	AiXB3bRy+Bp6S44cIFFfj5F7Cop1iqPUnmOOu+EoneurNYQ6Z3IjDiDlsY5hnYJN
	ilNamu/GHyf9K4qx8/xQSR88tlhj23y3t81fpjbGrPs+p7dzMYDxPO1c8EPjfAvm
	5AoDDRrv8RnBigirU5Z4lx+BMhVlhW5QI3y0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=teJemN9sCCq2KQ1JwtDXTkFNHcXZGV3o
	0MdU/eO5UMdLXex60jOQvWs+fGUi+i3J1CtR5Jf0xft8iYAZh/aCRPaKRXGZy15Z
	N5tHvIeOc3hMeKOGpRa7y1dtmgVk53fBVcOwu4z/JBWiQN1lJiTi+3LcBXlW3fJ+
	k3EzTsYz9Lk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 069F559A7;
	Thu,  2 Feb 2012 13:24:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ADD359A6; Thu,  2 Feb 2012
 13:24:21 -0500 (EST)
In-Reply-To: <20120202142255.GA25871@do> (Nguyen Thai Ngoc Duy's message of
 "Thu, 2 Feb 2012 21:22:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20758002-4DCB-11E1-A69A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189662>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Feb 01, 2012 at 01:26:43PM -0800, Junio C Hamano wrote:
>> Nice.  Will queue
>
> Please also squash this in (resend looks ugly and it's hard to point
> out changes). It makes the code look less ugly, use Q_() for gettext
> poisoning and revert am input text back as Jonathan suggested.
>
> I take it --summary is un-i18n-able,...

... because?
