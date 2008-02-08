From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using thunderbird to post/apply patches?
Date: Thu, 07 Feb 2008 23:26:32 -0800
Message-ID: <7vejbnlxhz.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802071521n674b61c2t5e4d4c740375b951@mail.gmail.com>
	<47AB97EC.8030002@nrlssc.navy.mil>
	<76718490802072010x63e2082akf1aa92b12cd24030@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jay Soffian" <jaysoffian+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 08:27:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNNe6-0001W4-H0
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 08:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbYBHH0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 02:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758029AbYBHH0v
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 02:26:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbYBHH0u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 02:26:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B833697E;
	Fri,  8 Feb 2008 02:26:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D2EC1697D;
	Fri,  8 Feb 2008 02:26:40 -0500 (EST)
In-Reply-To: <76718490802072010x63e2082akf1aa92b12cd24030@mail.gmail.com> (Jay
	Soffian's message of "Thu, 7 Feb 2008 23:10:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73048>

"Jay Soffian" <jaysoffian+git@gmail.com> writes:

> On Feb 7, 2008 6:44 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>
>> I also have mailnews.send_plaintext_flowed => false as suggested in
>> SubmittingPatches.
>
> Would teaching git-mailsplit to handle format=flowed be considered a
> useful contribution?

In the way the e-mail processing toolchain is structured, I
think git-mailinfo is the logical place to do that, not
git-mailsplit.  It already knows how to unwrap single level of
MIME multi-part and also CTE.
