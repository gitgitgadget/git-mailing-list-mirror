From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Update git-gui tree please?
Date: Sat, 26 Mar 2011 10:48:01 -0700
Message-ID: <7vaagh4vu6.fsf@alter.siamese.dyndns.org>
References: <7vlj06gziu.fsf@alter.siamese.dyndns.org>
 <87hbaqqhvr.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Mar 26 18:48:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Xb2-0001Mv-OU
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 18:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138Ab1CZRsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 13:48:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab1CZRsO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 13:48:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7CEB937C6;
	Sat, 26 Mar 2011 13:49:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TaAl3FfvfqSdgjuGYTG23UyuPeo=; b=gzjC83
	e8eEK8xemSp6bH+urlCNz+UnuVbltB2n3aWUiuunOEQVB+HtfLc09Q2312l4xMSJ
	VF5P18ieC78qPhTLfX1WHcEVMfS0asHKEL0bLt45aVYKNrxFNqpQB3odAitcyviv
	EujQXv5TaS+7vLRkGnUCFDJyUKVxo50p7S63o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b4aQ2TO7hVeqvEn1mJ1FcQ7C5CQiZbSx
	Wv5VYc74Volh+tKN/PqG5gItbODzY0G/cKMr0NwAp0N5VyaPDCmqNAri8IM/I/E6
	5zdkAG+OuItHbNjhYpvu6JqNfBIDWZRqWa+1aa1zTMrMdcpPH4NsKqSXQZz7AoHa
	aMHfp26GpF4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4902937C4;
	Sat, 26 Mar 2011 13:49:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3662D37BA; Sat, 26 Mar 2011
 13:49:46 -0400 (EDT)
In-Reply-To: <87hbaqqhvr.fsf@fox.patthoyts.tk> (Pat Thoyts's message of "Sat,
 26 Mar 2011 10:46:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 731D67D4-57D1-11E0-87C6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170061>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> I have merged your ss/git-gui-mergetool branch in and tagged it so
> please pull:
>
> The following changes since commit 8f85599aba6b569de5c559994704a416f52bc031:
>
>   git-gui: apply color information from git diff output (2010-10-27 23:47:28 +0100)
>
> are available in the git repository at:
>   git://repo.or.cz/git-gui.git maint

Thanks, pulled.

Are there notable changes since 1.7.4 that you want to see in the
release note for upcoming 1.7.5?  Aside from Russian and Bortoguese l10n,
most of the changes seem to be fixes or internal refactoring, but if you
have end-user facing changes that should be advertised, the release note
is the place to do so.

Otherwise, I can just throw in a single liner

 * Various git-gui updates (0.14.0)

Thanks.
