From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 5/5] bisect: allows any terms set by user
Date: Tue, 23 Jun 2015 11:48:22 -0700
Message-ID: <xmqq8ubadzwp.fsf@gitster.dls.corp.google.com>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435064084-5554-6-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 20:48:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7TFG-00073S-8o
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 20:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933031AbbFWSs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 14:48:26 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34891 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932980AbbFWSsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 14:48:25 -0400
Received: by iebrt9 with SMTP id rt9so18070913ieb.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Dn8SEgPgDoUWvI8HrhUL7+YApNT7ch45q6nqGanUueM=;
        b=XyFdGhdD26C9ADXQNhw6GQF2IP6qmSRUwPkKa8XT1v1yj9XEBWUL+LsRgo4xV057Ce
         XtyrFaLscOEQXc2hXLrwOPpwPkOFwXDMmGBhwCNwWByJb5KRPqWKFCURNvbDD8ULb1g7
         Sdo5/b7rB8blPjZYOi8ZTIiNhleBl08H/4GxdPWUjpUcba2lMNtTrGVA3otDEoEItBdm
         6yv8llIG2mp741bWnORagPOPjB2Vna1DIhYIHODzN0zhtalnVQkP7zOXB4GH2+7qbjba
         qOxbCOGqw4tDJFSTTgLBGk05KWzhCbi3IIMYiyiXwuUcY0szNMcfGbh1ppLCPYZg5GIy
         1TvA==
X-Received: by 10.43.148.72 with SMTP id kf8mr34048561icc.76.1435085304510;
        Tue, 23 Jun 2015 11:48:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id c63sm15626101ioe.42.2015.06.23.11.48.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 11:48:23 -0700 (PDT)
In-Reply-To: <1435064084-5554-6-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Tue, 23 Jun 2015 14:54:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272478>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>Subject: Re: [PATCH v7 5/5] bisect: allows any terms set by user

s/allows/allow/;

> +Alternative terms: use your own terms
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Lengths of underline and the text must match.
