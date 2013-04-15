From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] Improve git-status --ignored
Date: Mon, 15 Apr 2013 12:23:08 -0700
Message-ID: <7v1uabsin7.fsf@alter.siamese.dyndns.org>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Apr 15 21:23:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URozr-0003CJ-Qv
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933533Ab3DOTXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:23:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232Ab3DOTXR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:23:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E16F5160F7;
	Mon, 15 Apr 2013 19:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dr5yY9mEbdqKAohUqonUoZ97YSA=; b=oJVKRP
	7tJNf3QLgaKNt5o7yAyu/wGoTB+LpvMXZdR+KqWdjVgYRkZATxLl4FkodSeGO1IC
	DmJ0kxXhgp/b2+V94WUZ1TitGZw0smwYhGkTdyCTMt8SixNhAcEyoa3QBZhZMTzd
	KSCJM/XsC3rWPf8m22plmaksUQ8viN9jYbgbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ECG7VP0J2ERX+0mPzHT0HGzkmCpBweyG
	lPbaKumy777OJFs3IpuaSmj2DyMasVtHEOVX2n8Q2EVjn4rrkmR8Gw5Zmqc+uDFn
	iosF+HeZGyXj0JWxXHYi4Qrc3LHRBJkNNPXlca0lk2aIcaKNsNsEMtiPdrdKnzES
	PlA67wSZBBg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D32BB160F6;
	Mon, 15 Apr 2013 19:23:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46EA4160E7; Mon, 15 Apr
 2013 19:23:16 +0000 (UTC)
In-Reply-To: <516C4F27.30203@gmail.com> (Karsten Blees's message of "Mon, 15
 Apr 2013 21:04:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC479186-A601-11E2-8D2F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221305>

Karsten Blees <karsten.blees@gmail.com> writes:

> This patch series addresses several bugs and performance issues in
> .gitignore processing.

A 8-patch series ending at 5d765dc7888b (dir.c: git-status: avoid
is_excluded checks for tracked files, 2013-03-18) has been cooking
in 'next'; in general we won't revert and requeue a new round for a
topic that has already merged to 'next'.

Is this "v2" an update for that topic?
