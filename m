From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/7] CodingGuidelines: mention whitespace preferences
 for shell scripts
Date: Fri, 03 Dec 2010 14:28:27 -0800
Message-ID: <7v39qemqyc.fsf@alter.siamese.dyndns.org>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-2-git-send-email-giuseppe.bilotta@gmail.com>
 <7vsjyemt1f.fsf@alter.siamese.dyndns.org>
 <AANLkTi=PmGR23AMog4UWQVNKPWrDUM_kYWV_Bn1vvSwE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 23:28:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POe7S-0005C5-59
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 23:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163Ab0LCW2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 17:28:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0LCW2k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 17:28:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 235163FC8;
	Fri,  3 Dec 2010 17:28:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X4hQyOHFDQv7UjMPBoKjz70dBnw=; b=IZKOgB
	8ILAOoCtqGVB1gPXxmZksWfO0MFLexNp0bXeebquikKvJy9Jb/HVY5THhZF7+U1u
	9+d5JmUB1IbQ7ZzGRXs8nbdEsKkejJgWo5WsguDbFCXtiDZR7gjUS1kITKSjwmEz
	d0zfFVsWoQCkavHOgD7TUcjFRBMRcp1GLxCHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qLuKj2N0FSNkeshKKkBaYEpCNrD0dyhp
	MVR6XCCrk4u49B7Ep2DzUJ4eept8RWbmj8fljECE2IWiNUT2V6d+H415tVD0sdzP
	gvTs7wqzQqONO+k3XRdHp1c3GfTHMubUcT36bPTi1kwbnT92gFbaN9ZxioWbrWw3
	MlyHPkw8t8U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D50693FC6;
	Fri,  3 Dec 2010 17:28:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 814F83FC5; Fri,  3 Dec 2010
 17:28:49 -0500 (EST)
In-Reply-To: <AANLkTi=PmGR23AMog4UWQVNKPWrDUM_kYWV_Bn1vvSwE@mail.gmail.com>
 (Giuseppe Bilotta's message of "Fri\, 3 Dec 2010 23\:02\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B66642F2-FF2C-11DF-B50C-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162871>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Good idea. I'll rephrase in that sense and add a couple more entries
> about the | spacing and long case arm splitting, for the next rehash
> of the series.

Hm, I don't think there needs a rehash of the whole thing.  This one is
ready for 'maint' with the rewording), and 2-4 looked Ok.
