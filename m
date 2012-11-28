From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] svnrdump_sim: start the script with /usr/bin/env python
Date: Wed, 28 Nov 2012 22:32:47 +0100
Message-ID: <CAMP44s3dfY=UODdH+Q+YQiP5pwaoHpuDNwbOYh5GUF7AmoJigw@mail.gmail.com>
References: <20121128025734.21231.47468.chriscool@tuxfamily.org>
	<7vy5hmgovt.fsf@alter.siamese.dyndns.org>
	<CAMP44s17Gycr2tWOLYAxMG7-CGP3SpFf7XTWf94qGg3WfVpT-A@mail.gmail.com>
	<CAP8UFD08LhywQ9KaNoeG1nORZwtK8MNWqwjfRJPyT2vLkNgs9A@mail.gmail.com>
	<7vmwy1hdgx.fsf@alter.siamese.dyndns.org>
	<CAMP44s3YfLrL+74j5DOVVATK8GWEo1qHnmJDW5dLWJRxK_CVLQ@mail.gmail.com>
	<7v7gp5v7y1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:33:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdpFf-0004qR-Fm
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 22:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995Ab2K1Vcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 16:32:48 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:50016 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab2K1Vcs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 16:32:48 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so10662147vcm.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 13:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=riG7A7keCqjuID47zhBAnRJNuAnWlAFo+o8hA2PKbVc=;
        b=gDHWVuM4a0nrtsCDgVgVpKadmwcHu2a0o4IFziFiM+5jEfWLj9jtJLI/M8Wa7FOpmN
         am98JfIm+f+JzGR2o/AeeL4HSQwbTgODScT9sCHEBWWV47YZBYAxm6YjJ3UBc5Ucimse
         p4Phl6P38k6EzZPASiQrthzYEgmIU2TVNMDGXX0bomCzASPBkF66wy9NERNHB5ABO1mz
         3M16WW3xpVkLo6fKzMNnXuvm8zt81Iwn7hsHeq9jDpbsCFRHnDfwIBvjh5NiSY+u7YP+
         lbba73Bq2Dl+JxjGo+BGAHxT0QA4cL+IBohC/PMvEws2SvcAWMcjf/Zkwo8tykx3TG8k
         ZZSg==
Received: by 10.52.75.105 with SMTP id b9mr26010017vdw.28.1354138367505; Wed,
 28 Nov 2012 13:32:47 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Wed, 28 Nov 2012 13:32:47 -0800 (PST)
In-Reply-To: <7v7gp5v7y1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210781>

On Wed, Nov 28, 2012 at 8:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, Nov 28, 2012 at 5:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> You need a fix for that; didn't I already say "you need a bit more
>>> than that"?
>>
>> I disagree. Most of the contrib scripts are expected to be used as
>> they are.
>
> You are only looking at one of the uses for this script, when there
> are two.
>
> You are correct that distros may install with whatever tweaks of
> their own, and to help their tweak process (like the one that
> specifically notices "/usr/bin/env python" as you wrote), changing
> the "#!/usr/bin/python" to match others would be a good change.
>
> But that change alone is not sufficient for this one, which is used
> from t/ script.  You cannot treat this one like import-zips and
> hg-to-git that we do not use in-tree.  Somewhere before t9020 uses
> it, it needs the treatment similar to the rewriting that is done for
> git-p4.py to git-p4.

Unless the tests are moved to contrib, which I think is a good
practice: should anything in contrib break 'make test'? I don't think
so.

Cheers.

-- 
Felipe Contreras
