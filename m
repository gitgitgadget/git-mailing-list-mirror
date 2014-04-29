From: James Denholm <nod.helm@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 22:25:46 +1000
Message-ID: <514ff3d6-aea5-4b1d-8ff4-14e779876fb1@email.android.com>
References: <535C47BF.2070805@game-point.net> <535D4085.4040707@game-point.net> <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com> <535D6EB1.9080208@game-point.net> <535e18cdc7bce_338911e930c72@nysa.notmuch> <87bnvl6bdg.fsf@fencepost.gnu.org> <535e8e4253196_45651483310b3@nysa.notmuch> <152626b3-0642-4e26-9333-7d911d45c669@email.android.com> <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch> <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com> <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch> <220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com> <535f62c1e740a_45e485b30887@nysa.notmuch> <87r44g33z4.fsf@fencepost.gnu.org> <535f702352d21_3aee3b2f0b9@nysa.notmuch> <87mwf431t3.fsf@fencepost.gnu.org> <535f76db38a34_6f23159b31099@nysa.notmuch> <87eh0g30it.fsf@fencepost.gnu.o
 rg> <535f7c35cb5b1_7c7c10e32f019@nysa.notmuch> <752e9542-7450-4928-a9cb-79b9c3b69bcd@email.android.com> <535f915e3ed89_2719108f30817@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 14:26:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf76o-0008DJ-NR
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 14:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934028AbaD2MZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 08:25:58 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:56420 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932982AbaD2MZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 08:25:57 -0400
Received: by mail-pa0-f44.google.com with SMTP id ey11so121701pad.17
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 05:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=KzVo8fZ99wWHtdKy8UeP3w2iscaQ+wVwXEfUEQ5OnDg=;
        b=aIq/6tdkcBf2dVzKwL4o3ef4fRVLJ5OKadU9laC0oGziEcr/VygJA6pZtwsNBqm62w
         h1OgoVEYqZxbLzUS4izhkwsgp99EW0d+JtcXy380b4C3eOSFPqEbZs+cYQyVTehZ152X
         gltQn2topgdV9JQAgT/+LXdfuuQST+5vkawFILxBVXq+waxmKNjI8NQtjipa5P2ZuC7P
         MbLAzPpbfAUttzc+psYVDG7o6Kt18xFICwWWEsG/96blMH6j//BkrTZsk+k8/6ExP0Z6
         xQbR+NQcCQ5vxggG5uslAW7UaDVIaOC3FIRR8TLYhHAH9xajDT/OaEhlZU61ZrMzLRp7
         uFhg==
X-Received: by 10.66.124.137 with SMTP id mi9mr32875606pab.111.1398774354437;
        Tue, 29 Apr 2014 05:25:54 -0700 (PDT)
Received: from [10.86.17.135] ([101.119.28.242])
        by mx.google.com with ESMTPSA id pb7sm109861316pac.10.2014.04.29.05.25.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Apr 2014 05:25:53 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <535f915e3ed89_2719108f30817@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247579>

On 29 April 2014 21:47:42 GMT+10:00, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>James Denholm wrote:
>> I've no right to say this, given that I've no contributions I'm not
>> saying that you shouldn't work on the git codebase, you could very
>> easily fork it and make the innovative SCMS none of us can see, and
>> kill git. Can be done, if hunting really is the best choice as you
>> say.
>
>I already made a fork:
>
>http://felipec.wordpress.com/2013/10/28/git-fc/

Sweet. So now you're going to get open source journalism
interested in git-fc and gain a groundswell of support, right?
So that we can all have egg on our faces when it takes off
and is proven superior... Right?
