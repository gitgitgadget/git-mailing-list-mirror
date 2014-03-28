From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Mar 2014, #07; Fri, 28)
Date: Sat, 29 Mar 2014 00:23:03 +0100
Message-ID: <53360457.1060008@alum.mit.edu>
References: <xmqqtxai7ym6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 00:23:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTg7F-0005X6-OX
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 00:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbaC1XXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 19:23:09 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56588 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751116AbaC1XXI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Mar 2014 19:23:08 -0400
X-AuditID: 12074412-f79d46d000002e58-8e-5336045ab86d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B6.8D.11864.A5406335; Fri, 28 Mar 2014 19:23:06 -0400 (EDT)
Received: from [192.168.69.148] (p57A25B98.dip0.t-ipconnect.de [87.162.91.152])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2SNN4BZ013276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 Mar 2014 19:23:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqqtxai7ym6.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqBvFYhZs0HRH12LnOgmLrivdTBYN
	vVeYHZg9Pj5bzu5x8ZKyx+dNcgHMUdw2SYklZcGZ6Xn6dgncGZsXxxRsYat4N/c1YwPjTNYu
	Rk4OCQETiQUnt7NB2GISF+6tB7K5OIQELjNK9L67wgLhnGeSWPC3gRGkildAW+LRiyUsIDaL
	gKrEnh/bmEFsNgFdiUU9zUwgtqhAkMThDadYIeoFJU7OfAJWLyJgLfH753ewGmag3m8t/8Bs
	YQF7if7mVUD1HEDLrCSud6uCmJxA5S/PS4GYEgLiEj2NQRCNOhLv+h4wQ9jyEtvfzmGewCg4
	C8muWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10wvN7NELzWldBMjJJSFdjCu
	Pyl3iFGAg1GJhzez3TRYiDWxrLgy9xCjJAeTkijv439AIb6k/JTKjMTijPii0pzU4kOMEhzM
	SiK82Z+BcrwpiZVVqUX5MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKErwFzGbBQoJF
	qempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg2I0vBkYvSIoHaO9ckHbe4oLEXKAoROsp
	RmOOWxvWNDJxbNgGJIVY8vLzUqXEeStBSgVASjNK8+AWwZLYK0ZxoL+FeYtAqniACRBu3iug
	VUxAq7iqjEBWlSQipKSAKaRT6mnNDb1nTOfcNKVFMj9cPfm0oKbzftqLJYcaOssNe3+3tUXI
	pe2p2WCp+49xew9re9+CnI6UbaeUd3bY8oUHN3FEsIQyvkjv7cv46DjTjtWeuf9i 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245430>

On 03/28/2014 11:21 PM, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.

Junio,

Have you overlooked my ref-transactions series [1], or just not gotten
to it yet?

If you would like a version of the series that already addresses Brad
King's comments, you can get it from my GitHub fork [2], the
"ref-transactions" branch.  I'd be happy to post a v3 to the list if you
prefer, but the only changes since v2 were to a commit message and a
comment so it seems like overkill.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/244857
[2] https://github.com/mhagger/git

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
