From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Feature request: "author branch" in commit object
Date: Tue, 2 Jul 2013 21:49:09 +0200
Message-ID: <20130702194909.GA24661@paksenarrion.iveqy.com>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ed Hutchins <eh@demeterr.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 21:49:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu6Zb-0001Ll-48
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 21:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab3GBTtG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jul 2013 15:49:06 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:47878 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab3GBTtE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 15:49:04 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so6022852lab.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 12:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vomp6aHZYdwARQy2rBmqi7DDf1lFCCk/BruS+Sunl0s=;
        b=Jp7quXJS0GDBB88E5WZv/VBkkOkXwV1j02HjjyuDHocu/QzBd/C2JLrvCwbcePHXyt
         rTnEQ87RVP6rY6YPGw5VsZ0jgE8T0hwEpLxOxGS7f/CZt0KZ/lxfA2UvA43SOHJDlxzS
         lKIu4hsvKlvalJ6mlhIcrZIKKkRqZIKg/0US3qvPeFcpNnldXBoi93HT8TThcRBmLkqn
         +2Q4lxqdt+cxkb+LfHjrY1V/1wanmZaSfHb5KL7ldLA06VOd1OOo5T7SOFPIV8dqACtg
         /4TD5xn261VFrBtn8+H1pkjDP1bDcVS8BJlQ/WxCrIlm+chM2SapkvPMRdOhHobFOEaz
         5kbg==
X-Received: by 10.112.219.102 with SMTP id pn6mr14567840lbc.18.1372794542466;
        Tue, 02 Jul 2013 12:49:02 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id e5sm9388850lbw.3.2013.07.02.12.49.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jul 2013 12:49:01 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Uu6ZZ-0005il-Rh; Tue, 02 Jul 2013 21:49:09 +0200
Content-Disposition: inline
In-Reply-To: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229423>

On Tue, Jul 02, 2013 at 12:37:13PM -0700, Ed Hutchins wrote:
> I realize that branch names are ephemeral repo-specific things, but i=
t
> would be really useful to be able to determine what branch a commit
> was authored from (as a hint to ancestry graph layout tools, for
> example). Is there any way to do this currently, is it planned, or
> would it be deemed useful enough to be worth adding to each commit
> object?

Let's see if I understand you. You want to (for each commit) to be able
to tell the branch-name the commit had at the creation time?

Not all commits have branches (however, loose commits is usually not
wanted). Many commits are part of many branches.

A branch is not a collection of commits but a pointer to a commit (whic=
h
has parents).

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
