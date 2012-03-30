From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-commit.txt: clarify -t requires editing message
Date: Thu, 29 Mar 2012 19:05:43 -0700
Message-ID: <7vboneq1vs.fsf@alter.siamese.dyndns.org>
References: <CAF_oF=xGHdbkYw-ytvcZvJnqZ_jdckUCBiuUDzkqGDk=66+yMQ@mail.gmail.com>
 <1333062296-27823-1-git-send-email-haircut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ivan Heffner <iheffner@gmail.com>
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 04:06:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDRE6-0006AT-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 04:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759654Ab2C3CFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 22:05:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759464Ab2C3CFq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 22:05:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB09B71D2;
	Thu, 29 Mar 2012 22:05:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HzxxVvHo6vnq4dARJF7/wmf4eM0=; b=tvfqb9
	jrW/Pnb/aFHDZSkdAyEAY6DvCfQFmuV/BuqK7G+mXZ80an45XLArze15u3xZ1L9B
	QJo/WBNjDPKldx8ddGdV7aZa8xxSfVgiXNc2b9E4OFSnMnAgVQiJjRXlhTbtyPAV
	xGJiSBM05KxCZ3VaQP423sEXkl0VnK1p/ZLS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lzaTrykP7mRzWbiC+1Wc5aULOfDTAKNS
	loaHp3Z7TRs3LkoXkTOLEmZzQTRXo6yps7BlJa8rgFsmgYjFlH5oMk9DfIN8QlWW
	JQQAmDyawTxCTikOKF4JKuI2+Rj5IK02EcHUqGqboJFhG/F9tl3QOVTOsXeDtGqE
	iVw7/G9zpXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1A9B71D1;
	Thu, 29 Mar 2012 22:05:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3576F71CE; Thu, 29 Mar 2012
 22:05:45 -0400 (EDT)
In-Reply-To: <1333062296-27823-1-git-send-email-haircut@gmail.com> (Adam
 Monsen's message of "Thu, 29 Mar 2012 16:04:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC50B266-7A0C-11E1-93D0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194312>

Adam Monsen <haircut@gmail.com> writes:

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 5cc84a1..c6df120 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -133,10 +133,12 @@ OPTIONS
>  -t <file>::
>  --template=<file>::
>  	Use the contents of the given file as the initial version
> +	of the commit message. The editor is invoked so you can
> +	make subsequent changes. If you make no changes, the message
> +	is considered empty and the commit is aborted. If a message
> +	is specified using the `-m` or `-F` options, this option has
> +	no effect. This overrides the `commit.template`
> +	configuration variable.

First, think of template not as the "initial version" but as "a form that
needs to be filled", and imagine that you are explaining to a beginner how
to create a commit.

The word you would choose to use would be very different if you rephrase
the above after doing that mental exercise, and I suspect that it would
become much easier to read.

For example:

    - subsequent changes --> fill in the form
    - If ... considerede empty and --> If you did not fill the form
