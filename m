From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] RelNotes: Spelling & grammar fixes.
Date: Mon, 18 Nov 2013 11:58:27 -0800
Message-ID: <20131118195827.GI27781@google.com>
References: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>
 <1384448473-25840-1-git-send-email-marcnarc@xiplink.com>
 <xmqqmwl1blg7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 20:58:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViUxx-0006RZ-TP
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 20:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab3KRT6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 14:58:34 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:48029 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab3KRT6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 14:58:33 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so46091yha.31
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 11:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KUc5fNYBk8eN/7Q4UTdntqRgBEewlBqJliSG6NQvogQ=;
        b=g+yWL+gObyNHWE2R5N+UzdyxNIVc5UOwt9Li3hAWQvJxFD+mSAVnVK3FEsALjv7V0r
         xCZlpERYZLl3JFiA7++RuNC+f22RSYKyiEG7IneKGaHomIsqIgbwozjl843HPZK5mEUR
         KmYwa8wQYqimuHQqpmm5L660DrAjfY9lQ6/yzEYhY3fJ+hXJsbmxYUNwdhghZ+13VIZ+
         qbiUAsnIKTBFbp8kKEsoAkM4AZyJVN+V3RBcWmrJ/uQRmzvGfjmJmGkuN06ge1VgDU9F
         sW+HmG6NAkkVNi/Gia0yHQQHZx4+wv+b37TeTAoK4tb0Lmdy5gBfGovc0kmM3mKMw2SI
         1LHw==
X-Received: by 10.236.135.175 with SMTP id u35mr2213830yhi.96.1384804710695;
        Mon, 18 Nov 2013 11:58:30 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w8sm29701168yhg.8.2013.11.18.11.58.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 Nov 2013 11:58:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqmwl1blg7.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238011>

Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:

>>   * "git branch -v -v" (and "git status") did not distinguish among a
>> -   branch that does not build on any other branch, a branch that is in
>> -   sync with the branch it builds on, and a branch that is configured
>> -   to build on some other branch that no longer exists.
>> +   branch that is not tracking any other branch, a branch that is in
>> +   sync with the branch it is tracking, and a branch that is tracking
>> +   some other branch that no longer exists.
>
> People use the verb "track" to mean too many different things, and
> the original deliberately tried to avoid use of that word.
>
> Specifically, we try to limit the use of "track" to mean "to keep a
> copy of what we observed from the remote" as in "remote-tracking
> branch remotes/origin/master is used to track the 'master' branch at
> your 'origin'", which is very different from "your 'master' branch
> builds on your upstream's 'master'".

How about something like the following, in the same spirit as --track
giving way to --set-upstream-to)?

	* "git branch -v -v" and "git status" did not distinguish among a
	  branch that does not have a corresponding upstream branch, a
	  branch that is in sync with its upstream, and a branch whose
	  upstream no longer exists.
