From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/7] t5700: document a failure of alternates to affect
 fetch
Date: Mon, 13 Feb 2012 05:45:27 +0100
Message-ID: <4F389567.8060108@alum.mit.edu>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu> <1328941261-29746-2-git-send-email-mhagger@alum.mit.edu> <7vsjifids5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 05:45:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwnnK-00055Z-WA
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 05:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab2BMEpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 23:45:38 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:39330 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab2BMEph (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 23:45:37 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEA12C.dip.t-dialin.net [84.190.161.44])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1D4jR3e025772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 Feb 2012 05:45:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Lightning/1.0b2 Thunderbird/3.1.18
In-Reply-To: <7vsjifids5.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190605>

On 02/13/2012 04:35 AM, Junio C Hamano wrote:
> mhagger@alum.mit.edu writes:
> 
>> +test_expect_success 'prepare branched repository' '
>> +	git clone A J &&
>> +	(
>> +		cd J &&
>> +		git checkout -b other master^ &&
>> +		echo other > otherfile &&
> 
> s/ > / >/; but that is nothing I cannot fix locally.
> 
>> +test_expect_failure 'fetch with incomplete alternates' '
> 
> I am assuming that this "incomplete" means "this alternate helps reducing
> the number of objects we need to fetch from the remote, but it does not
> have everything objects we need, and we still need to fetch some from the
> remote".  Am I correct?

Correct.  Feel free to improve the description if you can think of a
better way to describe it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
