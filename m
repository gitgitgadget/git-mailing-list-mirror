From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCHv2 03/16] t1001 (read-tree-m-2way): add missing &&
Date: Fri, 24 Sep 2010 22:50:39 +0000
Message-ID: <AANLkTimc+dYFAwmVQLOL8vJPc3jvHhax1nL8X1YST5xM@mail.gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-4-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 00:50:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzH6L-000192-18
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502Ab0IXWuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:50:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41107 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab0IXWuj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:50:39 -0400
Received: by iwn5 with SMTP id 5so2739029iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=GVuztJc44cL1VCubPKoEZUQyI2kCVhZPw0aAVTuSUog=;
        b=YiCkmbvE/8QX3pBgeNCBp+wCWEQoR7a6rYHUze0Ru1JwNYmT4ZlaNQs4itTQElyORk
         CzxdAGNlc35QyxF5cWxC9baoXtfe1KilOzDVuhksdIgkP/BLyVXyAjtt4bivIG3tfNcQ
         wNkdOBPHBS06t9WcES4xIvZatKuonT3VjcaYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fByRobPvl+rFmehb3AiqDXHfPr9Zl0aBVf4iRrThjW7A9IF35mMOR95OzZQRAAoenS
         CjVmuFjKTo1bHfNLO7xK+cXhS6Krioo3r7+Po3i2Q5uNwNqSUMtBIgPLvNIBzndIWU5R
         fu3/Ur8cBFHgQwSsuh62XHQeFQSbDCx1uECyQ=
Received: by 10.231.32.73 with SMTP id b9mr4397586ibd.133.1285368639195; Fri,
 24 Sep 2010 15:50:39 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 15:50:39 -0700 (PDT)
In-Reply-To: <1285366976-22216-4-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157094>

On Fri, Sep 24, 2010 at 22:22, Elijah Newren <newren@gmail.com> wrote:
> FIXME: Is it okay to replace the "|| return 1" with "&&" as I did?

Yes, it's OK.
