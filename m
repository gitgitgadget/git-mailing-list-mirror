From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] git-svn: More docs for branch handling in
Date: Mon, 03 Dec 2012 11:32:32 -0800
Message-ID: <7vvccjorsf.fsf@alter.siamese.dyndns.org>
References: <cover.1354324110.git.Sebastian.Leske@sleske.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Wong <normalperson@yhbt.net>
To: Sebastian Leske <Sebastian.Leske@sleske.name>
X-From: git-owner@vger.kernel.org Mon Dec 03 20:32:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tfbl6-0000gk-Hx
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 20:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab2LCTcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 14:32:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53841 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab2LCTcf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 14:32:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E31BA331;
	Mon,  3 Dec 2012 14:32:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KFJJBrfd2zk2QIqm4cHoUJMBsMU=; b=bnlVPQ
	/ETTyRPCqB5hE7emkKYDHKd5bURnm6oxEUxEf6+l0VAQl/6GrlW9s2OMAUsqgC9+
	bB2KLOIY3e0lmjCyPkVZQgy9dohUs1W9GS8TJMKkZuttU3MZKcyIJLFlHhwoWUbL
	hqrbJHmYG4rKbm4Y9JLqO13auL1VIyL55ImVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WHSdvp0Y8LfTpB92nIAXA5fLNR2lgKuF
	ckZ9lPvZYimRrOzdvLn74UPCwX8eA8UzE7eXlT6Bei0WrKjltl6tpZ8rW0nnBXKV
	AgY2VtS6xxAYPgsz9uEwuhNEnD2xlgC4oc25sydRzfY3Q4lhhVr1w9UZ+wINdjm2
	/CIhhSCmmOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62E26A32E;
	Mon,  3 Dec 2012 14:32:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D88ABA32A; Mon,  3 Dec 2012
 14:32:33 -0500 (EST)
In-Reply-To: <cover.1354324110.git.Sebastian.Leske@sleske.name> (Sebastian
 Leske's message of "Sat, 1 Dec 2012 02:08:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FA470C4-3D80-11E2-95F9-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211057>

I've sent comments on small nits I found but overall they looked
quite well researched.  Will tentatively queue on the 'pu' branch,
expecting further updates and Acks from people involved polishing
these patches.

Thanks for writing it up.
