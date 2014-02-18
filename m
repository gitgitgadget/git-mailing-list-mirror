From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git release notes man page
Date: Tue, 18 Feb 2014 14:14:52 -0800
Message-ID: <xmqqha7wcbkz.fsf@gitster.dls.corp.google.com>
References: <1392460179-776-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>,
	Stefan Nwe <stefan.naewe@atlas-elektronik.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 23:15:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFswU-0001FM-G4
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 23:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbaBRWO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 17:14:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47053 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbaBRWO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 17:14:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E0376DB9E;
	Tue, 18 Feb 2014 17:14:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QqPL4MmdDOlWCgzmq5ODxv299p0=; b=bDfznw
	PEP8BdNdHuf75wt4Un/9VhT5L5uBHatA5jrnsJoIgkKYz4XTrBtJcfdi5cv4m+bn
	nOdv16uQ0sgU38D1UqzMaFwDMAryoD+uoyMP9UPWP4osFyVLdplEk2Y2AFaku6PE
	R8hekEMJNIVBsBNsQTusynGx1ZwP5lChpijSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bIX2m/si2N7D3xiiCF9FhwiB5rbNZzdu
	BWdDO5m8kzckkyPc6udaQxfRL8lAzeKbDVxICa7SlkAVYpfHmuDmBoBMY6iIYl9G
	bJ0RO2AVOvvICw87WTq+QBHN1/kHKoUcF3lA6f24eJt4aZW1pw9bTq1edhLLAbFq
	l/s7GEK2u24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F9686DB9D;
	Tue, 18 Feb 2014 17:14:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9E7B6DB96;
	Tue, 18 Feb 2014 17:14:54 -0500 (EST)
In-Reply-To: <1392460179-776-1-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Sat, 15 Feb 2014 10:29:38 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 184774F0-98EA-11E3-BDEC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242363>

Philip Oakley <philipoakley@iee.org> writes:

> A few days too late for the 1.9.0 release cycle :(
>
> This responds to Stefan Nwe's request for a 'git help' command that would
> access the release notes. ($gmane/240595 17 Jan 2014).
>
> I've used the full name "release-notes" for the help guide rather than
> Stefan's original 'git help relnotes'.
>
> The release-notes man page lists just the notes for the current release.
> The combined notes for all releases is nearing 15k lines.

RelNotes are incremental and only useful for those who know what the
immediately previous release contained, but for most people who get
their Git from distros, I have this impression that the versions of
Git they get skip versions, and seeing the notable changes since the
previous source release will not give them wrong information---they
may have this warm fuzzy feeling that they know what is going on,
but they are missing information on all the accumulated changes that
were added in earlier versions their distro skipped---these changes
are still in the version they are running.  I do not understand why
it is even a good idea to show release notes from the command line
"git" interface.
