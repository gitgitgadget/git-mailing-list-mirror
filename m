From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [ANNOUNCE] Git v1.8.5-rc2
Date: Mon, 18 Nov 2013 14:42:40 -0500
Message-ID: <528A6DB0.1050702@xiplink.com>
References: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>	<5284FE88.8040208@xiplink.com>	<xmqqvbzpbq4d.fsf@gitster.dls.corp.google.com> <xmqqiovpbl4r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 20:42:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViUib-0007PO-HO
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 20:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955Ab3KRTml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 14:42:41 -0500
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:60203 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab3KRTml (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 14:42:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp12.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 606A42E0191;
	Mon, 18 Nov 2013 14:42:40 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp12.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 099112E0174;
	Mon, 18 Nov 2013 14:42:39 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqiovpbl4r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238009>

On 13-11-18 01:49 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Marc Branchaud <marcnarc@xiplink.com> writes:
>>
>>>> Foreign interfaces, subsystems and ports.
>>>>
>>>>  * "git-svn" used with SVN 1.8.0 when talking over https:// connection
>>>>    dumped core due to a bug in the serf library that SVN uses.  Work
>>>>    it around on our side, even though the SVN side is being fixed.
>>>>  ...
>>>>  * Subversion 1.8.0 that was recently released breaks older subversion
>>>>    clients coming over http/https in various ways.
>>>
>>> Isn't this the same as the serf fixes ([1],[2])?  If not, what git change is
>>> it referring to?
>>
>> The latter, I think, is 8ac251b6 (git-svn: allow git-svn fetching to
>> work using serf, 2013-07-06).  Without it we won't even work with
>> newer SVN library.
>>
>> The former I think refers to 73ffac3b (git-svn: fix termination
>> issues for remote svn connections, 2013-09-03).  Even with the serf
>> support, without a work-around, we won't work with serf.
>>
>> The description can and should be rolled into one, but I am not sure
>> what the best wording would be.
>>
>> Thanks.
> 
> I'd keep them as separate entries, like so:
> 
>  * "git-svn" has been taught to use the serf library, which is the
>    only option SVN 1.8.0 offers us when talking the HTTP protocol.
> 
>  * "git-svn" talking over https:// connection using the serf library

<pedantic>
s/talking over https/talking over an https/
</pedantic>

>    dumped core due to a bug in the serf library that SVN uses.  Work
>    around it on our side, even though the SVN side is being fixed.

Those look good to my layman's eyes.

		M.
