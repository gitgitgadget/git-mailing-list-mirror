From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: sub-directory repo technique
Date: Tue, 16 Jun 2009 12:50:49 -0400
Message-ID: <32541b130906160950s75f4aa11h59ad2de7d2bcd40c@mail.gmail.com>
References: <9586f3420906120507o194fc459l5fbdcd14a7095ae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Allan Kelly <allankelly@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 18:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGbsf-0003pE-VX
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 18:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759086AbZFPQvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 12:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756996AbZFPQvH
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 12:51:07 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:59775 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbZFPQvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 12:51:07 -0400
Received: by gxk10 with SMTP id 10so7941404gxk.13
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gM4vx1A6mUozsMbtg9/8y35l8Ikv1Sg2sMj3R0D/VXw=;
        b=HFmEp0jiVlZ+8Z4UNpq58KMtV9VCzcoYz/kzuGE1CBAKwtN+N3SwbsVqRfKkhzJUro
         YvpVoocDIDZocuhhEx/XkhKBTjHL3ygp7fvbzZfq3/srNZHpW0edR2lKx7Sv6gMrtU2M
         D35jKfb7b2z6otCqfDATcN9hqPfzB6Z5WGgA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TFBbrF1zAS6OE0/tQSdBpmfh0krXwvKemCXnwOAMwbilOnaI3hlXtFO9agDd+jjMsT
         kW11uVhOZDus4/npeNId5deZh74zs0K9QDvd365RVoaZ3gSr9SEYoL+is4VH8DhpwYbU
         Z+njhvrcAuKf3CFCqeazIA3dorOjBGbZtKhEM=
Received: by 10.151.138.4 with SMTP id q4mr16045854ybn.40.1245171069093; Tue, 
	16 Jun 2009 09:51:09 -0700 (PDT)
In-Reply-To: <9586f3420906120507o194fc459l5fbdcd14a7095ae8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121687>

On Fri, Jun 12, 2009 at 8:07 AM, Allan Kelly<allankelly@gmail.com> wrote:
> (I need the top-level .gitignore to contain a line '.gitignore' to
> avoid reporting the "sub-repo" .gitignore as untracked - which is
> correct but not of interest. It appears that git automatically ignores
> the .git dir for the westbarnsgala.info repo created below)

It's not really "ignoring" the .git dir.  It's treating the entire
subtree that contains the .git dir as a submodule.  See 'man
git-submodule'.  Git submodules may actually resolve your problem in a
more straightforward way than what you're doing.

You might also be interested in my git-subtree tool:
http://github.com/apenwarr/git-subtree

Have fun,

Avery
