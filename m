From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 09/10] user-manual.txt: explain better the
 remote(-tracking) branch terms
Date: Tue, 26 Oct 2010 02:20:03 -0400
Message-ID: <AANLkTinJQMSbW-bsEOS9610GXR7EtbESK_tLAfxt2ibK@mail.gmail.com>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr> <1287986922-16308-10-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Oct 26 08:20:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PActo-0001Vi-5I
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 08:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970Ab0JZGUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 02:20:36 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55004 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab0JZGUf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 02:20:35 -0400
Received: by yxn35 with SMTP id 35so2629946yxn.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=MDU0BYypqpGnuJz8W5Cs80uIwDxKiv4z9mqL5OkaD6s=;
        b=CulCsj1EuUxgX7FZu81Eg+DunmdSFzTZp8y4Bwoniq+em6Qvnnbn4fKLPd3lwjUcg3
         2WCDghPeT53GWXqVarV4VJaoJzHSu5mE3K39RHYZNaLZNO3Xudf3lnHH5J1pw/N6ZyAw
         PiDOPpo/yToxCgKDmjTvDuv7f+kcNLY3jW6ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dxFy2CMv03sbJMceZAv4Q8bBqFZ/gAC0h29VXwKWAKwMbhYrlLRFowZAKwngkVRv+2
         R1c522NwtdQcV6TKfIwvqwMz86VlWq2uNKRyZtgfNfef58PTj1sUb2lD5Pwl+6Whj14T
         N372/JqPRBGWseAd1+0VjykIvbOH6OP+y18Fk=
Received: by 10.42.115.138 with SMTP id k10mr2768816icq.335.1288074034789;
 Mon, 25 Oct 2010 23:20:34 -0700 (PDT)
Received: by 10.231.150.201 with HTTP; Mon, 25 Oct 2010 23:20:03 -0700 (PDT)
In-Reply-To: <1287986922-16308-10-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159981>

On Mon, Oct 25, 2010 at 2:08 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> +In this case, "origin" is called a remote repository, or "remote" for
> +short. The branches of this repository are called "remote branches"
> +from our point of view, and Git will keep a copy of these
> +branches, called "remote-tracking branches" in the local repository.
> +These remote-tracking branches are references that will be updated by
> +"git fetch" (hence by "git pull"). See
> +<<Updating-a-repository-With-git-fetch>> for details.

"...and Git will initially clone these branches into so-called
"remote-tracking branches" in the local repository. Thereafter, the
remote-tracking branches are updated upon fetching from[1] or pushing
to the remote. ([1] which also includes pulling.)

j.
