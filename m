From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hg-to-git: fix COMMITTER type-o
Date: Tue, 12 Jan 2010 22:56:05 -0800
Message-ID: <7vvdf6sdbu.fsf@alter.siamese.dyndns.org>
References: <1262998479-24269-1-git-send-email-bart@jukie.net>
 <20100112111651.GC3463@calypso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:56:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx9S-0000xz-Ek
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab0AMG4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914Ab0AMG4S
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:56:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948Ab0AMG4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:56:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CA7C90023;
	Wed, 13 Jan 2010 01:56:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=vP1gG/GrR4HFNCFtaIe13PM7HQ8=; b=MlUjUnbJbuohfFq5BWUOyLm
	Auq7nonkJ8FEUuRENbTyGbz25zNA5KK2riAyrs7b/qQz8FmrZIgIpFbAw4O22wUV
	WcyxLT5j2zjZtoRN3OGL1o0FFiYYSJm0iBt4ZlRdNvu+TwhHfVGbxezG4KP6QTbO
	/e9Vb5bzUYIHN/8n9aBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=u8CZJq/jgav4v7jp30XXXi93f9VB+Kdt81kQQ49Oox7ZLLjjs
	7LOu08zkbucGmprOUn54IHH2DLW7+5cyuOp1lfGjBQgF24JBSeZtySbGhaVlh4Zy
	n+rKwV9+IJPGiDqVqoZrBJNE4Y9+Y/v1dNZTrIOA0UDTS6hzLMOkHFO70o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A7B69001D;
	Wed, 13 Jan 2010 01:56:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54F1D9001B; Wed, 13 Jan
 2010 01:56:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BAEF98DA-0010-11DF-B6C0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136779>

Thanks both of you.
