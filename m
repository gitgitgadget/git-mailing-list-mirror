From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a README file
Date: Thu, 21 Mar 2013 14:16:15 -0700
Message-ID: <7v620ka1y8.fsf@alter.siamese.dyndns.org>
References: <1363873555-8274-1-git-send-email-ydroneaud@opteya.com>
 <7v8v5gbwh6.fsf@alter.siamese.dyndns.org>
 <64e67681cf5584b51bc84082fe6304c0@meuh.org>
 <7vzjxwabzv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 22:16:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UImqv-0003sP-U9
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 22:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab3CUVQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 17:16:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152Ab3CUVQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 17:16:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB9E0ACB2;
	Thu, 21 Mar 2013 17:16:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=85op0Fybh2k+fG+fof8aG20SM0I=; b=k1yNsc
	3PvkLdRdDmgqhMDuqAlI3H7oV6URR1V8y1HEbGGnabmHJaK/L6jWD9koXkmd2kHk
	HDnccoZQfsOLStOOI1TGWIpBUbbxy9jB6gfk1g0GmAyICQCmP8tzf0jBSZcjE50g
	bXQ03KQn3FcU9gNiSsey1+ieExPwLkbTwedmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QTHDUJiCp0k1GSFTbvwP6Wzg+WtK0Bxl
	twuiZ5IMBw8Gbe3GIJG19SVOzfWZr2Aj6rY0K/8BH5Li91uCsQ4Ayb63e8BBLqKw
	Gfg2eVd0WesYHQVn/rIcGGpgiKjx6dJIB8kcg7nNcuD2WlGkzBscnrneB6UcC2sM
	TH9z4dG1XwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFFEEACB0;
	Thu, 21 Mar 2013 17:16:17 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21B8DACAE; Thu, 21 Mar 2013
 17:16:17 -0400 (EDT)
In-Reply-To: <7vzjxwabzv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Mar 2013 10:39:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 919A3426-926C-11E2-8C47-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218763>

Junio C Hamano <gitster@pobox.com> writes:

> Yann Droneaud <ydroneaud@opteya.com> writes:
>
>> There were no indication about how to write documentation
>> in SubmittingPatches.
>
> I would agree that is probably the right place for it if we were to
> add insns/hints.

I take it back.

SubmittingPatches does not, and I do not think it should, discuss
any issue that is programming language specific.

We already have a dedicated section for documentation updates in
CodingGuidelines, though.

 Documentation/CodingGuidelines | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index b1bfff6..7e4d571 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -237,6 +237,9 @@ For Python scripts:
 
 Writing Documentation:
 
+ Most (if not all) of the documentation pages are written in AsciiDoc
+ and processed into HTML output and manpages.
+
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
  conventions.  A few commented examples follow to provide reference
