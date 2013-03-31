From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 0/6] Support triangular workflows
Date: Mon, 1 Apr 2013 02:24:16 +0530
Message-ID: <CALkWK0=+7ctiiYJSs3SQvV8aywT4tvwGLZ02KLozP8zjU-LQ2g@mail.gmail.com>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
 <20130328153547.GA3337@sigill.intra.peff.net> <7vhajvv51f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 31 22:55:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMPHh-0008RV-Jl
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 22:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab3CaUy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 16:54:58 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:46792 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3CaUy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 16:54:57 -0400
Received: by mail-ia0-f174.google.com with SMTP id b35so1481798iac.33
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=55bd2ioYwSoID0gO2TZ8GN4BwTuUPWdB0pnO9aADk2I=;
        b=H2uGMpS0FwbjippKQOKISMdcYZueDhZSpH4ZJmmbQk8P62aUri3eRP/tTys6n7qxwi
         12Hp6qZfQc71YyKlN88owwG5h1vipQygFHlnL67tP1wARdJYvwnpHHSk9GAY6jjW9+Qz
         al/NCEtJBdJleaFUwpMALnB+iE4tw5NDGvQqIsWpjS1Ttp+moOkJKmoauWlSX0vTGLJ8
         odfe/OPZ5KyMR7GyvvejBlhDCqH7ONUR/z16SODETt764bl9ZrS2d3qCGEXrjED5H0ez
         qHvnmQ6rs9Xtk66v6HDm/gWw1/tpuuUAQ8Uhhb/VsTBXMilfxfGRldP4tvjOg0QH6b7s
         XVWg==
X-Received: by 10.50.17.166 with SMTP id p6mr2551320igd.12.1364763296866; Sun,
 31 Mar 2013 13:54:56 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sun, 31 Mar 2013 13:54:16 -0700 (PDT)
In-Reply-To: <7vhajvv51f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219641>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>> [...]
> Thanks.  That is one of the reasons why we do not want to see too
> many custom test helper functions.

I noticed that you queued my original series without modification in
rr/triangle.  Should I submit a re-roll with Peff's suggestion
incorporated?
