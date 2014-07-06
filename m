From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v5 2/2] test-config: Add tests for the config_set API
Date: Sun, 6 Jul 2014 19:24:26 -0400
Message-ID: <CALkWK0n9MWux3tA02n-hDvPjXt3Q1RCVd+x8tJV9ABjndaGQCQ@mail.gmail.com>
References: <1404631162-18556-1-git-send-email-tanayabh@gmail.com> <1404631162-18556-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 01:25:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3voF-0004Bi-Pr
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 01:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaGFXZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 19:25:09 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33752 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaGFXZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 19:25:08 -0400
Received: by mail-ig0-f181.google.com with SMTP id h15so3785553igd.14
        for <git@vger.kernel.org>; Sun, 06 Jul 2014 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qfe5fLMTLLj4RNQG1Bf57kFsblhfswNTkhSjyn07jik=;
        b=04eD8hISu/4Q8Q9cBHghmT98KnEF9BfXHlc8Po1t0egHyanGbesoEhC6pQ49hp6m9P
         AJqQA+eXUpqJDLpZZJyHiXvrYsS9iYINa8Rlzm0RWubdhpSndleHdwVYbwn6ewsnsGEd
         FsJ7ZAN4pXLVWh4lp+HEImx5eIB7HXOEVWuo0Z7PgOUC4qJMVJXRObQm9qSuMaRJ1n2p
         5aQhbRO97mS43q6/q4EaHobmqGUrgC3Uh/BPvAXNebSrTqjQLS6vpaKADKB7UKJe6skH
         Aba5cdtpyisz0YJsOneNoD7bRYFKYNDKvOKUgTKaFUDdavGPdJ4CQ9eFXPwXhnkOhOXy
         /Ffg==
X-Received: by 10.50.43.168 with SMTP id x8mr1549088igl.36.1404689106342; Sun,
 06 Jul 2014 16:25:06 -0700 (PDT)
Received: by 10.64.228.242 with HTTP; Sun, 6 Jul 2014 16:24:26 -0700 (PDT)
In-Reply-To: <1404631162-18556-3-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252944>

A couple of quick nits.

Tanay Abhra wrote:
> +test_expect_success 'clear default config' '
> +       rm -f .git/config
> +'

Unnecessary; a fresh temporary directory is created for each test run.

> +test_expect_success 'initialize default config' '

You might want to mark this as "setup".
