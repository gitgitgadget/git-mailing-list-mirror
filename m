From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Mon, 25 May 2015 18:58:41 -0700
Message-ID: <xmqq1ti49k1a.fsf@gitster.dls.corp.google.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
	<xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
	<CAJ80savVjb3_iKhNWPjQNK72DL7eq5YkbjWWG-1Gkx5+LOjzeg@mail.gmail.com>
	<CAJ80sas_D-6z4MvuFvvjoX7U_bM6b3brCo4rvYFCUfTmKS=6bA@mail.gmail.com>
	<xmqqpp5obotk.fsf@gitster.dls.corp.google.com>
	<xmqq1ti4bbu0.fsf@gitster.dls.corp.google.com>
	<xmqqtwv09w84.fsf@gitster.dls.corp.google.com>
	<CAJ80sauXaaOjQhybxWVrHJpNQhHCKOd2Le1vFqEwBef6gYjqrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 03:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx48n-0004vL-E3
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 03:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbbEZB6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 21:58:45 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34019 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbEZB6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 21:58:44 -0400
Received: by igbhj9 with SMTP id hj9so48378567igb.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 18:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QbGKMDr5EdlDN9DfUeSnji/ibVzSjNubbLCrFnCpbG4=;
        b=d0LN9FopFWIAq2bmvXZfwBbrUidohkxuP9tCCCqqbseMigr3Ed5bwt9GuHmdoAmmBa
         RuAUDSIXokTlUUlYAhGpXhaa77waJu5ji+AaJaDvzV/StnPg8rMGNoWpabP2qY4+Ga2U
         o3AxmsSKToDeN9fR/A16+uCWKLi/1toegpXELTKAZFuzhpFYKYBJfouXtiv7v/b9PzPF
         2jxj4CyEuN8SgY/ICFfjuYiMn2OdEvpsptnLWiQJghWlgPi7ATNQT8j9fjwScls1UPiA
         K9P29GMw7+8Cs9NHmUaAj49lyxKnSR79sb/M/NYZUIv74IR+WiFk2OMg2f46JWjJeJzI
         uWiQ==
X-Received: by 10.50.78.170 with SMTP id c10mr2580331igx.0.1432605524022;
        Mon, 25 May 2015 18:58:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id q78sm10021480ioe.9.2015.05.25.18.58.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 18:58:42 -0700 (PDT)
In-Reply-To: <CAJ80sauXaaOjQhybxWVrHJpNQhHCKOd2Le1vFqEwBef6gYjqrQ@mail.gmail.com>
	(Allen Hubbe's message of "Mon, 25 May 2015 21:51:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269919>

Allen Hubbe <allenbh@gmail.com> writes:

> Thanks for letting me know.  Are you still expecting v6 from me then?
> The other thing you asked for was a change in the documentation: just
> mention the email programs' documentation, and describe the
> exceptions.

Could you fetch from me and then run:

 $ git log --reverse -3 -p 6b733ee4ba330e1187017895b8426dd9171c33b8

to see if you agree with the result?  That is what I queued on 'pu'
for now with my fixups.

We have not heard from Eric on this round yet, so he (and others)
may have further input, but as far as I am concerned, that one
looked more or less ready to be merged down to 'next', except for
the documentation part, which I haven't had a chance to look at the
results and may need further AsciiDoc mark-up fixes.

Thanks.
