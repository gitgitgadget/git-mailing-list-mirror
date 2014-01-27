From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/9] About the trailing slashes
Date: Mon, 27 Jan 2014 14:47:57 -0800
Message-ID: <xmqq38k9nisi.fsf@gitster.dls.corp.google.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
	<1390570836-20394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pawel.sikora@agmk.net, Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 23:48:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7uyV-00034A-RW
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 23:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbaA0WsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 17:48:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754205AbaA0WsL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 17:48:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A65EB67395;
	Mon, 27 Jan 2014 17:48:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HBnDwlJUpNW0PKwNF+n1x/rgcao=; b=LBtSnH
	Gzmlgb5FyWbKqVYkE0TQmbiK5wH0YIs8oKOhyF3sz6QPmclLarCcEDvK7pBxH/zc
	ec3EboE0Ujul5wlVLT5SMemkgFBSqw2n6JedK0JWIB3QI1z7uYAhg0CXBXuSLlXy
	5qpex+u4eTSD2JfCvIIkof3MCnTHVTOem1hAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CvglrPClBMwG/oRdqAsT2fW2GrXYbGYN
	SFDjFIemE7Q4Iyacxe7pWnrwuSJToMN5iZfxKJi+0bq6B5mTJ6doRFjFd/SLgtCl
	4elYmdM3huRNDI2vPVoDxUtURe74EpKQbcXvRQrDr/SagonfJWhL/eYmzDK8551w
	dsVFyCf9q0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FBFF67394;
	Mon, 27 Jan 2014 17:48:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D624F67390;
	Mon, 27 Jan 2014 17:48:06 -0500 (EST)
In-Reply-To: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 24
 Jan 2014 20:40:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 168C26FC-87A5-11E3-992F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241162>

Thanks; will try to rebase on top of more recent codebase and then
review.
