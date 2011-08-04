From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 19/19] Rename struct git_attr_check to git_attr_value
Date: Thu, 04 Aug 2011 05:20:29 +0200
Message-ID: <4E3A0FFD.7010604@alum.mit.edu>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu> <1311828418-2676-20-git-send-email-mhagger@alum.mit.edu> <7vsjpjg6k7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 05:20:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QooUA-0004T8-SN
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 05:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016Ab1HDDUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 23:20:35 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39435 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab1HDDUd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 23:20:33 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEB339.dip.t-dialin.net [84.190.179.57])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p743KTD3026467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 4 Aug 2011 05:20:30 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vsjpjg6k7.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178661>

Thanks for the good feedback.

On 08/02/2011 05:46 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This described its purpose better, especially when used with
>> git_allattrs().
> 
> You probably meant s/described/describes/ but more importantly does it
> really? It is a structure used to probe into the attributes system for the
> state of various attributes on a path, and the set of possible states
> includes "there is no value" (aka unset), so it feels actively wrong to
> call it attr_value and that is why I didn't call it in the first place.

I don't think it is so unusual for a "value" object to be able to
reflect the fact that the value is unset, but I can understand your
point of view too.  I will omit this renaming in the re-roll.

> I also think git_all_attrs() (i.e. word-break underscore after "all") is
> more in line with the naming throughout the codebase, after looking at
> output from
> 
>   $ git grep -e _all'[a-z]' --and --not -e alloc -e _all_ -- '*.c'
> 
> Other than these, and the earlier comment about the copy&paste done from
> git_checkattr (which by the way should probably be "git_check_attr"), it
> seems that the series mostly consist of good clean-ups and an addition of
> a new and (probably) useful feature that is straightforward. Nice.

I thought the name was awkward, too, but I chose it to be consistent
with git_checkattr().  So in the re-roll I will happily rename both
functions.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
