From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7 06/12] builtin: add rewrite helper
Date: Thu, 24 Apr 2014 18:57:12 -0400
Message-ID: <CALkWK0nqd3_-1BvUTbS+K=6PRgJON7sdEHE0EJcADLhDb73nqw@mail.gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com> <1398307491-21314-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 00:58:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdSak-0007Sx-2d
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 00:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbaDXW54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 18:57:56 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:61717 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbaDXW5w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 18:57:52 -0400
Received: by mail-ig0-f175.google.com with SMTP id h3so1522264igd.14
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 15:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Er63oXdJj4PRIWBA3SBA/tgPHsUc59ZTQTc6QxPHMu0=;
        b=drcX8Xg5GpX+s5GSE3lv3GL6uCLm7s+KrLlN86GWINIbd8mzp/DCu9PgJojNhRujH8
         p1/ydjsUMRdVYbPXcsvDWYfjF3x6v6Ss7ncfHXutJaMUKfiKWZeuVYfQfspO1WsGYAmD
         Baur1TTWo0fjfnMbqsY/3LhxEQ1GLK/cn2+g6gMuhBru7qQXUlQd6G+tzMU+MXm8esN+
         u+qEf+e4NqeHMtSwDC7kLRiD2y/LHTfulRqU16ugQakiBroVA5AIbv3nWmcCo7MbYLsb
         BbiiZyakUETNsZ+wkqvdP4JOO5fmzR/LHm1dCntrzMcV5B8ciciUDpCPWuWqNGnKfZRR
         wang==
X-Received: by 10.42.82.148 with SMTP id d20mr4208877icl.50.1398380272163;
 Thu, 24 Apr 2014 15:57:52 -0700 (PDT)
Received: by 10.64.10.39 with HTTP; Thu, 24 Apr 2014 15:57:12 -0700 (PDT)
In-Reply-To: <1398307491-21314-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247020>

Felipe Contreras wrote:
> So that we can load and store rewrites, as well as other operations on a
> list of rewritten commits.

Please elaborate. Explain why this code shouldn't go in sequencer.c.
