From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Sun, 01 May 2011 11:44:00 -0700
Message-ID: <7vbozms1lb.fsf@alter.siamese.dyndns.org>
References: <7vy65bkw72.fsf@alter.siamese.dyndns.org>
 <4D61EA4B.3020708@burntmail.com> <7vtyfxgdz2.fsf@alter.siamese.dyndns.org>
 <7vipwbbrcc.fsf@alter.siamese.dyndns.org>
 <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC-32@mail.gmail.com>
 <4D644FEE.5030004@burntmail.com> <7vaahnbmu2.fsf@alter.siamese.dyndns.org>
 <4D69DF29.8030701@burntmail.com> <7vvd056fyk.fsf@alter.siamese.dyndns.org>
 <4DBA3E14.7090602@burntmail.com> <20110429222729.GB5916@elie>
 <4DBCF0C0.8080307@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Martin Langhoff <martin@laptop.org>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 20:44:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGbdG-0004AX-NB
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 20:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640Ab1EASoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 14:44:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab1EASoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 14:44:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4D9AF4F7F;
	Sun,  1 May 2011 14:46:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=WFDcl8
	HWtMjws1kbO+OzUjYRx34PTbu98J0L8Ye9aN0BoCV3VQGG0VtqfAGLU5yeZmcw5z
	WN9kCHdLi+4VaCVGNqc+ibMDIh9eFeq0GYKy7AxtpYSpaof0hq6B3lDaBwSWduy8
	C3CeGc9hqjFvo3Gktx3Uj4OJsdmNw6TKF4zzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MxXwb1fAiTxbcwEmtG1+ZguyoZocfJ98
	bpWCAnsmCuQ1usfRcxYJezKnAmtcgNqGZYJ9O1rZ2WxvnsjJ7pN7Dwp/nwFZIstP
	QgUHS3IMtYv4sD734ytOPvQOli/9GeP5ZUMZa7RYYCNV5IPI7Mxz31ScIiKhga/R
	iARXuE9BYcw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CFE3F4F7D;
	Sun,  1 May 2011 14:46:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EF8F54F7C; Sun,  1 May 2011
 14:46:05 -0400 (EDT)
In-Reply-To: <4DBCF0C0.8080307@burntmail.com> (Guy Rouillier's message of
 "Sun, 01 May 2011 01:33:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4ABD77AC-7423-11E0-8F96-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172543>

Thanks, will queue.
