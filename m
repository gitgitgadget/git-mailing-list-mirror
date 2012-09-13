From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: is this behaviour expected for "git clone --single-branch"?
Date: Thu, 13 Sep 2012 20:48:19 +0200
Message-ID: <CAN0XMOKszADpeaCG7VhL-AZ3m7_hSWV3NhEmPuH6FETzs=eDNg@mail.gmail.com>
References: <CAN0XMOJsVOCzp2_BOQVUKy3cV8JA9AG+=Bw4tC2ZzDfK0AcQVg@mail.gmail.com>
	<7v627h92xv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:48:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCESj-0006KC-FP
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab2IMSsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:48:21 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61638 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab2IMSsV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:48:21 -0400
Received: by wibhi8 with SMTP id hi8so7278978wib.1
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 11:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H3/pz/UmjTM3ulTHzZFzNnBk2B7a3RfpIys6PLtL0eo=;
        b=i+DcboTRUjLAIr+uMkwzTr2zArdJFf3tQBfHbB8XJ79tDfjIaJwTyz/YJ17OEvpSEF
         1lNR+y45wfr1M8BOJxs9RoRSNcqLABV9YO/d31BrkfJQh4kpckakKNM9tVeiMqtiSB+U
         hzSjAI/G49rEVrHuaR3w6usDR6zDem1RW7GxUNpOmfN/TxuPtpt/8Ro6CQjbYOWnARSr
         dHmYOjo55v6tNmRBmg3rGKES/atG6E4ITXQDsHBP7wyC1VwpbI6rQCvdzuL4jtupcBch
         VmaQ6aMYzRktGnuYIKGFf29jIIzmZUPFSCwVm5/ROP979Zg+VreFOhAwR62UtRyxw33F
         bpoA==
Received: by 10.216.255.146 with SMTP id j18mr60445wes.163.1347562099769; Thu,
 13 Sep 2012 11:48:19 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Thu, 13 Sep 2012 11:48:19 -0700 (PDT)
In-Reply-To: <7v627h92xv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205413>

On Thu, Sep 13, 2012 at 8:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> # looking again to my branches
>
> Don't look at your branches, but look at how the refspecs are
> configured by "git clone" in .git/config; I suspect we just write
> the default 'refs/heads/*:refs/remotes/origin/*' pattern.

Indeed.

$ cat .git/config
[remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*
