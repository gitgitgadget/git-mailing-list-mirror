From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make use of git status when autocompleting git add,
 rm, checkout --, and reset HEAD
Date: Tue, 30 Aug 2011 16:14:56 -0700
Message-ID: <7v1uw21ogf.fsf@alter.siamese.dyndns.org>
References: <1314740583-14567-1-git-send-email-panduwana@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Lee Marlow <lee.marlow@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Ron Panduwana <panduwana@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 01:15:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyXWK-0002xd-C2
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 01:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab1H3XO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 19:14:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842Ab1H3XO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 19:14:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E26AB5AC5;
	Tue, 30 Aug 2011 19:14:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AHMrT2i2cYKz3qNUsV/afIvLQow=; b=cGb18t
	Has3XHDeQzH+YYFI3RDjxamfawFHZGb1Pc5PAwto+LBeUhYX2S1WodLQSBnxDVfz
	3rb20uoJbSokp6ndkq9XH2i7roDU3K7eV06ocFJaiEHsjgIGdOqYao/Ph4fC++x6
	QQv/USREHVOa8FCiJtW3QhfuWT3RejLARlRS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZJsgnJuGF3Urt/5sBvFJUW49pVJPK+2k
	tfBTA81t6Jr/NJoj5WD9DFVZ6Uyu2oT3BQvzOQCx2Td/sEk2G0h9S905OfPpLKDi
	j6nr4p/8NnrTKTX4i3lEe3ly2XJd4eQMClaijyQTq2btgq2EOt708YNGbc896E9e
	I/3lityRtdo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8D8D5AC4;
	Tue, 30 Aug 2011 19:14:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A6235AC3; Tue, 30 Aug 2011
 19:14:57 -0400 (EDT)
In-Reply-To: <1314740583-14567-1-git-send-email-panduwana@gmail.com> (Ron
 Panduwana's message of "Wed, 31 Aug 2011 04:43:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0966614-D35D-11E0-8B98-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180448>

Ron Panduwana <panduwana@gmail.com> writes:

> Signed-off-by: Ron Panduwana <panduwana@gmail.com>

"Make use of" is something anybody can read from the patch. What we need
from the proposed commit log message above S-o-b: line is to justify why
it is a good change. Does it make the code simpler to follow by making it
shorter? Does it make it faster to complete, and if so by how much faster?
Does it make it easier to use by not including paths that it used to show,
and if so what are the differences the end users would see, and why is it
justified to omit these paths from the candidate set?
