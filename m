From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there some env variable like GIT_LANG (like LANG)?
Date: Mon, 21 Mar 2011 12:43:00 -0700
Message-ID: <7vipvcp8e3.fsf@alter.siamese.dyndns.org>
References: <4D879E11.6040609@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:43:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1l0U-0005iR-EK
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697Ab1CUTnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 15:43:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab1CUTnI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 15:43:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C6774287;
	Mon, 21 Mar 2011 15:44:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c40Fm1d3w9il
	fhontbPTTegTQK0=; b=VIfmG9/GfL5FFGAGJAtmoEpBA7fc9jo1yMQeGbM4XQi8
	DtPgQ5lOIKdyTqTNttzyej+wqqfoAQw3EqcIS6PUbNXq+5/4WiJXBzX+182C5PEx
	u0B1zkQRM63/YXB63T7rDFXNIQ5xCdkZjXa/22+XXDu3Z12jzBi7gcGaSe8abuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tb+RZm
	4Ej9TMPsLXgtnt7Mb5q1vjaykZ41I4bBflM6qBkmieQSMVl0lTAHS/BmeDVdIof5
	lpJRXvoS7v63x0Rgi4pvOb1elKpKr5h26yHh2FVZM2NNz4NJqW1kVxQjKDTco2TY
	L9ZFUoZiE/ILUy5f4ELwl2H/IPSx2E8FbFy4U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70EC74286;
	Mon, 21 Mar 2011 15:44:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7E3D04285; Mon, 21 Mar 2011
 15:44:41 -0400 (EDT)
In-Reply-To: <4D879E11.6040609@dirk.my1.cc> ("Dirk =?utf-8?Q?S=C3=BCsserot?=
 =?utf-8?Q?t=22's?= message of "Mon, 21 Mar 2011 19:50:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABAFBF2A-53F3-11E0-A3DD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169649>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> What would you think of it?

Strongly negative.  I don't want force people to set GIT_LANG HG_LANG
CVS_LANG and 47 different FROTZ_LANG environment variables.

I would rather just set LANG=3DC LC_ALL=3DC in the terminal I use git i=
n and
leave everything else in whatever locale the rest of the system is in.
