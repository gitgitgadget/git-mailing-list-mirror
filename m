From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] mktag: avoid %td in format string
Date: Sat, 19 Mar 2011 23:03:54 -0700
Message-ID: <7vlj0atjjp.fsf@alter.siamese.dyndns.org>
References: <27484.1172021696@lotus.CS.Berkeley.EDU>
 <20110316051232.GA1932@elie> <20110316051422.GB1932@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jason Riedy <jason@acm.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 07:04:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1BkM-0006SX-Hj
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 07:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236Ab1CTGEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 02:04:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab1CTGEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 02:04:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 09120387B;
	Sun, 20 Mar 2011 02:05:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5DrLaH3fws+5NydS16YKKXfEhFA=; b=uA7qJZ
	wIF09rqHssrNGu/HclNpIKMEo550zoIlkdVYMjXVmVcIBE/t1Koz6vdTTgviGQeS
	1XgVsWJqHI3QNCy1CRoRlO+CVF9Wyg3hJ1BpkOx8feidx+qHjYP29YKZhFfWRztT
	G06Ao23SNaQ0Bm1yScXNDfG459nubSmGK6Wgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q++EccLaISWBCrrYkiFvhl6vPCnQLWOO
	pAoe5ORhIO+AwpBaYX2EdoKo4yz0i0olTsyLqHFaUp4FIrmEVNqrgBm7oo6IoZUV
	4OsT1lRwb/1j153ExIQkp8dfeTpYRSDMIjQ89AYOVmjE9RH7AQpsZNA/YjPw7qvH
	j6+stv8KSyo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BCCEA387A;
	Sun, 20 Mar 2011 02:05:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A9243879; Sun, 20 Mar 2011
 02:05:33 -0400 (EDT)
In-Reply-To: <20110316051422.GB1932@elie> (Jonathan Nieder's message of "Wed,
 16 Mar 2011 00:14:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14C36B34-52B8-11E0-AD36-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169488>

Unfortunate but sensible and correct.  Thanks.
