From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Undo last commit?
Date: Thu, 30 Jun 2011 10:29:32 -0700
Message-ID: <7vfwmrqlc3.fsf@alter.siamese.dyndns.org>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
 <m31uyrutx7.fsf@localhost.localdomain> <20110619003718.GA5628@elie>
 <201106191237.55825.jnareb@gmail.com> <4DFF382A.5030206@micronengineering.it>
 <4E09DDAE.30801@ira.uka.de>
 <BANLkTimZN4swfY13zMjkCbAc9UsGSix02Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Massimo Manca <massimo.manca@micronengineering.it>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Mike <xandrani@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 19:29:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcL3c-0006oV-1N
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 19:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346Ab1F3R3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 13:29:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab1F3R3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 13:29:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE9AE625B;
	Thu, 30 Jun 2011 13:31:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RZIvhCCC5Oku+DFmaY4nrCmPBKY=; b=wNrjnn
	OUgSeVRRnLtRC3DzwLBkMYsvLN2vzSbXeOAQjoSK8UVhrefkYfek06QH2CejchDi
	+EGX06W/NtyRUPau/i1eXR18vQdbbr3LG+738NoLz14W1EYA3QcGMAMg5RFwGrv3
	to4I3Xe3sYzZM6W2ElwMkxKs+r/vBZDwwJlIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mWpFWXhJJ+r4siKPYcNjxgx4qx4W3k3i
	9LNk+ck7oPVHaP8kPNWRjOFpPy5FXsyZky6SlUEhKvBdthkcaadLeaCIChsRVg3J
	stAD+cdZKGOyQtb8aeA5SKckYsw3iZsQR48X9bX5qO9iFnCFr3G7+TKZ8Qrvawyl
	RFUoXsDZINo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D78AD625A;
	Thu, 30 Jun 2011 13:31:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3147B6259; Thu, 30 Jun 2011
 13:31:48 -0400 (EDT)
In-Reply-To: <BANLkTimZN4swfY13zMjkCbAc9UsGSix02Q@mail.gmail.com> (Mike's
 message of "Tue, 28 Jun 2011 15:31:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D543D160-A33E-11E0-98BD-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176493>

Mike <xandrani@gmail.com> writes:

> "git reset --soft HEAD^" can't be picked up that quickly by a
> beginner, but git uncommit would be obvious!

So would "git commit --amend", before which "reset --soft HEAD^" was the
only way to prepare doing it, but after which "reset --soft HEAD^" more or
less outlived its usefulness for that particular use case.
