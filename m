From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 3/7] test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
Date: Mon, 11 Nov 2013 14:20:15 -0500
Message-ID: <52812DEF.1010801@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com> <1384142712-2936-4-git-send-email-rhansen@bbn.com> <5280c17489798_6841541e7877@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 20:20:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfx27-0006GH-9O
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 20:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab3KKTUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 14:20:18 -0500
Received: from smtp.bbn.com ([128.33.0.80]:45427 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830Ab3KKTUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 14:20:16 -0500
Received: from socket.bbn.com ([192.1.120.102]:57684)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vfx1z-000FVv-QZ; Mon, 11 Nov 2013 14:20:15 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 8DA3D3FF72
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <5280c17489798_6841541e7877@nysa.notmuch>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237637>

On 2013-11-11 06:37, Felipe Contreras wrote:
> Richard Hansen wrote:
>> Change 'git push' to 'git push -u <remote> <branch>' in one of the
>> test-bzr.sh tests to ensure that the test continues to pass when the
>> default value of push.default changes to simple.
> 
> This makes sense.
> 
>> Also, explicitly set push.default to simple to silence warnings when
>> using --verbose.
> 
> This doesn't. Run the tests in t/* and you would seen tons and tons of those
> warnings, if they should be avoided, they should be avoided for all the tests,
> why only these?
> 
> I say drop the second part. Yes it's annoying, but we have to deal with it.

OK, will do.

Thanks,
Richard
