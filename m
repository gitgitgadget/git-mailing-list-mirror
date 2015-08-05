From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/10] Port branch.c to ref-filter.
Date: Wed, 05 Aug 2015 14:35:49 -0700
Message-ID: <xmqq614t2zbe.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
	<CAOLa=ZSR=7mvOG+RPSJ_xxr3k644WOiqirTrNMo-=jcXbtM3yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:36:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN6Ls-0006S0-7b
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 23:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbbHEVfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 17:35:52 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33577 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbbHEVfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 17:35:51 -0400
Received: by pabyb7 with SMTP id yb7so13337354pab.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FPzum/AS1j9C3lBRgmpWXjpkzmlo5j/GnywlfuIwA4M=;
        b=WK6unM0ZnweBz0K0eKU3kW63S7K4FrrqwWf80axjlKZqErhCPraD9OFif0Xrfw2LaT
         5TNyIgOrTtBlatKquDXXv3k45Ivp+o93fGRCsjG4fE0ElxvWplpTgVvjUREtBsPbMFeW
         DV79WMfdXnOGWpAW+m1QeUHn4rDWibgEJ8oIVmpL2Cd10OvrsHCEKgU6jY7stO5WtjZb
         boUsSbnxvR1LGuTgX+NXtzk+Hw4/sBYPFVyEPVjUrIS2nhKWNUErlvk5LBQd9FsHcVX3
         gYMkuMUdFh1quHesXxG+Ep7op0+gisExbpMjADe8c0ft4ItCLvxClu5/mzZq/gCVyBOR
         AdCA==
X-Received: by 10.66.161.105 with SMTP id xr9mr24004810pab.50.1438810551436;
        Wed, 05 Aug 2015 14:35:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id nd6sm3952032pbc.65.2015.08.05.14.35.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 14:35:50 -0700 (PDT)
In-Reply-To: <CAOLa=ZSR=7mvOG+RPSJ_xxr3k644WOiqirTrNMo-=jcXbtM3yw@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 4 Aug 2015 18:31:53 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275402>

Karthik Nayak <karthik.188@gmail.com> writes:

> There are nine patches in the series. Have put "0/10" by mistake.

FYI, format-patch has --cover-letter option.
