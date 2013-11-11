From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 3/7] test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
Date: Mon, 11 Nov 2013 16:16:10 -0500
Message-ID: <5281491A.4050806@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>	<1384142712-2936-4-git-send-email-rhansen@bbn.com> <CAMP44s1phHVjiETB3fK3FwjOcJ4+6YYCYt5pvOWJL+RM37QLfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 22:16:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfyqH-0007hq-W2
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 22:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab3KKVQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 16:16:14 -0500
Received: from smtp.bbn.com ([128.33.1.81]:40726 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab3KKVQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 16:16:13 -0500
Received: from socket.bbn.com ([192.1.120.102]:44807)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VfyqA-000PsC-So; Mon, 11 Nov 2013 16:16:10 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 9877C3FEF1
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CAMP44s1phHVjiETB3fK3FwjOcJ4+6YYCYt5pvOWJL+RM37QLfw@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237654>

On 2013-11-11 14:31, Felipe Contreras wrote:
> On Sun, Nov 10, 2013 at 10:05 PM, Richard Hansen <rhansen@bbn.com> wrote:
> 
>> @@ -379,7 +382,7 @@ test_expect_success 'export utf-8 authors' '
>>         git add content &&
>>         git commit -m one &&
>>         git remote add bzr "bzr::../bzrrepo" &&
>> -       git push bzr
>> +       git push -u bzr master
>>         ) &&
> 
> Actually, why -u? Isn't 'git push bzr master' enough?

It's defensive in case that test is ever updated to do more pushing.  I
can leave it out in the reroll.

-Richard
