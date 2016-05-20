From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: warn on --verify-signatures with --rebase
Date: Fri, 20 May 2016 15:03:49 -0700
Message-ID: <xmqq7feocrp6.fsf@gitster.mtv.corp.google.com>
References: <20160520210054.GA1856@netblarch.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Stefan Beller <sbeller@google.com>
To: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 00:04:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3sWR-0000Rn-OH
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 00:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbcETWDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 18:03:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751103AbcETWDx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 18:03:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E7D81C733;
	Fri, 20 May 2016 18:03:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=sSOGif
	RjYB+ArV+CkON+j3E8ln3dWuCF9iQbhiHuYWXnhBTsQA1yaeHoXlf2hy8xWCsbzI
	nPbw5AGqSdIcuAUsBoji2rouSOC8gpTyN2RWMYp1RRKJQiLYLVmQKPnCnonCSpkf
	ztgWXZFKk4/tET79JCEypYl57s6/zByiu+3eI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wogPnAaWTZXzoTcFhzc3uGV6l42aUL6j
	pzv9WuaO0/lSeyjHAyEkn+p3FJSRoBNZvRWMmG5Fee4i/5mny2Ms95mHul1SzWWN
	JkTuoAlyLVumesdFytvtuU97ByDOjsC35CX3aw3SZ8jYwJHPYeliSR49L271pvQd
	VwFEbaCpOwU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 859871C732;
	Fri, 20 May 2016 18:03:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E27091C731;
	Fri, 20 May 2016 18:03:50 -0400 (EDT)
In-Reply-To: <20160520210054.GA1856@netblarch.fritz.box> (Alexander Hirsch's
	message of "Fri, 20 May 2016 23:00:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC1FF164-1ED6-11E6-A264-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295212>

Thanks.
