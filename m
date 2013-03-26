From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change the committer username
Date: Tue, 26 Mar 2013 15:05:55 -0700
Message-ID: <7vhajxstoc.fsf@alter.siamese.dyndns.org>
References: <51520835.8080407@metropolitancollege.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Kom <erickom@metropolitancollege.co.za>
X-From: git-owner@vger.kernel.org Tue Mar 26 23:06:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKc0p-00031g-5Y
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 23:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab3CZWGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 18:06:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab3CZWF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 18:05:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE284B205;
	Tue, 26 Mar 2013 18:05:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vjLhY0FlRkAvq83zjSvbTLVBhSg=; b=mtEPN+
	oAwjyZr2EOFNCcNQ21BqVCUJDx0Dv+v7kFzZEit2bRXfQghKfCEmnsZwabKafIPw
	81cMSJIV789+xrD1EkHT/sm+McQxXW/F8dgGbucdkopPj9CGXifIa3yMZGvu0sLh
	MGFr6zl4kXNopqsbYTK0msSSq/uuLi3vpK2YA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TbMO5WQg+NvrCBcg/K6XrLLxVTMu0wWb
	UKchHtwWv8udd2V+7LWk2TBgJ0geD3+lx8N4TceAAHeY7BbUYCR3VtgNqzpZLGC5
	oosmcnxAqTz4SO7m2U0Xd56HaFOmwpBjZs6a7JkFRcNHTiYgyygJ6bh6wC9q8It7
	dkqjAyjiKH4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2C5EB204;
	Tue, 26 Mar 2013 18:05:57 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 271BBB202; Tue, 26 Mar 2013
 18:05:57 -0400 (EDT)
In-Reply-To: <51520835.8080407@metropolitancollege.co.za> (Eric Kom's message
 of "Tue, 26 Mar 2013 22:42:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55E6301C-9661-11E2-9142-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219221>

Eric Kom <erickom@metropolitancollege.co.za> writes:

> Good day,
>
> Please how can I change the committer username from system default to
> personalize?

Quoting from a very early part of

    http://git-htmldocs.googlecode.com/git/gittutorial.html


It is a good idea to introduce yourself to Git with your name and
public email address before doing any operation.  The easiest
way to do so is:

------------------------------------------------
$ git config --global user.name "Your Name Comes Here"
$ git config --global user.email you@yourdomain.example.com
------------------------------------------------

HTH
