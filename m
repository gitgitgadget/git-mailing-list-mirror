From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH] Update $GIT_DIR/remotes to $GIT_DIR/refs/remotes in docs
Date: Mon, 30 Nov 2009 15:48:42 +0800
Message-ID: <544dda350911292348g7790b64ep4782dffc427bbde5@mail.gmail.com>
References: <1259552316-20088-1-git-send-email-ayiehere@gmail.com>
	 <1259552316-20088-2-git-send-email-ayiehere@gmail.com>
	 <20091130050333.GA26585@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:48:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF104-0006Sc-6r
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbZK3Hsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2009 02:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbZK3Hsh
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:48:37 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:54901 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZK3Hsg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 02:48:36 -0500
Received: by pzk1 with SMTP id 1so2331643pzk.33
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 23:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hz7I7oaAXL9NMU4XjGJQmbwcxkfbWf9hk2XUKec+qVQ=;
        b=Zc6IvgfJN4gb7PDV833Vzpzlzo9fV7DCK7CKgl85QIeb3J9Xx8O6VeAfADWtN4Nh1R
         iidShRHXgyOCQg8pkNJoqOTVkh/AJTkTspJDm+lA/rMAlcBGuI4OCs1Kcvth+cOR+jYA
         G9VJ+9ukR13ilG7RQiihU4Mt2oVA4qzuRlWMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WDjrIWmUgP5nnC3YlmrIGisxqk8We44XQHP91MVKRbgfyNTldX+5c24MwEp8TTkJ/A
         AxpHVo/wd2JpzvHLKEBO2dc32w7aRDzCZXygiwRA1xnZbWHly4NJbkXLtO6Lea5oIXRk
         KvS7dvfQYoMBR1EWTspGvhzDiASoLErNd/kkw=
Received: by 10.142.75.16 with SMTP id x16mr441440wfa.155.1259567322916; Sun, 
	29 Nov 2009 23:48:42 -0800 (PST)
In-Reply-To: <20091130050333.GA26585@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134071>

On Mon, Nov 30, 2009 at 1:03 PM, Jeff King <peff@peff.net> wrote:
> Er, what? $GIT_DIR/remotes/ and $GIT_DIR/refs/remotes/ are not even
> remotely the same thing. The former holds information about how to
> contact remotes (but that information is usually held in the config f=
ile
> these days). =A0The latter holds any tracking refs we have fetched fr=
om
> the remotes.

Erg.. thanks for the enlightenment.

I was reading 'git help remote' while attempting to change my local git
repo from tracking

  http://www.kernel.org/pub/scm/git/git.git

to

  git://git.kernel.org/pub/scm/git/git.git

and noticed that the documentation refers to $GIT_DIR/remotes and
(wrongly) thought that it meant $GIT_DIR/refs/remotes.

Sorry for the noise.

Nazri.
