From: Junio C Hamano <gitster@pobox.com>
Subject: Re: QNX support
Date: Thu, 21 Feb 2013 09:49:37 -0800
Message-ID: <7vmwuxv9ou.fsf@alter.siamese.dyndns.org>
References: <430B4DD0-B796-4DB2-861D-C1F81302A4D1@aveco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?David_Ond=C5=99ich?= <david.ondrich@aveco.com>
To: Matt Kraai <matt.kraai@amo.abbott.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 18:50:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8aHV-0002WN-Q1
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 18:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777Ab3BURtk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 12:49:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756493Ab3BURtk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2013 12:49:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5A34ADD4;
	Thu, 21 Feb 2013 12:49:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=k0VJrdozWtVA
	ruKGSdJCybbRwF0=; b=Lc8e74+gkjslQaCgu0dPPXwOZ9HzfXcZoR/pfjchvXng
	d0R2Na905aQ9di3BksZ6/SnIDHvgBE4VQC1fmfJNWiT/CFCdilsWCTDN4dJva+w9
	2VlQedpMgwQ4gVTg+3nyi+lgXAZ4n3NUFkdVm6AtVKzxWcLTJ6NEJaLUUEbWpfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GNtXM7
	HKe0uvfGx9qF9AszrKBW34cgzNdkS2t2dpmE2bcebozsY5AWOFdcqEaz2rJPyhGG
	Y4BXcQwtKoeCbXYVHOnixP6IIiy1eBlt2iEXb9wPKWPL4uAKYrmuoejUxjWgNbe9
	n8xCL7Ki8uDgJCJvrVXHxJ3okmwwOR80JyjSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5F65ADD2;
	Thu, 21 Feb 2013 12:49:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 398BAADCE; Thu, 21 Feb 2013
 12:49:39 -0500 (EST)
In-Reply-To: <430B4DD0-B796-4DB2-861D-C1F81302A4D1@aveco.com> ("David
 =?utf-8?Q?Ond=C5=99ich=22's?= message of "Thu, 21 Feb 2013 14:05:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10532144-7C4F-11E2-A5EE-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216784>

"David Ond=C5=99ich" <david.ondrich@aveco.com> writes:

jch: redirecting to the guilty party ;-)

> I've read [1] recently, there's been some QNX port being
> initiated. Does that involve also old versions of QNX 4?
>
> Since we are using QNX both internally and for our customers we
> started porting Git on QNX ourselves some time ago and we do have
> some experiences. Basically, it's possible to get Git up and
> running but there are some limitations, and some hacks have to be
> applied.
>
> If some additional info wanted, please contact me.
