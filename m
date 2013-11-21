From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] transport: Catch non positive --depth option value
Date: Thu, 21 Nov 2013 09:34:33 -0800
Message-ID: <xmqqzjox4q1i.fsf@gitster.dls.corp.google.com>
References: <5283A380.9030308@gmail.com>
	<xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com>
	<528A9877.4060802@gmail.com>
	<xmqq61ro9utf.fsf@gitster.dls.corp.google.com>
	<528E2660.6020107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: =?utf-8?Q?Andr=C3=A9s_G=2E_Aragoneses?= <knocte@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 18:34:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjY9K-0007Zl-GU
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 18:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab3KURei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 12:34:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37465 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab3KUReh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 12:34:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F81352717;
	Thu, 21 Nov 2013 12:34:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bm22Sfyt3icUZgjlfGT3jTtAOUM=; b=YcAzoC
	8MmBOwpaYKvb5DFX8ZbFZ3TyMi1yDykodl3DWqhs5pgXIl39yRKpNfmh+q76e6Kp
	AMlIJvRF4aJ9g4hU+O3N7EHiX5XfsCpkY7x8hJkYXkvktIJ2ru58pgkQygZW+akT
	cI7t78teRsn/IH5tN9uXtiO27qOgRrmcaN440=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nZUaDT1EdmS8ImrX2A+zlH0zCkq8CqRm
	TNDv+o7w9Q2SudNI+Xblf6XJRYLPda7J4r+jPtgPGG9vjyIA06Zda3RgI+6ZjShx
	vMahtrD9l2yyF6QdEcMj2qaZKkREWH0ZzjNgB6QtctjZq7P1O4wn2g4bCyjLyXxk
	f5t4tlymJQI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4045452715;
	Thu, 21 Nov 2013 12:34:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 849C152714;
	Thu, 21 Nov 2013 12:34:35 -0500 (EST)
In-Reply-To: <528E2660.6020107@gmail.com> (=?utf-8?Q?=22Andr=C3=A9s?= G.
 Aragoneses"'s message of
	"Thu, 21 Nov 2013 16:27:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3070CA8E-52D3-11E3-B1A9-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238130>

thanks.
