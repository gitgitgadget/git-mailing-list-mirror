From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] completion: avoid "words" as variable name for zsh
 portability
Date: Thu, 28 Apr 2011 13:52:03 -0700
Message-ID: <7v4o5i3xqk.fsf@alter.siamese.dyndns.org>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
 <20110427013534.GA14286@elie> <7v62q0b8e0.fsf@alter.siamese.dyndns.org>
 <20110427064033.GB4226@elie> <20110428160115.GA19003@goldbirke>
 <BANLkTikt=Em6kP93aZfuZ3DEXdXN+7sAzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	Mark Lodato <lodatom@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:52:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFYCK-0001v2-AZ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 22:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693Ab1D1UwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 16:52:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932611Ab1D1UwW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 16:52:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45D3A52C6;
	Thu, 28 Apr 2011 16:54:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kan1B1LOkuDPccBtAcZZS47229A=; b=kxrrtO
	iXR2tzgrQMCP4MTP5DQfbYLtsP9ftBqo8WRhbjvkGnislVDxueTIiSnTe3IFHxp4
	zLIjZs+B9qWSTL8/MHbE0TE681/5q5GEZUBHfX8WocHazkxDMJDG6cZXD3mKeQBy
	Lt3YbncEM3Uk9Scd40mh8v2fcgwNjJpbJPZas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MDJS9vCQRWpE/xqGuwbQW7Nkm4AAfIfz
	EaQG2VlgE/eYNZGlp9Svf+Jq4N974UEEI7mlpWVtpeZvBaAHWd24Dsb+C07z1dIM
	yaUWkj/Ccnw0+R+q1hQi50TouE7MtyxNvVmBSG8IshfzCUtwlK+4L9i9bwWSxW/Z
	PPXBy/GMEKE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D787A52C5;
	Thu, 28 Apr 2011 16:54:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E952052C2; Thu, 28 Apr 2011
 16:54:07 -0400 (EDT)
In-Reply-To: <BANLkTikt=Em6kP93aZfuZ3DEXdXN+7sAzg@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 28 Apr 2011 23:24:05 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE58387A-71D9-11E0-8D59-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172405>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Nice! Much better approach.
>
> I also noticed that behavior when not defining 'words' as local, but
> though modifying all those instances was overkill.
>
> Acked-by: Felipe Contreras <felipe.contreras@gmail.com>

Do you mean reviewed-by or even better tested-by?
