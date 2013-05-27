From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] commit: don't use-editor when allow-empty-message
Date: Mon, 27 May 2013 23:27:00 +0530
Message-ID: <CALkWK0kpDDP0Gid4aWPf-JsV5SbrVYH+s+5ncW4XuHqs0Lp7QQ@mail.gmail.com>
References: <1369663431-2405-1-git-send-email-artagnon@gmail.com>
 <1369664419-16440-1-git-send-email-artagnon@gmail.com> <CALWbr2zW7BKwkNd5gU8vyE8KvMkzUMf1zTOr5X0cxsO7_4KA=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Mislav_Marohni=C4=87?= <mislav.marohnic@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 19:57:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh1g1-0003M3-Iy
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 19:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199Ab3E0R5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 13:57:41 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36629 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab3E0R5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 13:57:41 -0400
Received: by mail-ie0-f171.google.com with SMTP id s9so1206233iec.16
        for <git@vger.kernel.org>; Mon, 27 May 2013 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oX7t8k0m8qp01fdvaplNCCOOIoQZ5AR5zzlJ4a2KMlg=;
        b=dXgmdOZqlrEPsKhQNsZsd0IqplW/uE9BJiCx+vC9XgDGngBCmqJlLSEwojS25xZt8w
         vnafJQT7326oY93juQCfA27u4Db0f0Pb7qATsD9bFEgbApRqdEwil0R+uqnrk5Ggzqu1
         Jx/ZErMJUxdeXIlt7ygy9ewbGJHC3hzuuje1TKNpWhAb9TcnHdhEtt/uYpBrmYJIl76b
         0mXHZyKu+jXaiaX1SvXIcB2Hs/OuniWq6u+aj4Pm66jJ5/L4xu20lAlnovXRa+JYfIBD
         pLI2wkYAhbjjY8E+HN0STCZjHvBR0AyyJb5xFriz1wTILRgr5qVzA7PDVqpaVEOa6ubL
         O38w==
X-Received: by 10.50.107.6 with SMTP id gy6mr45694igb.57.1369677460812; Mon,
 27 May 2013 10:57:40 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Mon, 27 May 2013 10:57:00 -0700 (PDT)
In-Reply-To: <CALWbr2zW7BKwkNd5gU8vyE8KvMkzUMf1zTOr5X0cxsO7_4KA=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225612>

Antoine Pelisse wrote:
> So now we have two fixes for the same issue, don't we ?
> You probably missed $gmane/225534.

Gah, missed that.  Sorry for the noise.
