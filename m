From: Aaron Schrab <aaron@schrab.com>
Subject: Re: Redirect "git" subcommand to itself?
Date: Fri, 29 May 2015 09:24:53 -0400
Message-ID: <20150529132453.GA1308@pug.qqx.org>
References: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
 <xmqqoal5ii21.fsf@gitster.dls.corp.google.com>
 <87zj4n4w3t.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Christian Neukirchen <chneukirchen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 15:33:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyKPo-0006J7-Pm
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 15:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbbE2Ndd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 09:33:33 -0400
Received: from pug.qqx.org ([50.116.43.67]:42220 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755260AbbE2Ndb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 09:33:31 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2015 09:33:31 EDT
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 0F57457FF2; Fri, 29 May 2015 09:24:54 -0400 (EDT)
Mail-Followup-To: Christian Neukirchen <chneukirchen@gmail.com>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Disposition: inline
In-Reply-To: <87zj4n4w3t.fsf@gmail.com>
User-Agent: Mutt/1.5.22+188 (g1475d5c) (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270240>

At 10:38 +0200 29 May 2015, Christian Neukirchen <chneukirchen@gmail.com> wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>>  * You can help yourself with something like this, I suppose:
>>
>>    [alias]
>> 	git = "!sh -c 'exec git \"$@\"' -"
>>
>>    but I personally feel that it is too ugly to live as part of our
>>    official suggestion, so please do not send a patch to add it as
>>    a built-in alias ;-).
>
>So I thought I was clever, but this didn't work:

I've done the same as the original poster a few times myself, so awhile 
ago I added the following to my .gitconfig file:

[alias]
    git         = "!f() { git $@; }; f"

And this has worked for me.
