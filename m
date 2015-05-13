From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "HEAD -> branch" decoration doesn't work with "--decorate=full"
Date: Wed, 13 May 2015 10:13:49 -0700
Message-ID: <xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
References: <55534D95.60609@alum.mit.edu>
	<xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 13 19:14:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsaEH-0005Y1-QF
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 19:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbbEMRNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 13:13:52 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38852 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965027AbbEMRNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 13:13:51 -0400
Received: by igbhj9 with SMTP id hj9so51025408igb.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=euGZ+0FRPafVx5ZG+brk1PSdYJ50n04UjqW9Ej8MmgM=;
        b=ZY1WbNmUCkT8v6JtyAOzei/PLEmZW1Y7UkcLRTtHV3O1gonmNOHyXqvPxcpCMphrOM
         O8GX8bQkBoc95inq7rdZacGgUzTLFb36AmvpVgea0Cif9+gaHlmWaHtEaL3xYFF2iqWF
         6d1ZQiRETQ5SUlYiamZWuFQjuMYuPg3eOlNM16L9TGZ3NaEIbePAdDnpdUqpAQd3sRo7
         lqeryv0EEPDWzJk+FpXmMo8Z3FH3t/20wv1mDW5OdeMaA/CTdO9CRRO1xxtkHmayy073
         IwWH1Ao2o79mP45iuW9nv7mecupisxTgMPZlwGtyCBldLOGPDZcERsyevwXJxcQFPcGa
         04Hg==
X-Received: by 10.50.57.51 with SMTP id f19mr29311420igq.6.1431537231207;
        Wed, 13 May 2015 10:13:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id q11sm4021019igr.3.2015.05.13.10.13.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 10:13:50 -0700 (PDT)
In-Reply-To: <xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 13 May 2015 10:11:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268993>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> Was that an oversight or a conscious decision?
>
> I actually think this ultimately comes from a poor design of the
> name-decorations infrastructure.

I should have said "poor design of the way how the name-decorations
infrastructure is used in log-tree (and commands in the log family)".

The name-decorations infrastructure itself is just fine.
