From: Jim Cromie <jim.cromie@gmail.com>
Subject: Re: help doing a hotfix bisect: cherry-pick -m ??
Date: Fri, 7 Sep 2012 15:55:34 -0600
Message-ID: <CAJfuBxw4_VhyGENcgsBp0WohapAAmiqfEstWF-gjcnUestBwLw@mail.gmail.com>
References: <CAJfuBxwBn-WFw+nci1MpdWQvyXkrhyB3maXPwMAsxggTE3gz3Q@mail.gmail.com>
 <7v627py6or.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 23:56:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA6XG-00040k-8h
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 23:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758251Ab2IGV4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 17:56:14 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54107 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758131Ab2IGV4G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 17:56:06 -0400
Received: by wgbdr13 with SMTP id dr13so44930wgb.1
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K77eMhdkEYTNqZedga4kAiP9AM6J8tTDXFQlPud8lto=;
        b=qHq3EWK2HabGCWQl/fpStrEA58/oiZ3XLw1h7gVEjXTDHVcFiko1cV9p9zs/vOaqGL
         gg47T7WsR5MPfiGAnwIdbuVXbDzJUmJ7yanRUFfgMua2F6z1pQ1ojiM93sUkqYgqgBjW
         uNlLkBYMfHEmvXIktY/yFLwBhhXhpYMOjH6fAuDxktavDbJuphrrq1F6gTdfoM5npK4+
         /P1GLIidk5Wsph3NsIrdNbgfb7+hAuoDEogvsjQ2JLTFzYi+RGEvycggGCab6pFVESGQ
         Ok54Jm5JP359gTh493MJ4lyKkrCi+61qqeaAqTuL3j6HoaOoh4YC3Bh8fbjJwJfE5hzI
         NaQw==
Received: by 10.216.197.12 with SMTP id s12mr3920991wen.4.1347054965350; Fri,
 07 Sep 2012 14:56:05 -0700 (PDT)
Received: by 10.223.201.197 with HTTP; Fri, 7 Sep 2012 14:55:34 -0700 (PDT)
In-Reply-To: <7v627py6or.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205003>

On Fri, Sep 7, 2012 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jim Cromie <jim.cromie@gmail.com> writes:
>
>> Broader question:
>
>> Im thinking that having a hotfix branch, and merging --no-commit would
>> work better,
>> especially when bisection lands on a commit which already contains
>> some of those in the hotfix branch.
>
> When your history leading to the "bad" commit contains only part of
> the hot-fix branch and not all of it, that may work better.

good, I have a 1/2 grip at least. thank you.

any tips on how to use the -m option ?
Ive had no success passing small integers,
and I need to include the commits from the merged branch

The only alternative I have is to rework the split *_deferred patch
on top of the merge-point, and hope that it tests ok with the original
hotfix patch,
then I can probably do the bisect.
