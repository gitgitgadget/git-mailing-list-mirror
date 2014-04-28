From: =?ISO-8859-1?Q?Jean-No=EBl_Avila?= <avila.jn@gmail.com>
Subject: Tagging  a branch as "not fitted for branching" ?
Date: Mon, 28 Apr 2014 14:09:43 +0200
Message-ID: <535E4507.2070805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 14:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WekNc-0002HY-Rr
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 14:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbaD1MJs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 08:09:48 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:41709 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076AbaD1MJr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 08:09:47 -0400
Received: by mail-wi0-f180.google.com with SMTP id q5so5518787wiv.13
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=Xu9AW+Ho4OnC2edoYNGWk9+UVt+Bte3rr6I+WpViRqU=;
        b=SzMeR/Z3+0urnyPfe34e54bJeop6kXMreHf+Gfyucyb4QfAcJiBY4XgXDBjPrNtqmq
         wapLGRr03iGMM7hdBjEdYnUNICr7StOY1W7J4DCmQc4Wor9VhKvlpYcbMdlYjR8uzQAb
         yryrgezjBtyjkhUJZ6lbRicziyGnUaPGISQIML6BjL0PMhjqw6V36P41PxMlZ/52+D/H
         r1qCiyIIX9RHooP2IJEfUaYbvsKj8nkK+6F8fa90A6vkZKwYtJetMavTUWFpdMT/pICS
         LeiAohCua6VkgipJ8Vvt0J71uF8KAq0GcSjhrrQgjtIE/du65SMyjp3n86fcoiDeFPYE
         cEgw==
X-Received: by 10.194.120.101 with SMTP id lb5mr766331wjb.74.1398686985666;
        Mon, 28 Apr 2014 05:09:45 -0700 (PDT)
Received: from [192.168.1.95] (static-csq-cds-097114.business.bouyguestelecom.com. [164.177.97.114])
        by mx.google.com with ESMTPSA id mw4sm17380261wib.12.2014.04.28.05.09.44
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 05:09:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247307>

Most manuals on git state that it is bad practice to push -f a branch=20
after have meddled with its history, because this would risk to upset=20
the repositories of the coworkers. On the other hand, some workflows us=
e=20
branches to propose modifications, and need some rewritting of the=20
history after some review steps. In this case, the branch should only b=
e=20
seen as a mere pile of patches. Having this two-sided discourse is ofte=
n=20
misunderstood by casual git users.

The proposed solution would be to be able to flag the branches with a=20
special tag "not fitted for branching" that a collaborator could use=20
when pushing it. This tag would be passed on to any pulled remote. When=
=20
another collaborator would then issue a "git checkout -b", the command=20
would fail with a warning message, unless forced with '-f'.

Is this feature already present? If not, would it be of any interest?

Best regards,

Jean-No=EBl AVILA
