From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 02/16] sha1_file: refactor into `find_pack_object_pos`
Date: Tue, 25 Jun 2013 15:59:28 +0200
Message-ID: <87fvw5nae9.fsf@linux-k42r.v.cablecom.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-3-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:33:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urarg-0004mL-9a
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897Ab3FYVdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 17:33:24 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:54771 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867Ab3FYVdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 17:33:23 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 25 Jun
 2013 23:33:17 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.210.110) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 25 Jun 2013 23:33:20 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.210.110]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228994>

Vicent Marti <tanoku@gmail.com> writes:

>  	if (use_lookup) {
> -		int pos = sha1_entry_pos(index, stride, 0,
> -					 lo, hi, p->num_objects, sha1);
> -		if (pos < 0)
> -			return 0;
> -		return nth_packed_object_offset(p, pos);
> +		return sha1_entry_pos(index, stride, 0, lo, hi, p->num_objects, sha1);
>  	}

Our house style prefers not having the braces in a single-line conditional.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
