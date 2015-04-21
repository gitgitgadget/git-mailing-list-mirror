From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git's directory is _prepended_ to PATH when called with an absolute path
Date: Tue, 21 Apr 2015 14:48:11 -0700
Message-ID: <xmqqzj61f90k.fsf@gitster.dls.corp.google.com>
References: <5536C319.4000402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David =?utf-8?Q?Rodr=C3=ADguez?= <deivid.rodriguez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 23:48:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykg1l-0002C4-Ex
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 23:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbbDUVsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 17:48:16 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964866AbbDUVsN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 17:48:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 354A14BC93;
	Tue, 21 Apr 2015 17:48:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cNJhgujI13QEBkb0ei/qNDOaMPQ=; b=F2Kp+a
	sU4dK4P5xUgow2YB3oFiLyDtKsEd4a6XualxKWOQNWeXlaYP8fL4vXQlx2yXiN01
	zPALzGyIIyWg8se6Nl6R2NpB6WNlYF6HbpT9LqAejaVSl4kctlgJDoFFbNJ7Txcj
	DvrLORRkmdAxcegXQXg3Tjw/FJbOzkMWf9Dng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e+iDgr/K+FlT21xQgcxuakDh8o8BxO1m
	9KhAs74SXPf/19HVUSYxgPU51R/6SsZosZANsBbRDQ+GokNbmeyiYZXxcv8+Qdf4
	BKfyYRzrQk6btMgPcjxbV5ZBqzCDGU0VL3LwvwwBjC364VLoYL658bRcw3IXVeFG
	a9I/3Fjtsg4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D36D4BC92;
	Tue, 21 Apr 2015 17:48:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A672C4BC8F;
	Tue, 21 Apr 2015 17:48:12 -0400 (EDT)
In-Reply-To: <5536C319.4000402@gmail.com> ("David =?utf-8?Q?Rodr=C3=ADguez?=
 =?utf-8?Q?=22's?= message of
	"Tue, 21 Apr 2015 18:37:29 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1BB73CDE-E870-11E4-9AAE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267559>

http://thread.gmane.org/gmane.comp.version-control.git/267143/focus=267251
