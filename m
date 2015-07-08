From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 18/23] checkout: retire --to option
Date: Wed, 08 Jul 2015 09:58:05 -0700
Message-ID: <xmqqvbduy4bm.fsf@gitster.dls.corp.google.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
	<1436203860-846-19-git-send-email-sunshine@sunshineco.com>
	<xmqqh9physyu.fsf@gitster.dls.corp.google.com>
	<CAPig+cSBp-U_jC3fcPXkZQ6kEPh7TRs2bAwKYQGGTtoGR3UYeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 19:20:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCsfm-0005dD-Gj
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 18:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848AbbGHQ6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 12:58:09 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34763 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628AbbGHQ6I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 12:58:08 -0400
Received: by igoe12 with SMTP id e12so5379455igo.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RG68YnwZ8Mv8g3PkwOfQQEVudtVPah387DccdUdhSDU=;
        b=dKAhTF4PLphTLU+iMqlqN/0rTEqQGwjAE77C+76vdnf/AghId+7+6/rigpsecsGgGZ
         bFEscp8oIRvcnSFinoy5S7qMKeBSYlP9badgS82PoejEgxv5LS7YQTz4NCUIyVIDRw30
         PenNoV04wPuMczoNoZfqxHjvhkYsL2DnUuVdRuEz885vd7/HUkTtimvSlMQXZx7LwGpC
         ICqEEx/Ob4l6v8uiyrtwKnDpjzh01FQLnpIgQn2YpFQ9NeV8IXbBbczS2+R3L+uC3CcB
         IqsjzA9+vIRKZV3oLbBsSJ5qy0HXgnDv1rSsT6nYAULziTARe1Np2WMxF0/rt+RkosK6
         w8iA==
X-Received: by 10.50.87.97 with SMTP id w1mr8155804igz.24.1436374687567;
        Wed, 08 Jul 2015 09:58:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6567:f006:f2bd:2568])
        by smtp.gmail.com with ESMTPSA id l62sm2179454iol.36.2015.07.08.09.58.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 09:58:06 -0700 (PDT)
In-Reply-To: <CAPig+cSBp-U_jC3fcPXkZQ6kEPh7TRs2bAwKYQGGTtoGR3UYeg@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 7 Jul 2015 03:08:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273692>

Eric Sunshine <sunshine@sunshineco.com> writes:

> ... as the series stands, the remaining ugly intimate knowledge
> between git-worktree and git-checkout is behind-the-scenes and
> localized (not affecting the user experience).

Hopefully.  Let's run with what we have right now.
