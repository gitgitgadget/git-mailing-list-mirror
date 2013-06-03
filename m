From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 3/6] completion: add common options for blame
Date: Mon, 3 Jun 2013 11:03:10 +0200
Message-ID: <87mwr7zhv5.fsf@linux-k42r.v.cablecom.net>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 11:03:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjQfc-00016B-RG
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 11:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab3FCJDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 05:03:13 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:28513 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab3FCJDM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 05:03:12 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 3 Jun
 2013 11:03:10 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 3 Jun 2013 11:03:11 +0200
In-Reply-To: <1370181822-23450-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 2 Jun 2013 19:33:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226207>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Add support for completing 'git blame'.  List only the common short
> options.
[...]
> +_git_blame ()
> +{
> +	__git_has_doubledash && return
> +
> +	case "$cur" in
> +	-*)
> +		__gitcomp "-M -C -L -s -w"
> +	esac
> +	__git_complete_revlist_file
> +}

Is this the first time we introduce completion (I guess you could call
it "help") for short options?  I only did a quick search for /-. -/ but
it certainly seems that way.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
