From: Jeremy Morton <admin@game-point.net>
Subject: Re: Running interpret-trailers automatically on each commit?
Date: Fri, 28 Aug 2015 18:07:12 +0100
Message-ID: <55E09540.60805@game-point.net>
References: <55E07CB1.0@game-point.net> <xmqqk2sf2vic.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:09:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVN9D-0000Ko-NJ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 19:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbbH1RI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 13:08:59 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:46955 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbbH1RI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 13:08:59 -0400
Received: from [192.168.1.3] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id CA72918A00F2;
	Fri, 28 Aug 2015 12:07:56 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <xmqqk2sf2vic.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276734>

Yeah but it's kind of useless to me having it on each commit on a 
per-repo basis (and even then, only with hooks).

-- 
Best regards,
Jeremy Morton (Jez)

On 28/08/2015 18:06, Junio C Hamano wrote:
> Jeremy Morton<admin@game-point.net>  writes:
>
>> I see that interpret-trailers has been added by default in git
>> 2.5.0. However the documentation isn't that great and I can't tell
>> whether it gets run automatically when I do a "git commit".  My guess
>> is that it doesn't - that you have to set up a hook to get it to run
>> each commit.
>
> All correct, except that it happend in 2.2 timeframe.
>
> A new experimental feature is shipped, so that people can gain
> experience with it and come up with the best practice in their
> hooks, and then laster we may fold the best practice into somewhere
> deeper in the system.
>
> We are still in the early "ship an experimental feature to let
> people play with it" stage.
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
