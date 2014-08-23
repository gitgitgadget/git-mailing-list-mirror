From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: check-ref-format: include refs/ in the argument or to strip it?
Date: Fri, 22 Aug 2014 19:59:00 -0700
Message-ID: <20140823025900.GM20185@google.com>
References: <gerrit.1408574889668.Iac983fc86f7edd2a0543779d85973c57bf068ca4@code-review.googlesource.com>
 <047d7b624d36142d46050131f336@google.com>
 <20140822154151.GK20185@google.com>
 <xmqqmwawnzfk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 04:59:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL1Xs-00079l-4N
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 04:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbaHWC7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 22:59:06 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:62144 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbaHWC7F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 22:59:05 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so17274972pab.2
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 19:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kfZy095ccoWYDBUdaVTOHWpt4c+SYEpPzZxqLpymYe0=;
        b=vNk522GGVjOeTpgePKyasdvyKcZfHlx0IsNPYWGJ6y185n5DEa3QORxgFyupcm5P4u
         xR38I0bU9WtZY9eVWxIVlpRnnf6c2PDiyNjcDUa+pYfnZlMpj3bNAvnXh024XQtlPOFo
         fyrH7wtkALmJedEO5IxpdQlYDd0/wuHCy+3pvM+15qvrQO54ol2OHBBZTjIcFUkMhKce
         uj8S97JxmTySW+WskvOrsooTt0rR+tPDz5S7DzHyY6chzr2Wub/Tql97n7IDUEybhdZq
         XynjOVJKrcNowRGHXtaCJ+IpLnieF6/eDox3EA11jKVkDE5mOScErfyDGwaZ3sxLPBpb
         MZHw==
X-Received: by 10.66.102.37 with SMTP id fl5mr4469354pab.35.1408762743464;
        Fri, 22 Aug 2014 19:59:03 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c57b:d378:4566:1b8f])
        by mx.google.com with ESMTPSA id om7sm33365006pdb.61.2014.08.22.19.59.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Aug 2014 19:59:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqmwawnzfk.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255727>

Junio C Hamano wrote:
>> Michael Haggerty wrote[1]:
>>> Jonathan Nieder wrote:

>>>> The check-ref-format documentation is pretty unclear, but the
>>>> intent is that it would be used like
>>>>
>>>>	git check-ref-format heads/master
>>>>
>>>> (see the surviving examples in contrib/examples/). That way, it can
>>>> enforce the rule (from git-check-ref-format(1))
[...]
>>> Thanks for the explanation and the pointer.
>
> I wanted to follow this discussion, especially the ellided [...]
> "pointer", but had a hart time finding what "pointer" was.

I missed this question before.

The discussion happened at https://code-review.googlesource.com/1017.
It's easier to see after clicking the 'Expand All' button, but even
then it's hard to see the signal in the 'Patch Set <n> was rebased'
noise.

The pointer Michael mentioned was to the git-check-ref-format(1)
manpage and old 'check-ref-format' callers that can be found in
contrib/examples/.  Sorry for the lack of context.

Jonathan
