From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Mon, 25 May 2015 19:55:43 -0700
Message-ID: <xmqqwpzw82ts.fsf@gitster.dls.corp.google.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
	<xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
	<CAJ80savVjb3_iKhNWPjQNK72DL7eq5YkbjWWG-1Gkx5+LOjzeg@mail.gmail.com>
	<CAJ80sas_D-6z4MvuFvvjoX7U_bM6b3brCo4rvYFCUfTmKS=6bA@mail.gmail.com>
	<xmqqpp5obotk.fsf@gitster.dls.corp.google.com>
	<xmqq1ti4bbu0.fsf@gitster.dls.corp.google.com>
	<xmqqtwv09w84.fsf@gitster.dls.corp.google.com>
	<CAJ80sauXaaOjQhybxWVrHJpNQhHCKOd2Le1vFqEwBef6gYjqrQ@mail.gmail.com>
	<xmqq1ti49k1a.fsf@gitster.dls.corp.google.com>
	<CAJ80sauoB-quepDf2V=-WqewzJ_nN+ALA-z-vcL_4c8rObxpBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 04:55:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx51y-0002Uu-BS
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 04:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbbEZCzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 22:55:45 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38078 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbEZCzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 22:55:45 -0400
Received: by igcau1 with SMTP id au1so43641121igc.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 19:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rHxKzRRVBvSXS9FMh9NOlf/aDiIglYeEWDn3ISyAU/E=;
        b=nZU1e9Z7KkYK+6kLxI5AM4u+VSsprqA1cYAEStTj6Uj6NldYBGc15xOqkDDP93g64N
         KHUIUs8tRzohEtelj8vUiP0bYqFuKXBw8ZUDvGsLz0hFeCtrTa4ei0F2aiFwvFMddsUP
         POg0FKcJXMWm9xzKqXr5x0NEa62vEvHdKUfGuDJcHYTfHNr51Dm5l9AZvn6R9PtNDLVU
         mUNH8UM37FMWOjfcDQ1B7rpBa+VJRC2PMP6jDi1x+dK5muYbqeirebxShPOpjFzXRnC5
         Pp+A5PFIneLo9XJ6egx0Ihbh0N3O4X3OHSyg5x8qpfH7mj3Ifw3NdzwmqsYTZ3+Huq6t
         5sIA==
X-Received: by 10.43.84.73 with SMTP id aj9mr27531483icc.69.1432608944654;
        Mon, 25 May 2015 19:55:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id g1sm10124866iog.4.2015.05.25.19.55.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 19:55:44 -0700 (PDT)
In-Reply-To: <CAJ80sauoB-quepDf2V=-WqewzJ_nN+ALA-z-vcL_4c8rObxpBg@mail.gmail.com>
	(Allen Hubbe's message of "Mon, 25 May 2015 22:16:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269924>

Allen Hubbe <allenbh@gmail.com> writes:

>> Could you fetch from me and then run:
>>
>>  $ git log --reverse -3 -p 6b733ee4ba330e1187017895b8426dd9171c33b8
>>
>> to see if you agree with the result?  That is what I queued on 'pu'
>> for now with my fixups.
>
> It looks good to me.  How would you like me to proceed?  I assume you
> would like your patch on top of mine will stay, to use HOME instead of
> tilde.  Or, would you like me to use HOME in my v6, too?
>
> Should I send you v6 like v5, but with the documentation fixed, or
> would you now prefer a separate patch on top of that to fix the
> documentation?

It probably should be two patches.  Your sendmail thing with docs
and tests as one patch (with $HOME in test), and fix to mailrc tests
I did (minus the part that fixes your sendmail test, which should
now become unnecessary) on top.

If the documentation I queued on 'pu' formats well already (which I
cannot check myself until tomorrow), then I'd guess the above would
be like squashing 8b8fb5a into dc6183c and then 6b733ee on top, I
think.

 6b733ee t9001: write $HOME/, not ~/, to help shells without tilde expansion
 8b8fb5a git-send-email doc: refer to upstream document for alias format
 dc6183c send-email: add sendmail email aliases format
