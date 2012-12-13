From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] cache-tree: remove dead i-t-a code in
 verify_cache()
Date: Thu, 13 Dec 2012 10:34:17 -0800
Message-ID: <7vbodxztqu.fsf@alter.siamese.dyndns.org>
References: <7vip89bz4v.fsf@alter.siamese.dyndns.org>
 <1355362747-13474-1-git-send-email-pclouds@gmail.com>
 <1355362747-13474-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathon Mah <me@JonathonMah.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 19:34:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjDcD-00043r-UI
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 19:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774Ab2LMSeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 13:34:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755599Ab2LMSeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 13:34:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A827DA57D;
	Thu, 13 Dec 2012 13:34:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ou8UvBtOVOf/AJC0QtZmASqm6Ww=; b=yLc6/f
	Si9Y4t2L0j3pthCwOcb3DZZBuesO6qa2Z4dxo3dUDWps+AHha6beOwT/lW4RI4Lw
	1N261R7my5rNGynLdoJmJxsN/Yjxh0SM4XrFTt6x0r98NYaU542vP5Hn97dNJSPr
	ZMsYlnqyqXO9UWe9bfeiJpTI3k8nkmjBqA0Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lvz3q1+K1Il7NIXkANRJCz+UtBcydUxT
	rPtEL9iDJx9vQ3WvlqbBoro9HAxC792caK8DX3RCcYMgTbxT1kkCvxcr96oFBjX5
	AQyUFqWLoHQf3NsDxMVjC+K/j5Jf0gOX9WirpquJ9h8SV9ofYykelM9KQNT6H3+7
	pvN9P5hTFDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93AE2A57C;
	Thu, 13 Dec 2012 13:34:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1551EA57B; Thu, 13 Dec 2012
 13:34:18 -0500 (EST)
In-Reply-To: <1355362747-13474-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 13 Dec
 2012 08:39:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4B5DE44-4553-11E2-8F1D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211463>

Will replace the one in 'pu' with these two.  Thanks.
