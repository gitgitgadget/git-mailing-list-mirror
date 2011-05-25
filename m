From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: Refactor reading and parsing config file
 into read_config_file
Date: Wed, 25 May 2011 12:36:35 -0700
Message-ID: <7vmxia373w.fsf@alter.siamese.dyndns.org>
References: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
 <1306341328-11108-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 21:36:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPJt2-00071e-0c
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 21:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833Ab1EYTgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 15:36:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785Ab1EYTgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 15:36:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 985E45BA9;
	Wed, 25 May 2011 15:38:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=REUvJkF5SuIX8ipeAMLhiIrI1kg=; b=U7eJur
	vpmFGI+aM+t37fY1tTSa7/n47cifozWkvZG3p5h1H+C89ko1tIFzEh7JG6m+WCFg
	q5EHLCCkF1mHTw2l34lXZoz79sRJHKWP7niflOcRVGT+F0NAWCSQrN9U+k+415R4
	9v/wSuSBV0JwdKsmemVqemy+zzBl50HnctzEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HMJogK+Az9sdYKClsavwjQfuSxOlPYUl
	KoRiVdNnY0QR9s05qI3YLSo31Hz9/1/JywT2R920xO70UuwaOsaQn4i6u25LFfnp
	1nsBNRocnOCyxuhxRrAq4+FRWhGcGlkiwFALK0Ig+h/9Vh0/9MmM9PknEVHG/gke
	fFgrJJ92cJE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F0A95BA8;
	Wed, 25 May 2011 15:38:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5B2915BA7; Wed, 25 May 2011
 15:38:44 -0400 (EDT)
In-Reply-To: <1306341328-11108-2-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Wed, 25 May 2011 18:35:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E934A78-8706-11E0-BD6A-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174452>

Jakub Narebski <jnareb@gmail.com> writes:

> Beside being obvious reduction of duplicated code, this is enables us
> to easily call site-wide config file in per-installation config file.
>
> The actual update to documentation is left for next commit, because of
> possible exclusive alternative (possible other next commit) of always
> reading system-wide config file and relying on per-instalation config
> file overriding system-wide defaults.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

As John acked this one and it looks obviously the right thing to do to me,
I'll apply this one directly to "master".

Thanks.
