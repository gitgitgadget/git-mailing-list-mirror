From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 10/30] refs: wrap top-level ref_dirs in ref_entries
Date: Thu, 26 Apr 2012 16:38:52 +0200
Message-ID: <4F995DFC.501@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu> <1335307536-26914-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 26 16:39:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNPqv-00007n-AO
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 16:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989Ab2DZOjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 10:39:20 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39291 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab2DZOjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 10:39:19 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3QEcq1M007102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Apr 2012 16:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <1335307536-26914-11-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196371>

On 04/25/2012 12:45 AM, mhagger@alum.mit.edu wrote:
> From: Michael Haggerty<mhagger@alum.mit.edu>
>
> Wrap the top-level ref_dirs in REF_DIR style ref_entries so that we
> have the flag and name available when dealing with them.  This
> affects:
>
> * cache_ref::loose
> * cache_ref::packed
> * extra_refs
>
> The next several commits will expand the use of ref_entry as opposed
> to ref_dir, culminating in the ability of a ref_entry representing a
> directory of loose references to load itself only when used.

The mention of "extra_refs" here is of course obsolete and should be 
deleted.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
