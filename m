From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCHv4] repack: rewrite the shell script in C.
Date: Tue, 20 Aug 2013 20:38:55 +0200
Message-ID: <5213B7BF.3040100@kdbg.org>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com> <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com> <52136F9C.6030308@kdbg.org> <52138686.1070304@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, l.s.r@web.de, mfick@codeaurora.org,
	apelisse@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com,
	mackyle@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 20:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBqpk-0007TZ-Qg
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 20:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061Ab3HTSjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 14:39:08 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:3880 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750812Ab3HTSjH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 14:39:07 -0400
Received: from [10.73.122.231] (178.115.250.231.wireless.dyn.drei.com [178.115.250.231])
	by bsmtp.bon.at (Postfix) with ESMTP id 9BEA81000F;
	Tue, 20 Aug 2013 20:39:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <52138686.1070304@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232626>

Am 20.08.2013 17:08, schrieb Stefan Beller:
> On 08/20/2013 03:31 PM, Johannes Sixt wrote:
>> You cannot run_command() and then later read its output! You must split
>> it into start_command(), read stdout, finish_command().
>
> Thanks for this hint. Could that explain rare non-deterministic failures in
> the test suite?

Yes, it's a possible explanation.

-- Hannes
