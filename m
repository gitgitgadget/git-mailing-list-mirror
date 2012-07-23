From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] build: "make clean" should not remove
 configure-generated files
Date: Mon, 23 Jul 2012 16:28:58 -0700
Message-ID: <7vk3xuhxad.fsf@alter.siamese.dyndns.org>
References: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org>
 <cover.1342683786.git.stefano.lattarini@gmail.com>
 <904eb7b0b17805b5265ab70709241b7da382a0cb.1342683786.git.stefano.lattarini@gmail.com> <500DDB07.6050006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 01:29:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StS3v-0005sw-JF
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 01:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706Ab2GWX3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 19:29:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854Ab2GWX3B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 19:29:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CC3C714B;
	Mon, 23 Jul 2012 19:29:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WUV5jtLuz2wlOy+Jfofu+wzro+M=; b=ulIyQw
	MxCuW7Dg6qw9ISQhiPpjJt177HTlGh5iFU7eEDLUfuBUHCyuWu6oJXhpZtqyaUPu
	wIv/YhC3BMmcMS+x5DzI/3l2E20TH096WS3qugU/SO7tVnJia/kY5lmEGz91m+oj
	/A/iaJ23GKkHsXyvXznpT1NOt0Ae7fmKJRl6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZZcJIlPgnqnhc/pp/1w/Ah6+Ewnm6QoP
	5BJbgujK3Fi51Eh5lNjjbRJ0ODySshiWa9COMcsACeVoPsl6PExw4TeB//3FrIox
	zBx2u4IGxqcoY4p3T1ubRhasl/Nc/YenuicBlzlokY6sRr8DaNIrLUKeQxx7y4UZ
	+RxmFrxbE2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BBF1714A;
	Mon, 23 Jul 2012 19:29:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC0117149; Mon, 23 Jul 2012
 19:28:59 -0400 (EDT)
In-Reply-To: <500DDB07.6050006@gmail.com> (Stefano Lattarini's message of
 "Tue, 24 Jul 2012 01:15:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E2F9824-D51E-11E1-917F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202004>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> ... and here we should add "invocation":
>
>     ... the "make install" invocation ...
>
>> falls back to the default prefix of '$HOME', thus installing git
>> in the user's home directory -- definitely unexpected.
>
> Can you fix those nits locally before merging to 'next', or should
> I send a re-roll?

Too late X-<.
