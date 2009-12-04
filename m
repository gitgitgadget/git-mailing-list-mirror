From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-push: don't access freed transport->url
Date: Thu, 03 Dec 2009 16:31:03 -0800
Message-ID: <7vhbs71sxk.fsf@alter.siamese.dyndns.org>
References: <20091204073144.f98115f9.rctay89@gmail.com>
 <alpine.LNX.2.00.0912031837570.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 01:31:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGM4y-0007Rq-27
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 01:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbZLDAbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 19:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbZLDAbM
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 19:31:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbZLDAbL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 19:31:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6F50A394C;
	Thu,  3 Dec 2009 19:31:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xX4IkYf0vLnJfboyW508Z/5k0/4=; b=RCsx1r
	eLsS6DYu3QENSluB55ntbQ9EmIJ8zk+B7/FrK+2+KeP19ifxAtUCC/YYo8nX4fyB
	Bq1Wx80iSchXpmftTKy8cLjxoO/fFM7LA7PbJWVdr6gSFaLCaHCgACf4/2WHMbGw
	L2NiBpUcUOPtEP2WUXLENr2r0jQhumKK1R5Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KFmvPiyRZuw68SVBb5HvFi5hjjs9UZ+O
	G6wymbm74btiNvlNDxIV59k+YIsmDJNOoWd9ERIS3kgedAeFXuJzSgVl8hKs/8Mf
	YobZL1Q8wP+q/d5+XiteZJ7IrSO+F8pwFNmq2ADLfI8Kl81Gm0/HqB1RLxURbBvb
	Rm+YVsELhDs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7893DA394B;
	Thu,  3 Dec 2009 19:31:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2330A3949; Thu,  3 Dec 2009
 19:31:04 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.0912031837570.14365@iabervon.org> (Daniel
 Barkalow's message of "Thu\, 3 Dec 2009 18\:38\:13 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 52986532-E06C-11DE-9FEB-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134486>

Thanks, both; queued at the top of sr/vcs-helpers topic and merged to
'next'.
