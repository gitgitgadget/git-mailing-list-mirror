From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion: fix zsh support
Date: Tue, 26 Apr 2011 21:55:35 -0700
Message-ID: <7v62q0b8e0.fsf@alter.siamese.dyndns.org>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
 <20110427013534.GA14286@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 06:56:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEwnB-0002yz-EI
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 06:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab1D0Ez5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 00:55:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1D0Ez4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 00:55:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 213BA5ADC;
	Wed, 27 Apr 2011 00:57:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SjOYGI9DXdB7dwXyFxwWVSB3lg4=; b=MTwmQR
	4GAO7Ysj9B7Ee8qkVbFaBuh+9ctf5koJgw9ydYNURnRwr0cyuH6Ug3hnoFSxbJ23
	CgtCZqgrUOhkVz/XARat19ZxfVbdscOaq5hQb6EIdnqrQYDkX5InYUduNCl/gVp9
	mgzxYr750bT2rPB0tQd44Ccd8lDLZjuoYEMqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FOiUfsdWz8gjgtwj0qksAmyvCRsDFsgC
	JaE35f7jz55DnKDPk0m6bh+PmFo3LsACY5XzF2Sdji4WHWLhDuWaLRS05gQuPoiW
	u+YaBHxBO+Djcgbi4Q126y5ryzaxfC8X4/TntUTGZTl5VbIvGIFwX09DW5oZLvdO
	YR1AyOcS20k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2A1C5ADB;
	Wed, 27 Apr 2011 00:57:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 063025AD8; Wed, 27 Apr 2011
 00:57:39 -0400 (EDT)
In-Reply-To: <20110427013534.GA14286@elie> (Jonathan Nieder's message of
 "Tue, 26 Apr 2011 20:35:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5554214-708A-11E0-8BD4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172167>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Felipe Contreras wrote:
>
>> It turns out 'words' is a special variable used by zsh completion, and
>> it has some strange behavior as we can see.
>> 
>> Better avoid it.
>
> Hoorah!  I imagine this fixes a regression introduced by
> v1.7.4-rc0~11^2~2 (bash: get --pretty=m<tab> completion to work with
> bash v4, 2010-12-02).
>
>  Acked-by: Jonathan Nieder <jrnieder@gmail.com>

I'd love to share the enthusiasm, but find that "as we can see" needs a
much more clarification.
