From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add proof-of-concept
 %[w(width,in1,in2)<<any-string>>%] implementation
Date: Fri, 16 Oct 2009 12:01:48 -0700
Message-ID: <7v3a5jupr7.fsf@alter.siamese.dyndns.org>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
 <1255681702-5215-4-git-send-email-gitster@pobox.com>
 <alpine.DEB.1.00.0910161331350.4985@pacific.mpi-cbg.de>
 <7vk4yvuu79.fsf@alter.siamese.dyndns.org>
 <m33a5jfc6p.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 21:02:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mys4C-0001dS-Dv
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 21:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbZJPTB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 15:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbZJPTB4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 15:01:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbZJPTBz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 15:01:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 386657A6BF;
	Fri, 16 Oct 2009 15:01:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oz+1GwNC8gX82Y/BSancBNZ+D60=; b=s5l7cU
	oPcodejHsIIJ16lOQaP3uE/wFah7MUkPSDfN/uQuqbLRY37HOe3dJXQihs5b9INE
	1aP1MH0EN1udgtUo8u3wCrcwG59c/Foce46JsKQfUrIhnQQ9NmHeAqlUZrlQQkB6
	rNT/tExOHs+oUS61EbGAy4L8AXjvic8sOF2W4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EHlcN2miry898cW7wpr68G8lGUFWeeZK
	CKwfIDRgV62c3rFrMsTUE+bMvWv3f0+qjMUhqLej6qB0sK2NbaFZv6q1RN3wFPad
	ACHKh1mihwYKUOkElkMAzffZQAM7orcmAiF0Lh2SL4PcAEywpcrXoaTkxBe/l/s7
	Q1rELSn6KT8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DD727A6BE;
	Fri, 16 Oct 2009 15:01:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2A6EB7A6BD; Fri, 16 Oct 2009
 15:01:49 -0400 (EDT)
In-Reply-To: <m33a5jfc6p.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri\, 16 Oct 2009 11\:02\:56 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F9B0534-BA86-11DE-AEFC-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130521>

Jakub Narebski <jnareb@gmail.com> writes:

> I don't remember what were original parameters to w(72,4,8) means...

"man git-shortlog" look for -w.
