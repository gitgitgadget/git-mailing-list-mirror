From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pre-push.sample: Make the script executable
Date: Tue, 11 Jun 2013 11:32:42 -0700
Message-ID: <7v8v2gbir9.fsf@alter.siamese.dyndns.org>
References: <1370952896-27315-1-git-send-email-themineo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Wieland Hoffmann <themineo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:32:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTNC-00018f-Md
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab3FKScq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:32:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33135 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238Ab3FKScp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:32:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5251E24E51;
	Tue, 11 Jun 2013 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ndM97OwgTZndL2CFyHJOZXoQY90=; b=O1vHC0
	K02A6Hx27UAKrVlldmGSfAyNzZwRDnl1yN9pdnfbT9fOgmkH9AMRZQZVsdrxTKLa
	FupDr4PHZreTlKzCBTEIAplv2cqJv5pawXPI1E4yQQiOk5jG3kqh2iQ3o8i7UBaf
	7cST9lBdvLBbFOQgpOh1q5R+fH/Sr71HJbHkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=btTYkoiWPnQi0PdBZYq4bOzn0PliItM+
	2C9tA7X6smaXt/GSi96ecBu5k+IgvhUuv2d6UUXSKQ9avTj1WS4cGlJ1fF7CDeoE
	b7goEKqJUaswfPyncZ25lF3jw3lDlP8gghv9BgwxpAkj/sRZoA4UOkBUvrLMETTG
	0P4XsbgSid4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4577D24E4F;
	Tue, 11 Jun 2013 18:32:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9524024E4E;
	Tue, 11 Jun 2013 18:32:44 +0000 (UTC)
In-Reply-To: <1370952896-27315-1-git-send-email-themineo@gmail.com> (Wieland
	Hoffmann's message of "Tue, 11 Jun 2013 14:14:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EC15640-D2C5-11E2-86E7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227488>

I was reasonably sure that I've seen this patch before, and checked
to see everybody else in that directory has executable bit, but it
seems that I forgot to apply it.

Thanks.  Applied.
