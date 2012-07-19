From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Thu, 19 Jul 2012 10:20:47 -0700
Message-ID: <7vmx2vvf9s.fsf@alter.siamese.dyndns.org>
References: <7vfw9hafz8.fsf@alter.siamese.dyndns.org>
 <20120626223215.GB8336@beczulka> <20120709220321.GE30213@beczulka>
 <7v8vesk12v.fsf@alter.siamese.dyndns.org>
 <20120711012617.GA18369@dcvr.yhbt.net> <20120711214019.GF30213@beczulka>
 <7vmx35dhzo.fsf@alter.siamese.dyndns.org> <20120718074908.GA23460@beczulka>
 <20120718112722.GA22042@dcvr.yhbt.net> <20120718124723.GA17379@beczulka>
 <20120719081935.GA15414@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcin Owsiany <marcin@owsiany.pl>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:21:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SruPJ-0007a1-Jk
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 19:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab2GSRUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 13:20:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367Ab2GSRUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 13:20:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67E1F7707;
	Thu, 19 Jul 2012 13:20:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MKtYKb3+++K8+4n8dop+VuYZ2+s=; b=FYR9Gj
	GXhVNR21GFFq7m7IAwMMxabIS0nLXGLt9oTMy6m43diIKkSHUkXovB3BKlgqCzLZ
	Dqwj12LUH5vkjiwbe0sqSMxN8sKkD4czZTPaMDPzWCcTtZ2kQgimznKH6StUePwg
	QI0QRkHGq0OUhxBX1pS7h+QNsyVUZKuokaoGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jFhJsmEYbFoQPf+gRybO5zkzpFV2TwLX
	UsOuxZdASlqABoCmTeN+SyZG2LsIl8ZwJI+LLGlNlbFukHbtxFo0o4TLNav1R0z8
	OFOyr6jro+66Jo4eQ0ow5F19zQAlVieU4qaTprd+8bUIE6c8kdywjtwpAsyS3N9Z
	TgSx7hVmaAI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54EA97705;
	Thu, 19 Jul 2012 13:20:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5EC876FA; Thu, 19 Jul 2012
 13:20:48 -0400 (EDT)
In-Reply-To: <20120719081935.GA15414@dcvr.yhbt.net> (Eric Wong's message of
 "Thu, 19 Jul 2012 08:19:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 154BB244-D1C6-11E1-B23D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201743>

Eric Wong <normalperson@yhbt.net> writes:

> Probably, I'm not sure if it'd break existing uses.  Anyways, that's a
> separate issue we can deal with another day.
>
> I've added my Signed-off-by: to your latest patch and pushed
> to "master" of git://bogomips.org/git-svn.git
> (commit e3bd4ddaa9a60fa4e70efdb143b434b440d6cec4)

Thanks.
