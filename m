From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] diff: turn skip_stat_unmatch on selectively
Date: Thu, 30 Jan 2014 12:36:58 +0700
Message-ID: <CACsJy8Dd+baRUi0YjnqDXFi-Fv=K9NxwO=YbYuVEfQkdEXWWWQ@mail.gmail.com>
References: <1390632411-3596-3-git-send-email-pclouds@gmail.com>
 <1390863568-22656-1-git-send-email-pclouds@gmail.com> <xmqqd2jdm1jj.fsf@gitster.dls.corp.google.com>
 <xmqq7g9jlny6.fsf@gitster.dls.corp.google.com> <20140128235203.GA7788@lanh> <xmqq61p2k2u5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 06:37:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8kJi-0008Mo-W3
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 06:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbaA3Fha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 00:37:30 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:35497 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaA3Fh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 00:37:29 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so4297554qcy.12
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 21:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z9Y12nvn8NLdH2QEvPJgRFyCyBr+NfTrv72Lu/lcVmw=;
        b=Tg2ADTXbW1MdWNukpjs4EAngvZKiNC2IIk9IS+DBv0/kOMHxSieHc6iTTCWkzgiKy5
         w5UpQe5VUw7BdfccbB0fOj4AiuL4awH4HtEn5X9IGxP3vZ6U14fiNC6t4+lsEmPV+d49
         6IuuX+151+zENVXGiCgBaewAjHu8QP8iZvMSyi6ieovZeJtDts+DLy0zImeWsDII27z1
         vB+cYtrf9FoMXh280r1AKOQT4bm7QhWvSkSv0MfUSTEjfB6eMc6y5qtAChwyroNqD85R
         QN/pd15hRqVT9GMXcRQwn/zHgvLm3fe+bGZYz8JoYmX/ylWjuVuoXIuTeMfltvAYDcZz
         BELg==
X-Received: by 10.224.167.84 with SMTP id p20mr18870281qay.24.1391060248737;
 Wed, 29 Jan 2014 21:37:28 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Wed, 29 Jan 2014 21:36:58 -0800 (PST)
In-Reply-To: <xmqq61p2k2u5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241238>

On Thu, Jan 30, 2014 at 2:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Tue, Jan 28, 2014 at 02:51:45PM -0800, Junio C Hamano wrote:
> This however shows that the existing test *KNEW* that it was enough
> to check just a few cases (especially, there is no reason to make
> sure that blob vs file-in-working-tree case behaves sanely), because
> the auto-refresh would kick in for all codepaths.  Now you are
> making that assumption invalid, shouldn't the patch also split the
> tests to cover individual cases?

Drop the last patch, then. It's a "while at there" cleanup patch. If
it's non trivial then it could be taken up later when somebody's
interested. I have a few topics ongoing and not sure I'll go through
diff.c to identify and write tests for all cases.
-- 
Duy
