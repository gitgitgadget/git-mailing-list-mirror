From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/10] transport-helper: updates
Date: Mon, 11 Nov 2013 15:33:13 -0800
Message-ID: <xmqqiovyjyyu.fsf@gitster.dls.corp.google.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 00:33:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0yw-0000AJ-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab3KKXdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:33:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369Ab3KKXdR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:33:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F4FD513A7;
	Mon, 11 Nov 2013 18:33:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hiIiXMdVzJHW6o1D1eiewHqdlCY=; b=cLwxly
	DJqdJGYfvNnofYsTR8SzQbWGe/0d3cQTB/X3J1w9DIThzD7W5bErBYZr0Lv68+Pe
	RjlHgcWM6cyXFcIsiSHJUidu/FROZx8fz6d1jJRJsPx33fuvZq50Axdl95+X21B3
	Kcpnc4HpbMMfGFVVFN3DvaV6fBeicr3uozyWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fY5Yh9tJK7EXO3k1xxEOyhRnUE3VU4eJ
	BF5wpvWzafugH43QyxIKG92jF/Z/oCN5izCDOaPxWZeDkljneHjlwdrUPXNa64AN
	hSOg0OLSRit5qh5JHUnckVco9woVPo31wBX2bVaNp9yFdE+11Sm28UZQyL8/aESi
	WsMTMSuZuaA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CC06513A6;
	Mon, 11 Nov 2013 18:33:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D4E1513A3;
	Mon, 11 Nov 2013 18:33:16 -0500 (EST)
In-Reply-To: <1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 11 Nov 2013 16:54:58 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A3B1E19C-4B29-11E3-B14F-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237676>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Here are the patches that allow transport helpers to be completely transparent;
> renaming branches, deleting them, custom refspecs, --force, --dry-run,
> reporting forced update, everything works.

How are you sending your patches?  The Message-ID's suggest that
git-send-email is being used, but when the patches are ordered by
the sender datestamp, they seem to come out in a random order,
unlike the patches other people send with git-send-email.

git-send-email gives a timestamp to the first message it sends out
and then gives consecutive timestamps, one second apart, to
subsequent messages, in order to make this "sorting by sender
timestamp on Date: field" work. I am wondering if there is something
you are doing differently, and/or if there is something that needs
to be fixed in the version of git-send-email you are using.

Thanks.
