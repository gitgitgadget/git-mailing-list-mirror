From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Pull is Evil
Date: Thu, 01 May 2014 15:43:07 -0400
Message-ID: <5362A3CB.5020203@xiplink.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com> <xmqqoazlqot4.fsf@gitster.dls.corp.google.com> <536106EA.5090204@xiplink.com> <xmqqppjyhnom.fsf@gitster.dls.corp.google.com> <536152D3.5050107@xiplink.com> <5361598f8eaf7_4781124b2f02b@nysa.notmuch> <536173F5.7010905@xiplink.com> <53617877b41a9_41a872f308ef@nysa.notmuch> <20140501094610.GB75770@vauxhall.crustytoothpaste.net> <5362664C.8040907@xiplink.com> <53629eda40a52_76612eb2f062@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 21:42:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfwsW-0001Sj-3f
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 21:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbaEATmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 15:42:40 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:40592 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaEATmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 15:42:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp31.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 8E8103A853A;
	Thu,  1 May 2014 15:42:39 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp31.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 826833A8304;
	Thu,  1 May 2014 15:42:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53629eda40a52_76612eb2f062@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247832>

On 14-05-01 03:22 PM, Felipe Contreras wrote:
> Marc Branchaud wrote:
>> What's more, it seems to me that the only real advantage "git pull"
>> provides here is a less typing compared to the non-pull equivalent:
>>
>>   git fetch main-repo
>>   git checkout main-repo/maintenance-branch
>>   git fetch developer-remote
>>   git merge --no-ff developer-remote/topic-branch
>>   git push main-repo HEAD
> 
> You mean `git push main-repo HEAD:maintenance-branch`, right?

Right.  Sorry, for that command I thoughtlessly just copied Brian's example.

		M.
