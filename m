From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2015, #04; Tue, 16)
Date: Wed, 17 Jun 2015 09:35:49 -0700
Message-ID: <xmqq4mm647iy.fsf@gitster.dls.corp.google.com>
References: <xmqq616n5mb0.fsf@gitster.dls.corp.google.com>
	<333261417.557730.1434541149518.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:36:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5GJj-00073W-8X
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 18:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899AbbFQQfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 12:35:53 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34347 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbbFQQfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 12:35:51 -0400
Received: by iebmu5 with SMTP id mu5so37574084ieb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4gsMnd9fEbhzyfuvadQdL+ZRa82dpQ4wnSUGUhJn4k8=;
        b=hyNsoP7lJhBTGHCODsV+HWBonPrJ1+ai0XappMWv3ivPLWqbGf/EJcxAH2VkomZ0mr
         I80L+JNodEH15OpWvayvobvALukeqoZj3KDsyWTtlc9HcqR6wHvxcUhjXaPDTlfme+C2
         m3vSNxRiSaUibwQXrSP5UhDR8xLXqcuj+E11Xwbe5LRw7r6ybI4Y36PAwxrzcsygnngK
         pTArRJfklpOzMv8wNtHxA8Hkd8iLwqrPeVkbXonjcWvI3aAO2YzOSpNKWwDKXEgtaOj8
         4JohhZaFW6LPAeghT0LWeBmqkYz7T8sfpyvAK0itjRsixX6JniBIFDZ9pnwYhv1g9Xz1
         3Jtw==
X-Received: by 10.50.50.210 with SMTP id e18mr36477856igo.0.1434558950436;
        Wed, 17 Jun 2015 09:35:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id o2sm3474274igr.9.2015.06.17.09.35.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 09:35:49 -0700 (PDT)
In-Reply-To: <333261417.557730.1434541149518.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Wed, 17 Jun 2015 13:39:09 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271866>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> * gr/rebase-i-drop-warn (2015-06-01) 2 commits
>> - git rebase -i: warn about removed commits
>> - git-rebase -i: add command "drop" to remove a commit
>>
>> Add "drop commit-object-name subject" command as another way to
>> skip replaying of a commit in "rebase -i", and then punish those
>> who do not use it (and instead just remove the lines) by throwing
>> a warning.
>>
>> What's the status of this one?
>
> A third commit was added (static check).
>
> I have some corrections and refactoring to do after the reviewing 
> (and less time than before), a reroll is to be expected before 
> next week.

Thanks.
