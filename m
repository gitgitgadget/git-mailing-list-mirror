From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 1/2] am: handle stray $dotest directory
Date: Tue, 18 Jun 2013 12:35:39 +0530
Message-ID: <CALkWK0kq6+K4fotWq1Qz9BrqOG56NezJqnfH9Xrg1vh6AS9bnw@mail.gmail.com>
References: <1371300192-6222-1-git-send-email-artagnon@gmail.com>
 <1371300192-6222-2-git-send-email-artagnon@gmail.com> <7v38shjw01.fsf@alter.siamese.dyndns.org>
 <7vy5a8ei6u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 09:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uopzk-0000QB-7k
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 09:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704Ab3FRHGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 03:06:20 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:61696 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab3FRHGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 03:06:20 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so8633567iee.6
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 00:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iIVicIft8FVnnhOcp0yP8M6jwF0sGDBwi89Sr1NU5g8=;
        b=Fg7elqeEw4bxjUEKrCCDeqXK9sTm5FK5OnxiN2un47qIqlJ8oN34yb1JYx1aw+lktI
         y8brOo0cLYi2WIbivcvdWHVN1qQLnR7036db66JWzVfVIq9m+7RN8DGHwvtqQrUCHE/o
         iyK6hzWHyKjJPFUlUGuerVsBLHTBfrQVVAiRwvo/dq/hyh5wUhZjmibeFdbY5fKs0nd1
         6n1imyPOfZhmRokbwc87E8nvDOJeQUtXfI4lZSJ0f8vFsuCEeXAPOZLF1/9bgQT8t24e
         ZicUCwSpbZw7kuYkCpyhL6cCKjYfXw8XJBNpkJ8yzYiDm5FydyMTXEt51DfDlVNeeTtd
         tMrg==
X-Received: by 10.50.23.8 with SMTP id i8mr6899178igf.42.1371539179812; Tue,
 18 Jun 2013 00:06:19 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 00:05:39 -0700 (PDT)
In-Reply-To: <7vy5a8ei6u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228163>

Junio C Hamano wrote:
>> Will replace what has been queued on 'pu'.
>
> ... after fixing an indentation error, that is.

Where did the error occur?  I thought I taught my Emacs to always
indent properly.
