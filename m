From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] name-rev: Allow to specify a subpath for --refs option
Date: Tue, 18 Jun 2013 08:28:23 -0700
Message-ID: <7v7ghr8mlk.fsf@alter.siamese.dyndns.org>
References: <1371558931-2980-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Namhyung Kim <namhyung.kim@lge.com>
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 17:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoxpg-0006fY-Tn
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559Ab3FRP22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 11:28:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41323 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932364Ab3FRP20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 11:28:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BE3028830;
	Tue, 18 Jun 2013 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rI19i2khBJa94CI5RhxYOGdF0hM=; b=kyxu31
	nNbViQd3qfuJOJZWKEDZfiWsAdr7X7uTGs8UdRVyiY4wLxdHjOV1ZSTNo9/sEc0Y
	8hCu3PW3uz8jgT0zZWbqwGZzFywYmqlY31w939W1+RmBZtloBtrqn4e7qaja2nBL
	vvHr8oSobDi9vPlwc2beUUMBuQYQE8B0jYfko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lq0HxGa0M0grqTEEYlTdjwrk722Pj3ag
	F4Uy/48DKhSO4nYtBRQNMtGJVmKyk7wNrF9u77GKLNAgyyR1i+FuYKWpOhcmfTnM
	rcF/puAt+CCUyYDCLxoxYfINPDVDY8TAkNZjPhPtxiJFSMSa9dZlH2m0IdIwI0Bp
	xM62334I5a4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 024AE2882F;
	Tue, 18 Jun 2013 15:28:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DB842882D;
	Tue, 18 Jun 2013 15:28:25 +0000 (UTC)
In-Reply-To: <1371558931-2980-1-git-send-email-namhyung@gmail.com> (Namhyung
	Kim's message of "Tue, 18 Jun 2013 21:35:31 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7DF4FE0-D82B-11E2-90A2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228251>

Namhyung Kim <namhyung@gmail.com> writes:

> From: Namhyung Kim <namhyung.kim@lge.com>
>
> In its current form, when an user wants to filter specific ref using
>  --refs option, she needs to give something like --refs=refs/tags/v1.*.

Will queue.  Thanks.
