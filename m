From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] wildmatch: remove static variable force_lower_case
Date: Tue, 09 Oct 2012 22:31:24 -0700
Message-ID: <7v1uh6evv7.fsf@alter.siamese.dyndns.org>
References: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
 <1349752147-13314-5-git-send-email-pclouds@gmail.com>
 <7vtxu3e5jl.fsf@alter.siamese.dyndns.org>
 <CACsJy8BOcH8cXje5osL4oNP1YkJ8HadUOYBek3uhEbySBey9Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 07:31:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLotX-0004xx-Cv
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 07:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab2JJFb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 01:31:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43418 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407Ab2JJFb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 01:31:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 418B46020;
	Wed, 10 Oct 2012 01:31:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o8lu82h6M73vKLVsgkuomZFRur4=; b=Xq+gv9
	5CJXlij00tgS4EP2ZeZk5KZdHO4zI31hrzbZrqVquYCHeyyHQzJOY4lQKJzPsxG0
	UJkr54MBLYAKkZdxhd1XbIVMjLrZtKJE4ODbpI2m1Fh4fVewhGxLV/48aONm6zR+
	DP9kH1QHAwG2UO7DcpVeUMWC7hWxXF1g3Oqw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jhXQWVrXLiKv9QPEsmLuGq4L/Sqlaq6B
	y3LEAJXgmeBmAMwU7ro9uf1Rm7Cf88eiwFl0SPT9wK13F7zqXfRyRVdqtexK6MtA
	6DORwC8dJrNNnYCZz+Q+P6iz5RVJ0KaBNge6Og/ybiMEX1HES7/TPyTpb0JT0L1U
	hzg1XEqAcZ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27466601F;
	Wed, 10 Oct 2012 01:31:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AF39601D; Wed, 10 Oct 2012
 01:31:26 -0400 (EDT)
In-Reply-To: <CACsJy8BOcH8cXje5osL4oNP1YkJ8HadUOYBek3uhEbySBey9Kw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 10 Oct 2012 12:14:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC5A5516-129B-11E2-B9A1-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207363>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Git's ctype does not seem to be complete for wildmatch's use so
> ctype.h is required. But that can be easily fixed later on.

Until "later on", I cannot even compile the series.
