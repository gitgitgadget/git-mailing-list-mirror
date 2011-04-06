From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git exhausts memory.
Date: Wed, 06 Apr 2011 09:33:39 -0700
Message-ID: <7vtyebjq58.fsf@alter.siamese.dyndns.org>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
 <alpine.LFD.2.00.1104021103130.28032@xanadu.home>
 <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
 <alpine.LFD.2.00.1104031110150.28032@xanadu.home>
 <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
 <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com>
 <4D9B47D2.6050909@ira.uka.de>
 <BANLkTikanSa3D1Bd8kSySPWQhcj1y8N+qA@mail.gmail.com>
 <7vzko4mw44.fsf@alter.siamese.dyndns.org>
 <BANLkTinOzkHMpr5Yg7dixMyTSHBXCsO7Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Alif Wahid <alif.wahid@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 18:34:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7VgX-0001tx-5q
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 18:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab1DFQeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 12:34:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab1DFQeE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 12:34:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9701D4899;
	Wed,  6 Apr 2011 12:35:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v6/dDB/Ndtbt8nqsXyTusD9iZBE=; b=s31sfe
	wIKtPVIiVtlcfCqQtT81nxui4dtWpPjgQBQN7IRhxnWuD8cGLj5wevvEnZ7yqz37
	YcjaX+CbtfBXSZ3ABG6XydP1ud3k8JBeg0NA+1z9AR+sgc7b+pMV8XrT3YtCf2VZ
	PurnjNXAmQWoFBq7E8WQSswDYpOvEIvEggsII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Te4CPg/e72bAmmCAfdB/ajtOjbkFxs4v
	rYLwdufkIvD6E0umzxcXvtsDvQcxFOhHAEl9xrrZQdwNxQMf6z9J0Ys5gIPz7iv3
	HBUBmGnieEcNuM8kdy/CVGdQ6Xhu6MjMkX0n7IJ2jQ+4jNU1DwPRcJWdKhkNHFh4
	JzswIIS1kN8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 27EC24897;
	Wed,  6 Apr 2011 12:35:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 22BD14895; Wed,  6 Apr 2011
 12:35:36 -0400 (EDT)
In-Reply-To: <BANLkTinOzkHMpr5Yg7dixMyTSHBXCsO7Qw@mail.gmail.com> (Jay
 Soffian's message of "Wed, 6 Apr 2011 11:51:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECBEF196-606B-11E0-A46F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170989>

Jay Soffian <jaysoffian@gmail.com> writes:

> This will be white-spaced damaged by Gmail, but anyway:

I've already done that last night.  Thanks.
