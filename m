From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 12:19:31 -0700
Message-ID: <7vmx70v8ho.fsf@alter.siamese.dyndns.org>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
 <7vbongyd67.fsf@alter.siamese.dyndns.org> <vpqvclozr7e.fsf@bauges.imag.fr>
 <4F73632E.1060408@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyPD-0008PB-2r
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757820Ab2C1TTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:19:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34286 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756518Ab2C1TTe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:19:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E86A754D;
	Wed, 28 Mar 2012 15:19:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DMB8mfM6Q3ztgV714YzMEADhyGk=; b=LL/4rG
	AFggg06MjM6Ls2M4uNe4cRpZCs+HEs8TO7cOH8xb78zssM/dWPl1K0dLmk/HNH1F
	E6vGzJRGwqPxhF3zyal8pJOLs9VBY8PW/N+o5aR6abqvn8Z6Jjvit3CQJoFFBaVM
	ge+MGKsvleN4h40TeNpr6BlysyOA0wCEDq/fA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t/TNg4h7qoFWAdFvWyAfBlcM9HhxvzEY
	sInwvt1XSlg95Eo4UWOqwzsgsrY16/24H+MRoI0uxKnwUIfS5o/2on2oMy687UmC
	MHW0pl8drNsM2W7Uu1iVNPdIlmq+XuESsbm/R95+nDGOJ2UXQhGqosDWiFVceJNE
	9ufbKCK/SAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9595E754C;
	Wed, 28 Mar 2012 15:19:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 139EB754A; Wed, 28 Mar 2012
 15:19:32 -0400 (EDT)
In-Reply-To: <4F73632E.1060408@ira.uka.de> (Holger Hellmuth's message of
 "Wed, 28 Mar 2012 21:14:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2F9D810-790A-11E1-99B0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194167>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> I don't think it's that tricky:
> ...
> The tricky part might be sorting the hunks so that conflicts are first
> (depending on how the code works now), choosing the right version in a
> hunk (the three new options) should be relatively easy.

Code it and then tell us if it is tricky or not.  Until then, especially
when you have to say "depending on how the code works now", implying you
do not know, why should we even listen to you?
