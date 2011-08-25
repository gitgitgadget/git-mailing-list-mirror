From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Aug 2011, #07; Wed, 24)
Date: Thu, 25 Aug 2011 09:43:50 +0200
Message-ID: <4E55FD36.1020107@alum.mit.edu>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 09:44:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwUbY-00031g-Vh
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 09:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab1HYHn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 03:43:56 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50730 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab1HYHnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 03:43:55 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7P7ho6M023290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 25 Aug 2011 09:43:50 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180063>

On 08/25/2011 02:09 AM, Junio C Hamano wrote:
> * mh/iterate-refs (2011-08-14) 6 commits
>  - Retain caches of submodule refs
>  - Store the submodule name in struct cached_refs
>  - Allocate cached_refs objects dynamically
>  - Change the signature of read_packed_refs()
>  - Access reference caches only through new function get_cached_refs()
>  - Extract a function clear_cached_refs()
> 
> I did not see anything fundamentally wrong with this series, but it was
> unclear what the benefit of these changes are.  If the series were to read
> parts of the ref hierarchy (like refs/heads/) lazily, the story would
> have been different, though.

I am still working on lazy reading and hierarchical storage of reference
caches.  It's OK with me if you defer merging the above patch series
until I have made more progress on the more significant improvements.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
