From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix for Typo in po files in git-gui
Date: Mon, 05 Mar 2012 17:27:07 -0800
Message-ID: <7veht6wmc4.fsf@alter.siamese.dyndns.org>
References: <4F553CE5.4040708@ubuntu.com> <20120305233327.GA1360@burratino>
 <4F556582.2090600@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jiang Xin <worldhello.net@gmail.com>
To: Benjamin Kerensa <bkerensa@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 02:27:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4jBM-0001Rb-5Z
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 02:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758119Ab2CFB1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 20:27:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758105Ab2CFB1J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 20:27:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 755666FB5;
	Mon,  5 Mar 2012 20:27:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m0/Y+1QanaBLM8nDpC5GKS3jWts=; b=kneMjK
	EjW5Di38iw3hhfkdmIvo2VY4djU7b1T+HHnwsoorwgDFf+VBvxfWTuHhUpY5500l
	9FVLChC6LQx9fdGEQijn+zew7Umo1JSoQzgQ722NZ7Hn7Y7rKTh8cxn+B5nVC6fb
	uElnE41aXpSGRMCH+lTK+noIDttTaLme+G5aY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cvcTIXhmI9VYnCoZDBTcUqCFRfhglMsC
	8BsKAE69q8XzBYLnrfrHEDs70omlrkainTybERxD60/4uXDfANNuCJO0+jstcHaD
	dYGU2bj7LZKBGy3MTGltPotDicE/1KkM0hQG18Expz0S0HZlRpPCvImk+qhp3HFN
	fxCQhEejhiM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CE306FB4;
	Mon,  5 Mar 2012 20:27:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0125E6FB2; Mon,  5 Mar 2012
 20:27:08 -0500 (EST)
In-Reply-To: <4F556582.2090600@ubuntu.com> (Benjamin Kerensa's message of
 "Mon, 05 Mar 2012 17:16:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DD497FA-672B-11E1-864F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192296>

Benjamin Kerensa <bkerensa@ubuntu.com> writes:

> From 8caa972ad46858a126590e32825fd2dc5947da08 Mon Sep 17 00:00:00 2001
>
> From: Benjamin Kerensa <bkerensa@ubuntu.com>
>
> Date: Mon, 5 Mar 2012 16:51:15 -0800
>
> Subject: [PATCH] Fix for Typo in po files
>
> ---
>
>  po/de.po       |    2 +-
>
>  po/fr.po       |    2 +-
>
...

There seems to be something seriously wrong with your MUA settings,

which makes you send your message double-spaced.

Remove everything before the in-body Subject: which is unnecessary,

and add a single line description of the patch (e.g. '"succeeded" was

misspelled in the code, which propagated throughout the

translations. Fix all of them" or something), and try again?

Otherwise I think Pat will have hard time applying this patch.

Thanks.
