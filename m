From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 15:33:41 -0700
Message-ID: <4FA307C5.102@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com> <201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com> <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com> <4FA2D8EA.7030809@palm.com> <87obq5ggpu.fsf@an-dro.info.enstb.org> <7vehr1dl2z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 00:33:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ4ap-0002ks-1S
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 00:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149Ab2ECWdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 18:33:42 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:62702 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516Ab2ECWdm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 18:33:42 -0400
X-IronPort-AV: E=Sophos;i="4.75,527,1330934400"; 
   d="scan'208";a="13298946"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 03 May 2012 15:33:41 -0700
Received: from joso.noir.com ([10.100.2.3])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q43MXf5r009769;
	Thu, 3 May 2012 15:33:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <7vehr1dl2z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196969>

On 5/3/12 14:13 , Junio C Hamano wrote:
> Ronan Keryell<Ronan.Keryell@hpc-project.com>  writes:
>>>>>>> On Thu, 03 May 2012 12:13:46 -0700, Rich Pixley<rich.pixley@palm.com>  said:
>>      Rich>  * the hg error messages are straightforward, clear, and don't
>>      Rich>  require any deep knowledge of the source code control system
>>      Rich>  or it's limitations.  (I still don't understand what the git
>>      Rich>  message on collision is saying.)
>>
>> This is a very good suggestion.
>> ...
>> At least, print a simpler message with some typical use case causing
>> this and some workflow ideas before the detailed explanation.
> It indeed is a good starting point to make a suggestion, but there is
> nothing actionable in the above by itself, especially since "typical use
> case" is quite different for different Git users.
How about, "Your push can't be made because it would cause an 
irreconcilable collision.  You probably want to pull and merge before 
attempting to push again."

--rich
