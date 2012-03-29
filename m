From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -p and unresolved conflicts
Date: Thu, 29 Mar 2012 14:08:09 -0700
Message-ID: <7vfwcrqfnq.fsf@alter.siamese.dyndns.org>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
 <7vbongyd67.fsf@alter.siamese.dyndns.org> <vpqvclozr7e.fsf@bauges.imag.fr>
 <4F73632E.1060408@ira.uka.de> <vpqk424zfb1.fsf@bauges.imag.fr>
 <4F737027.5020503@ira.uka.de> <vpqvclnhnpc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 29 23:08:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDMZt-0000zX-0d
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 23:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759408Ab2C2VIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 17:08:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61399 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705Ab2C2VIL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 17:08:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 466227AA2;
	Thu, 29 Mar 2012 17:08:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FKEdSJ6Rl6uKejIiOKXrfHrdutQ=; b=BaLa1y
	UKlVTNlNkRNMsFR97RCtm4rXjb4odclgVZH1nK5/VEH44TAXqUIdHupmpCbVnYoJ
	brD4rzPX9B2nOJ/fnUe3wtGhjhaA8zDXOmVkah+1ykRebDfqSmgL18QJGkWlGjZJ
	0llSYjCnxD7vtfPHrgU41hiLrO+Yy7G1SK4C0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K1t9at12M1z2xw1+1wRRVs29nrHUPZ1J
	OTLNl1qoDDBO/1RAqsizzOGkASdPHdRPvGoBgpUOvi8JCWMakTJaqkCqT4hQs95W
	fFISZGzCd1BVlxqC+UnoV76caY53tcIyOjYXwke7ADF3sPFOrbMv3JHQ9nQX8wvv
	hskYL0WT/Eg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ADC07AA1;
	Thu, 29 Mar 2012 17:08:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5ED47AA0; Thu, 29 Mar 2012
 17:08:10 -0400 (EDT)
In-Reply-To: <vpqvclnhnpc.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 29 Mar 2012 09:26:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A423986-79E3-11E1-959C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194293>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> The "'git reset $path' before 'add -p'" workaround is not really handy
> there: it requires typing the path,...

That is exactly why "add -i" was written without first giving "add -p"
shorthand, which spoiled you and at the same time robbed you the other
parts of "add -i".
