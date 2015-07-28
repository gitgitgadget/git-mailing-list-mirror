From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: builtin/tag.c issue with sort option
Date: Tue, 28 Jul 2015 15:46:55 -0700
Message-ID: <CA+P7+xroaQy+Qu70jVnJ2NTVeOBE6-77_KcQTL1XiMzPzf-+qw@mail.gmail.com>
References: <CA+P7+xrkGh5iB2XunqRyU-iRfeFPq_ni0nPAMn-4gZVO-spnEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 29 00:47:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKDeZ-0007Dq-6m
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 00:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbbG1WrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 18:47:15 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34601 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbbG1WrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 18:47:14 -0400
Received: by ioea135 with SMTP id a135so3138103ioe.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=k45UfRZe1q0hSP+JYjMYJGCwrt1ettE7nCMusIaDKrs=;
        b=LENMzfzIV/bJdcL2TygtvzB/ljfz1/joCF+OO4OulBTD2+VhOzFaz4z7UNIRwundxn
         Dg8gJ4MP7i8rzhfd4LPrPAhVsUbHjbrU7PR0VXxT5RLLhnyAD9jms7RBUekaYhRsYRBB
         RfKP6wOum7pZVgNKcO2UIxksW+WMGTWOyTpI4FKnCMtQtp1VbI+SWb3bD5B/iKfU0Y//
         ZfRiJWzC4jlaK004VUZZxaxH/yMPasWwyKwqpEtKb4B99rCIN4Ou8dTwecpP2s4LdJDf
         vPY8xdWeEITrNAs88Ba9NPE5f3PTlbKsB4g0hVFmZyJjmwOk3KsWiCzLwYVdzi11yse2
         MQeQ==
X-Received: by 10.107.6.231 with SMTP id f100mr55858743ioi.61.1438123634295;
 Tue, 28 Jul 2015 15:47:14 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 28 Jul 2015 15:46:55 -0700 (PDT)
In-Reply-To: <CA+P7+xrkGh5iB2XunqRyU-iRfeFPq_ni0nPAMn-4gZVO-spnEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274863>

On Tue, Jul 28, 2015 at 3:27 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> When passing "-n" on the command line, if you have configured sort
> manually, you get an error as it thinks you passed --sort and -n.
>
> It should automatically disable tag_sort if it wasn't passed from the
> command line, as you probably know what you are doing when passing -n
>
> I'm attempting to work up a patch for this fix, but I am having a
> little bit of trouble and want to make sure it's right to fix this
> behavior.
>
> Regards,
> Jake

Actually, the sort and -n imcompatability is going away with the
unification of tag using the ref-filter API, so I think this is
actually not worth it to bother trying to fix, since it will be
removed soon anyways.

Regards,
Jake
