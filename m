From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] attribute "eol" with "crlf"
Date: Fri, 16 Dec 2011 10:03:03 -0800
Message-ID: <7vr504ieco.fsf@alter.siamese.dyndns.org>
References: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 19:03:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbc7k-0000kK-Fx
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 19:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760307Ab1LPSDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 13:03:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754249Ab1LPSDF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 13:03:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18E2159E5;
	Fri, 16 Dec 2011 13:03:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WJfn+I54MXu8S0P/JJVp7oEag0Y=; b=fVmmQY
	A8wCvAUZHLn9fzL/bU8WA3zAUvzoVL5H683A/u/mS9S/3oydg7Mw7ZRzu+SA84v2
	k/kDt52BobCXtojNFWhqZDSGby5EH8bIQo6rbR2Wsp/vZ9kFHWJoIZqW6rMjg0K/
	9arq6o3+xqjln8vVfpN/Edn6ivSPvJzsVjPdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HGzqL9pqXvuaY4zDxemRo4gYI+zDVPGW
	G0QjJ3rbtuaGP5+fzw+Aqg1zZyWTBH/Z7YOuVs3Q5Q5uRBR8aXR4R7SeymAleyRP
	cHEp54dkAtvvtxGPuMIXkzUFWowTjocsRUZvGMlQP01dRPHmmC1udPPsra5LWgoO
	tGwHHbOTuzc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1076859E4;
	Fri, 16 Dec 2011 13:03:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A39C59E1; Fri, 16 Dec 2011
 13:03:04 -0500 (EST)
In-Reply-To: <CAN0XMO+OOdTJ+aNMSc2G3RVc7Wfypr4+7dU3US9GVAmMiSJ7cg@mail.gmail.com> (Ralf
 Thielow's message of "Fri, 16 Dec 2011 18:44:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 337FBCB6-2810-11E1-A315-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187293>

Can you bisect?
