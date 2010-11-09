From: Junio C Hamano <gitster@pobox.com>
Subject: Re: win32-daemon breakage when merged to pu
Date: Tue, 09 Nov 2010 07:42:46 -0800
Message-ID: <7vbp5yo64p.fsf@alter.siamese.dyndns.org>
References: <AANLkTikXv8BhW-fz=pZ5iS6rHJB5mxMUhk0KFO3JSwWv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Markus Duft <mduft@gentoo.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 09 16:43:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFqLg-00069R-J5
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 16:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414Ab0KIPm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 10:42:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab0KIPm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 10:42:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2509E360F;
	Tue,  9 Nov 2010 10:42:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IwiK42ToRjRuXJ77Y16iQoD5Tw0=; b=HmKPjn
	grjfIqV+5PBAw9FZb7Rr5XVOf/yF2xj9M15nouQXDiFxHRnUWtnhNVxWDMlZom0z
	fo4zqwKUcD+Pk6WYUlNFagcSSVPbTIdyuTleoQOCLEUTSwatbZk2VSzhUHl1gJ6F
	Wf4SdDSZELxq3m+Lr/BZ+B8v7qTh64DHuIS7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WgS1JKQNLo0KeVPENw6Sz3I/QpcTeA/4
	R01Wjj3IT/XA0UqVNChWX4trkvXOpCJoAtnmxr7ekfOXjTsXXmnrmw50RrL8BGQw
	MnD8IPXHh7EmRx4CNKsm7qtegqULBO9bLHtYAyxwaHobww5RzMCuJcINZrXe00sJ
	dbquX7zIQtU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E8F50360E;
	Tue,  9 Nov 2010 10:42:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C80AD360D; Tue,  9 Nov 2010
 10:42:51 -0500 (EST)
In-Reply-To: <AANLkTikXv8BhW-fz=pZ5iS6rHJB5mxMUhk0KFO3JSwWv@mail.gmail.com>
 (Erik Faye-Lund's message of "Tue\, 9 Nov 2010 11\:32\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 057255C0-EC18-11DF-AA96-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161054>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> I supposed the correct conflict-resolution would be to keep Markus'
> new conditional inclusion, but move it to the location I changed it
> to. With this patch on top it compiles just fine for me:

Thanks.
