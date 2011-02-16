From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1.5/2] bash: teach __git_ps1 about CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 14:49:23 -0800
Message-ID: <7vpqqrh9xo.fsf@alter.siamese.dyndns.org>
References: <1297850903-65038-1-git-send-email-jaysoffian@gmail.com>
 <1297850903-65038-3-git-send-email-jaysoffian@gmail.com>
 <20110216215541.GD2615@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 23:49:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpqC4-00060K-2F
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 23:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab1BPWtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 17:49:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab1BPWtk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 17:49:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 511A14CC7;
	Wed, 16 Feb 2011 17:50:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RocsjH1aNHPbIRjUIvnhp537GGU=; b=gdz87D
	eTn3ciOo4T+tqe2luwAP46zwwT8kVQZIJY/rSwtUeQKKYdBsmkDooVujnPH+bshR
	m3P3fzMVBWgUV5AfA7z50JhAQ93VHKGnTpitt8JRUk0SkTQPDFgDHpGHvPB4BTJ3
	1nAQs0Cir8XBLeBuDRxZPhSUsn8/bSpsOmbCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FftUcJyVLorVVKsvtK+Av62nKIHlaDnh
	Ip7vC5uCjkjNjY5mnHPGOMj5TBMJvSNv1y8oyCA9gAGQRyPfeElfgmsHf5DG3qgr
	JaYnCQ7bIJ+QzvPT/HOOsM/SGvYBb1iGL56tJPgENRTIlWekzDseIq1LWvuntTOE
	ULM1UIxr0CM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F36EA4CC6;
	Wed, 16 Feb 2011 17:50:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D21984CC0; Wed, 16 Feb 2011
 17:50:32 -0500 (EST)
In-Reply-To: <20110216215541.GD2615@elie> (Jonathan Nieder's message of
 "Wed\, 16 Feb 2011 15\:55\:41 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2DE5530E-3A1F-11E0-B1F2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167016>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hmm, it seems I don't like this "while at it". :)

I don't either.  The series will be re-rolled so I don't have to pick this
up myself, yes?
