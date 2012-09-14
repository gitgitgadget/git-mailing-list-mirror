From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Please pull git-l10n updates for git v1.7.12-146-g16d26
Date: Fri, 14 Sep 2012 19:51:23 +0700
Message-ID: <CACsJy8A-prPd=5R83LhcLO1rd-rBZRhfnvABvzvdDiC=hZ3ofQ@mail.gmail.com>
References: <CANYiYbExJRAK0zvO4FSce2tOTyW1fLW1OLqZSm0KLjG1V4nTbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 14:52:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCVNO-0002aL-Kw
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 14:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212Ab2INMv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 08:51:58 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56443 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756754Ab2INMvy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 08:51:54 -0400
Received: by ieje11 with SMTP id e11so6715295iej.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 05:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IWZiEEmo9+79Myw+ne9X9gi4pfSAtO56ca5GV1BB+vc=;
        b=Kso1lMuFjvWba41a6/J+kRdqSAVAaDDZi8VJSLwEmoNlXpvs/uSqZsu5KI3n6aNJnq
         f7Ns5taDatQpx9CIiU/jnu6QaOsLZjtHorRi+VVs8NMaGSqGy65Z5KNeT1LYvnIkzMR8
         jr1fu3fzmh1mONO1XAkxnYxDEptHbvf2lB4JLyHKMM9yTp3NrNxsXeOR0jxGAe2vBeKa
         uTEc+ebH+0J0Qcl7DRzefhshMJEW62XkURXxoayVZdO5Vo5gXJM7FMd8R/loH1uAwZE6
         L/tGk0Z7384Ei9ZmY7pFsQzMfKJOhecraQHrOBfxbdSj+UJjhjjhGUTXKdjLdCQ1wrNU
         QqSQ==
Received: by 10.50.182.201 with SMTP id eg9mr9206512igc.15.1347627114120; Fri,
 14 Sep 2012 05:51:54 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Fri, 14 Sep 2012 05:51:23 -0700 (PDT)
In-Reply-To: <CANYiYbExJRAK0zvO4FSce2tOTyW1fLW1OLqZSm0KLjG1V4nTbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205486>

(Dropping translators as they probably are not interested in this)

I saw a gnu project does this (I don't remember what project). If we
update .po* files with --no-location, we can avoid a lot of diff
noises due to line number changes. A typical translator does not care
about these lines anyway. Those who do can easily search the string in
source files without them.

On Thu, Sep 13, 2012 at 5:41 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
>  po/TEAMS    |    3 +-
>  po/de.po    |  712 ++++++++++++------------
>  po/git.pot  |  684 +++++++++++------------
>  po/sv.po    |  715 ++++++++++++------------
>  po/vi.po    | 1767 +++++++++++++++++++++++++++++++----------------------------
>  po/zh_CN.po |  712 ++++++++++++------------
>  6 files changed, 2394 insertions(+), 2199 deletions(-)
-- 
Duy
