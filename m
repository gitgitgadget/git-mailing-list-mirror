From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Error logging for git over ssh?
Date: Wed, 15 Jan 2014 08:51:44 +0700
Message-ID: <CACsJy8Cp4Tw4_5px_fp4JY4TDdK2uH+1fYdiM8CBmbisbBbCmw@mail.gmail.com>
References: <CACPiFCKBK49Zm8oYcGMVfmsgRwDrPyzWcU7vM6DwJeQitBNsnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 02:52:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3FeW-0007S2-IU
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 02:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbaAOBwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 20:52:16 -0500
Received: from mail-qe0-f45.google.com ([209.85.128.45]:33710 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbaAOBwP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 20:52:15 -0500
Received: by mail-qe0-f45.google.com with SMTP id t9so481806qeq.32
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 17:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9yARXAO/YLxc3pYie8bG32ERxxY3JBs7yr79+dsHe0s=;
        b=puB5nM7p3dtqqEfXjlvTpOg1fFh3FW8AS0F4GOeuoNeebAAN3p8YB+Yiaa9CIx6fKM
         RdpgqDB2auldh6DLCQQmvwYTu7aFbrxxz1V6f182oGjXRnps+qOR9wxuC4tEwaQKfQ8B
         wPGc97Waeum74xmVD6H/Blb4jJQR2IYEssGYM9tTJ8obpd+7uehohfTzziucDbCla5Wf
         avN3Sw2+/oLhC0Y6tFSkZBPWUixVt+MO2vcJLNOgnAETyDcVba3pXrzXi9RTVCzBx3Jo
         bINI1tinzcF0zVlA65aVBqtfSo9xtbEAlWlwbFRVjhlknJ7r9GOG8pw1nK1unW6YaYwC
         IU1g==
X-Received: by 10.224.67.137 with SMTP id r9mr9171823qai.8.1389750734313; Tue,
 14 Jan 2014 17:52:14 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Tue, 14 Jan 2014 17:51:44 -0800 (PST)
In-Reply-To: <CACPiFCKBK49Zm8oYcGMVfmsgRwDrPyzWcU7vM6DwJeQitBNsnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240429>

On Wed, Jan 15, 2014 at 1:44 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Diagnosing errors with git over ssh has historically required tooling
> up for debugging or looking at things from the client side, because
> git does not log anything on the server side.
>
> It would be a boon to those running busy git servers to be able to
> diagnose by looking at a log. It can be both old-fashioned, or very
> modern (if you are using journald).

Maybe we could put a "pager" program in front of stderr and let it
does the logging? We'll need to output the error side bands to stderr
too in case side-band is used.
-- 
Duy
