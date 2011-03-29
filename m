From: =?ISO-8859-1?Q?Daniel_Nystr=F6m?= <daniel.nystrom@timeterminal.se>
Subject: Re: [Q] Mark files for later commit?
Date: Tue, 29 Mar 2011 11:18:46 +0200
Message-ID: <AANLkTik33jiKipcv8d8tY_FXa2nE0BtBdi9vro0gkdQc@mail.gmail.com>
References: <AANLkTi=rPAQas3gvHJ+EFYTXP_YXuULQMk8o8pgkj=9T@mail.gmail.com>
 <7voc4uto9o.fsf@alter.siamese.dyndns.org> <7v8vvytldk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 11:19:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4V4v-0001mp-QP
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 11:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388Ab1C2JTD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 05:19:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62665 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab1C2JTC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 05:19:02 -0400
Received: by iwn34 with SMTP id 34so4619386iwn.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 02:19:01 -0700 (PDT)
Received: by 10.231.24.193 with SMTP id w1mr5272244ibb.41.1301390341132; Tue,
 29 Mar 2011 02:19:01 -0700 (PDT)
Received: by 10.231.33.65 with HTTP; Tue, 29 Mar 2011 02:18:46 -0700 (PDT)
X-Originating-IP: [85.24.181.147]
In-Reply-To: <7v8vvytldk.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: CKGA1rBissEiErCzV47mX_oQdzc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170248>

Den 29 mars 2011 09:51 skrev Junio C Hamano <gitster@pobox.com>:
>> Daniel Nystr=F6m <daniel.nystrom@timeterminal.se> writes:
>>> How would you like a git feature like described above, marking file=
s
>>> for later inclusion?
>>
>> That does not sound like a feature but merely a source of confusion.
>
> If that is the case, then probably you shouldn't be even updating the
> "changelog" file constantly to begin with. =A0Instead, how about crea=
ting a
> separate "changelog+" file that is not tracked, and keep its contents
> maintained continuously so stuff won't be forgotten? =A0When the time=
 to
> release comes, you can "mv changelog changelog", and commit it.

If we ignore this particular case, how would a "git hold <file>..." fea=
ture do?
--
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#	modified:   package/qt/qt.mk
#
# Changed but on hold:
#   (use "git add --holds <file>..." to update what will be committed)
#
#	modified:   CHANGES
#
no changes added to commit (use "git add" and/or "git commit -a")
--
Would there be other use-cases?
