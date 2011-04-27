From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Tue, 26 Apr 2011 22:07:12 -0700
Message-ID: <7vwrig9ta7.fsf@alter.siamese.dyndns.org>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 07:07:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEwyG-0007J3-Kb
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 07:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab1D0FHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 01:07:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab1D0FHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 01:07:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A1915BCE;
	Wed, 27 Apr 2011 01:09:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4SSON9P/R3fi3rvS9B5mF934p08=; b=Nw2Vdr
	UUaO4GT1RY5MtbFcnDvsBOSii4W0iF5HQFRP+vJm/JNbvsisv6oCg3sSEQySXgd9
	BbmD/f1fXFuLjONRkxUVLSeveMtfN97wqgcRfAntoNPgtKldAMvlXV3ucpeUULgo
	jPaV4PTw75vT3LcNPogvP3N5gj6JhUkIDeN3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R/evSnZ+rPBNS69KSWve+4MphS1gBShs
	2cVwWpKUVet+JIpJwLO5/T6z5fWGdKpTptyDwamwkI2cyupGy4h+yvd9Ic3ccrxD
	7Vk7uehM9flrGmgxs0SmIel1t7z2+k7etn60XTywCv1/eiM+MNB45R5CC857KuNQ
	Ya/HAiN3KUc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1606A5BCD;
	Wed, 27 Apr 2011 01:09:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 317895BCA; Wed, 27 Apr 2011
 01:09:16 -0400 (EDT)
In-Reply-To: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com> (Jon
 Seymour's message of "Wed, 27 Apr 2011 13:36:44 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82027AD6-708C-11E0-8BD4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172170>

Jon Seymour <jon.seymour@gmail.com> writes:

> Has anyone ever given consideration to git supporting a plugin
> architecture for git extensions?

Hint.  The output from "git help --all" is produced by finding any
executable whose name match "git-*" on your $PATH.

So if you have /home/js/bin on your $PATH, you can install your "git-work"
script as /home/js/bin/git-work, and that should be sufficient.
