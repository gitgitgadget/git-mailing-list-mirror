From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 11:28:40 -0700
Message-ID: <7v1v1psrvr.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
 <AANLkTi=7TNjLVrcJVppiULBnDdKCM_vqwhn1JqoW+DQo@mail.gmail.com>
 <AANLkTimsN40twLwOWXsQqbv0SVN7T9rEHSUpcVum8aFR@mail.gmail.com>
 <AANLkTikX5YvMrooVi-7e-YDrCP_7QHqL6wR=1bY1cZ2L@mail.gmail.com>
 <5A9D499C-26AC-401E-B21A-1F8E03FBAC4B@gmail.com>
 <AANLkTinjbXzdfkxVRPPSXJj6Z0mMrikzdi2V8N5YAGR-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Juran <jjuran@gmail.com>, Alex Riesen <raa.lkml@gmail.com>,
	Lynn Lin <lynn.xin.lin@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:29:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dfB-00086S-6u
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab1C2S24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:28:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab1C2S2z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:28:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 054064151;
	Tue, 29 Mar 2011 14:30:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Fxw6/ilYpR4mrDZLL2wDDJyrvug=; b=Xt5xH1
	Ca244C/qhOKZp+bkm0TNuZtunLDMOdO2sBYD6xhczfmFcC2XrB+L+/wMCAJ+U02w
	bl/2xJyzeGQQzsaK43PYGYRpT2VknzCAiuE4N5/paqXwaokjQKB5iJsoQgVhAIfE
	EvPrKkTknM7ctQZ10e+pkx8O/eZCukVzVLe8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HBGjffOd31knVheDifoWRBQKQUY50Aks
	lqGVyrSR6/Vt6kUMA/2DDH/BWwe2P8TxYEINB1ynPO0q0n2locMIcZbTaxVI5N3k
	AVtKuXxvooeRWUdoGBOiGMZNKWI2dx4z3/AECvLyXpIYtbl6jleqTaf3E78dOKVD
	JsV48YnNAVg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A6625414D;
	Tue, 29 Mar 2011 14:30:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2F0024149; Tue, 29 Mar 2011
 14:30:29 -0400 (EDT)
In-Reply-To: <AANLkTinjbXzdfkxVRPPSXJj6Z0mMrikzdi2V8N5YAGR-@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue, 29 Mar 2011 19:49:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3EA8B86-5A32-11E0-969A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170300>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> Actually, that should be: `git reset --soft HEAD^; git commit --amend`.
>
> "git rebase --root" does not seem a bad idea though.

The lack of this did't annoy me enough (one woudln't have to deal with
root commits too often) so I wouldn't bother implementing it myself, but
"git rebase --root" especially with "-i" would be a nice addition.

i.e. well written and explained patches welcome.
