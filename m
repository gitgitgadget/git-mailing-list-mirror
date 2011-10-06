From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Prompt for merge message?
Date: Thu, 06 Oct 2011 16:17:19 -0700
Message-ID: <7v8voxyakg.fsf@alter.siamese.dyndns.org>
References: <6eb7acc7-f4be-4b90-a2fa-a0c91ed9a5a8@t11g2000yqk.googlegroups.com>
 <7vsjn5ye0x.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvFytscxyx2z+Fdw9E1DS02wSXgoE3SHkxKq2OYOMQHgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Todd A. Jacobs" <nospam+listmail@codegnome.org>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 01:17:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBxBy-0003Wn-Hr
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 01:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330Ab1JFXRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 19:17:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759400Ab1JFXRX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 19:17:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF31C6570;
	Thu,  6 Oct 2011 19:17:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=osHr+5MUoeZcc1XrjP2wHP8IGcE=; b=Kfb+10
	NQR56JsXl7Oi9R+9oUgUcSlw2FJ8PBG/hBWIxL7Hi3FIMFQB6ufImNMM0HfbFCZn
	T7nHU7FlecaGFZutEXWWutKqmE3LNNKOXKr5qqO9gyDn3iyVwmDt4CSgBJJlH2xp
	5f0ylNgARBaWl+LgV8N4+ZcWzZyLBMAIYXgUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h5rFYSXIJRhX/fAYb9tOwo2mIiw+/xEU
	C+tUjff4cnKploUkaWirjUhn1lBZNsLsfzh4zGCKoX2OUTx27BlA040C48qbu+Ex
	/oMnqjKPdrmJjloU6T6hbkTdDQhor9upGN8F1TDI/ClTD0sq4NyKYjZRB0Epebvw
	Cm7Ny0wuwHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D61DF656F;
	Thu,  6 Oct 2011 19:17:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1594F656E; Thu,  6 Oct 2011
 19:17:21 -0400 (EDT)
In-Reply-To: <CAJo=hJvFytscxyx2z+Fdw9E1DS02wSXgoE3SHkxKq2OYOMQHgQ@mail.gmail.com> (Shawn
 Pearce's message of "Thu, 6 Oct 2011 15:09:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 581717EE-F071-11E0-9491-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183049>

Shawn Pearce <spearce@spearce.org> writes:

> to git merge? I know the reason we don't want to do it all of the time
> is because git merge is already used in a lot of scripts. But how many
> of those are running with an active terminal on all 3 standard fds
> when it runs git merge?

Ninety four?

$ git grep -l 'git merge' -- 't/t[0-9][0-9][0-9][0-9]-*.sh' | wc -l
