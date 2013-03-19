From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] Improve git-status --ignored
Date: Mon, 18 Mar 2013 21:08:16 -0700
Message-ID: <7vsj3skp5b.fsf@alter.siamese.dyndns.org>
References: <514778E4.1040607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 05:08:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHnqx-0006Nf-Ft
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 05:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab3CSEIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 00:08:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab3CSEIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 00:08:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78BA6839D;
	Tue, 19 Mar 2013 00:08:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PLkucv/CpzV2Gud0eTEBeS0vJBE=; b=abFs2q
	QJDr0e2OOOTL+exjkYWSVoLY2c9+M3wGFp3HQD0+g6QKEAqEMmGKp0eW3QQd5bGM
	YsZBck+wKby7Ob+Q7O3q4W1DCb0XrbXVr5Mh1GDoduspbMK7YBuKOhZUvH7hD6He
	gwkR8uBCJbdfNQ0oA0fJzrfP/GNDDgTGpi6RI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IbLG2yXB9Q13suyot/qPvqnKs3e9X2kq
	f9p/t0AJNTMeM7c6dZHBnp7ELjiwOCZ1xR/qeq30rxvS2ACn1+sM7zJWCD9GQmY4
	7xQmc46NKd7Ra57DT0lbmWU3MQqNoie0fI5Oeyf58ITR7CaMMjEgbVPs6zu2oJgt
	pd3HSLNwY/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D72D839C;
	Tue, 19 Mar 2013 00:08:18 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D517B8398; Tue, 19 Mar 2013
 00:08:17 -0400 (EDT)
In-Reply-To: <514778E4.1040607@gmail.com> (Karsten Blees's message of "Mon,
 18 Mar 2013 21:28:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A116034A-904A-11E2-A21B-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218478>

Karsten Blees <karsten.blees@gmail.com> writes:

> This patch series addresses several bugs and performance issues in
> .gitignore processing that came up in the inotify discussion.

Thanks.

How does this interact with the nd/read-directory-recursive-optim
topic that has been cooking for a while?
