From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/9] remote-hg, remote-bzr fixes
Date: Tue, 12 Nov 2013 09:59:02 -0800
Message-ID: <xmqqsiv1h57d.fsf@gitster.dls.corp.google.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
	<1384235688-9655-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 18:59:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgIF5-0000sy-8h
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 18:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab3KLR7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 12:59:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52943 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616Ab3KLR7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 12:59:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FDC851351;
	Tue, 12 Nov 2013 12:59:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eZfTCtomtYXSXIdmfMrQ5wbE2fQ=; b=FwAxJo
	zeM230hrVA7gAKnA4+wrP7LbPVZ6BVCnpg1FGbtEa5WGOCYulI5AldWkwKEQF4ci
	pzvSMU/aNPiVda8a2aEpQzM8GGsEkNp0zljL5bYF2da26/PmS5J4hOyyJryEPXhA
	bV8jqmM7SlpIYEFAh4VbqOE+GWvWRlE+olgEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KiCc9MHeoSAjgUmKBTkfPKvQwcu1r6HM
	Tr03PK4MJTK2ECsE4D1bwCsBySljDI4/Dt1/YkH7d2+AuCMq6wXfsPZ0442GoTF0
	U0NuCSI8py4XpdRp8W2fJAJvSW2DgBf3roN5nlvGTDES5TiNLCNXHGOdALum7wO1
	qBX/vt+EJIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F59B51350;
	Tue, 12 Nov 2013 12:59:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B16D651347;
	Tue, 12 Nov 2013 12:59:03 -0500 (EST)
In-Reply-To: <1384235688-9655-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Tue, 12 Nov 2013 00:54:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1DD40AD2-4BC4-11E3-8516-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237726>

Richard Hansen <rhansen@bbn.com> writes:

> A handful of fixes for the git-remote-hg and git-remote-bzr remote
> helpers and their unit tests.

Thanks; could you arrange with Felipe so that we can have
Acked-by: or Reviewed-by: after your Signed-off-by: lines
of these patches?
