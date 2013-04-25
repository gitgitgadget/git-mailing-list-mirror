From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 16:11:34 -0700
Message-ID: <7vd2ti19zt.fsf@alter.siamese.dyndns.org>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	<7vsj2e1d83.fsf@alter.siamese.dyndns.org>
	<CAMP44s1CTzO6J+QTDw_tmbkf-jfVxBzpfqY08_6RXrMuPr+CFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 01:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVVKP-0002St-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 01:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758905Ab3DYXLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 19:11:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57537 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758712Ab3DYXLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 19:11:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 829FA19093;
	Thu, 25 Apr 2013 23:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1XZQjKcug/dMObH9H3NDjBfR/Ko=; b=Lb8s+q
	m5jBwZmoOQU0t0QDFyNhxvlX1CiwfOaUVVwMr2xSDbxlGXDMhFk5c7Lk3u+di7by
	XW5Snit9JuDPoZSCNHenF8hVuNBLx1AQFQqIMntOoucEmNlCIr5HBpuOiYa9hMAO
	/2akcsk1jQ9KG1EG9GTSUO94vo7GV9GA61BPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fCUoj0vyoMqSzjPCzaZGiUoTmWoKJDXF
	4X2DrdGo7P1IZabP4lVbjxHauxACgR9OtzfcCoA6CGZNYwSrbqGqbUNJ360ocpM1
	3L7dOFkDnESe/NgIn6EXgym1fsLi618pNAD38zke5c9zlGSjn39VZFYPdSSdUWp/
	N9OD96iE9Ws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A65519092;
	Thu, 25 Apr 2013 23:11:37 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F13C719073;
	Thu, 25 Apr 2013 23:11:36 +0000 (UTC)
In-Reply-To: <CAMP44s1CTzO6J+QTDw_tmbkf-jfVxBzpfqY08_6RXrMuPr+CFw@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 25 Apr 2013 17:58:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A9D3A96-ADFD-11E2-B3BB-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222461>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> You are missing my point, this is *ONE INSTANCE*. Show me another
> instance where a reviewer complained about the lack of a descriptive
> commit messages on *remote-helpers*.

You are the one who is missing the point.  My message was about your
patches to _any_ part of our system, not limited to remote helpers.
