From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Mon, 25 May 2009 00:53:20 +0200
Message-ID: <cb7bb73a0905241553i2cf2c246ycd0b5466e60c8de8@mail.gmail.com>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7voctirzu6.fsf@alter.siamese.dyndns.org>
	 <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com>
	 <7vfxeurwh0.fsf@alter.siamese.dyndns.org>
	 <cb7bb73a0905241518l43048416i34cb905c143c63e0@mail.gmail.com>
	 <fabb9a1e0905241528r7b5102b0w5d064727125654d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 00:53:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8MZS-00089P-H1
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 00:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697AbZEXWxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 18:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbZEXWxV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 18:53:21 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:60173 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945AbZEXWxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 18:53:20 -0400
Received: by bwz22 with SMTP id 22so2747834bwz.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 15:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dhHt7OSXSKuy72aRpFqIjanGKilm62oc4o93iz5/O6c=;
        b=W12ULW8lhkfo3ieQN9yWStgI7e5CNLdK5JncDR0VYsiZzOOHvRYMkWnjumNUPiaENY
         AN/PrK5L3MjUxzhvGK2esCWvPSsCsa1AqWIn+MaNw1iwf4lCNCBXIfmG6cOVh1ozUSp8
         Dk4TXTsTsrA9VnNDLf5le0fYsakzAM2uZthhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MPyFwo29IILghCY4UX3dFraXli+11RrnvpGcG62LVRqlQ3PHilBrfpm/TnzAcKLGGb
         zoaB5+C+TDtnfdjdEfaAplNLKozprUG4uRvPtJ+UsnFRvZ2y2kJWun6VpkEdJdmMcO7E
         wa/ZcQjOt6QvI7hOJYKTpUED8EtXK9WsgGdsY=
Received: by 10.204.76.129 with SMTP id c1mr6396936bkk.9.1243205600454; Sun, 
	24 May 2009 15:53:20 -0700 (PDT)
In-Reply-To: <fabb9a1e0905241528r7b5102b0w5d064727125654d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119872>

On Mon, May 25, 2009 at 12:28 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Mon, May 25, 2009 at 00:18, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> Sorry, that's totally not the idea was trying to convey. In fact, just
>> after sending the email I went back to the code to look for a better
>> solution (I should have probably also made the first try a RFC).
>
> Perhaps a more elegant solution is a script that munges a hg/stgit/svn
> patch into a mailbox format before feeding it to git-am? 'git munge'
> is free :D

This is an interesting solution. And git-am could call git-munge
automatically before feeding the patches to mailinfo, replacing
  git mailinfo $keep $utf8 "$dotest/msg" "$dotest/patch" \
      <"$dotest/$msgnum" >"$dotest/info"
with
  git munge "$dotest/$msgnum" | git mailinfo etc

-- 
Giuseppe "Oblomov" Bilotta
