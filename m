From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 5/5] rm: delete .gitmodules entry of submodules removed from the work tree
Date: Tue, 06 Aug 2013 14:11:56 -0700
Message-ID: <7v8v0efrs3.fsf@alter.siamese.dyndns.org>
References: <51F8187F.7040603@web.de> <51F81957.1000709@web.de>
	<52014B4D.3090602@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 06 23:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6oYS-0004s0-SS
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 23:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576Ab3HFVMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 17:12:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756558Ab3HFVL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 17:11:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36CD736812;
	Tue,  6 Aug 2013 21:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F77lOD9NOH0FIBzOIL17G/CG/Jk=; b=dw3O7x
	G+IgsVUG8nDr+w2EjBdRBIJvjDf6vZ0Vk+IiTk3fRtcNzO5dAylERZLqFCsYebzX
	76EjgyRfT6rGAzdl092oUcgzVdCIa6o/yuSxUSTU1meKvQJ83eu6Zxn3fW79zNNm
	7jKzHElJJ8Td+jIwghKnAEMjrSALlUVeajBdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a+05rzoXuMrNv4Mfho5vZN5zK6AwVsJI
	KAiwv7UOAANmZTFgAX9xAqpzv3aa3W742zov5THNBBeWVyCL1kKlyx9efGy0kplR
	ofgPn/OmVeOwCIfrlVQugdc0V8EavrNQF4ZOtedlajlerkPJX3I2ex15LAV2jTCV
	a4/ARJwCays=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A58E36811;
	Tue,  6 Aug 2013 21:11:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81D8236810;
	Tue,  6 Aug 2013 21:11:57 +0000 (UTC)
In-Reply-To: <52014B4D.3090602@web.de> (Jens Lehmann's message of "Tue, 06 Aug
	2013 21:15:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3DF2A9E-FEDC-11E2-AE94-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231786>

Thanks, will replace the top two commits and queue.  Looks like we
are getting ready for 'next'?
