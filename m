From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding git hooks
Date: Sat, 26 Apr 2014 10:24:50 -0700
Message-ID: <7vy4yshul9.fsf@alter.siamese.dyndns.org>
References: <1398504843.79785833@f133.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Suvorov Ivan <sv_91@inbox.ru>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6Jn-00053A-Lb
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbaDZRXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 13:23:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64408 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbaDZRXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 13:23:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A567F79C2A;
	Sat, 26 Apr 2014 13:23:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s+aRuIyQI03JEumkbriCt0cIYNg=; b=Zl61ZV
	bhPtMFZbLLoSdBAFYRZ5pYZ0nW8zNpAacYbxZpw2FoCCUd3FQs0o4bDyT0/zW2fI
	mECDOz0H2e3ENNWJ347S2/GWYDZfkxJkxMZV1DpUwL7FoygJ+NHoCFxVXMVUOE+v
	motUfaVrC565ulZD0D/N3L/Pge0EfjxKdYQ5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wzKUnNiIqJPQSF8mt2GjEjG0jVyZtTmM
	2MyykSpNSoNf8XgoQdRVWh1YZobw7WvdZVzYUsxbXZB+T4slUtOgSHj6GGjuj7Rd
	OyTRf+x6z205PXu/RERxuftklEVrd3bJseRlYIHc8ev6AwdDNhLw7hT9yoO/PJ8K
	d4Z+zgna+TE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8802179C29;
	Sat, 26 Apr 2014 13:23:08 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9DB079C28;
	Sat, 26 Apr 2014 13:23:03 -0400 (EDT)
In-Reply-To: <1398504843.79785833@f133.i.mail.ru> (Suvorov Ivan's message of
	"Sat, 26 Apr 2014 13:34:03 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 6C8E3542-CD67-11E3-99BA-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247163>

Suvorov Ivan <sv_91@inbox.ru> writes:

> I want to extend the functionality of git due to the possibility of
> separation of the user repository into 2 parts - one part will be
> stored as usual, under version control git, and the second part will
> be stored in another location such as an FTP-server.

Sounds like you are looking for git-annex, perhaps?
