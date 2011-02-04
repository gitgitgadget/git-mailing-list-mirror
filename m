From: Dun Peal <dunpealer@gmail.com>
Subject: Potential problems with rebasing branch foo onto master, if master
 was previously merged into foo?
Date: Fri, 4 Feb 2011 12:28:33 -0600
Message-ID: <AANLkTina+mXQ0dx+Xx300vcETgsEtHj-Jx0-OfzxywKC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 04 19:28:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlQOd-00035m-JX
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 19:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222Ab1BDS2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 13:28:34 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33404 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1BDS2d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 13:28:33 -0500
Received: by ywo7 with SMTP id 7so775289ywo.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 10:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=tVGD8y/x8peMbH4c3o2HX2kZGSQ4CHu7nYrzFWuy5Eg=;
        b=MnTxXqW7oIKl54ejD+KCuberV2jPPekQSqEQ3XLtFy8ALwB7ej6aq9ZbRoPoupgnBu
         +qkGEQtTfB1iq/JSiX134t7x+wui7K7EFQfKzEj4mvLZHZ7ot9wVPopyC2GiRR/ilOMc
         Gvzk+4kU8Imh6YLI2Tj+IF7qSsljVTUQsMTGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=FKetrLU2J27JwjgFPvsEIN1pO8nB26AL4HbuIc1RJY6rPdtorOJ+vJhXBouvmjPlu1
         XVY7GS6uD0AjrkGiNpE9UkQj7DH4LY9H2cfWDzqReUIN6CNiVNohg/fT63pNoiNggCo/
         ybVyQ1tyPxTKxRuz612QU4fg2RCLYWu5ieMHY=
Received: by 10.146.86.6 with SMTP id j6mr187734yab.31.1296844113056; Fri, 04
 Feb 2011 10:28:33 -0800 (PST)
Received: by 10.146.167.20 with HTTP; Fri, 4 Feb 2011 10:28:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166053>

I'm designing a workflow for a long-lived feature branch `foo`. This
branch will have `master` merged into about once day. About once a
week, we rebase `foo` back into `master`.

Are there any problems to be expected in this workflow?  I have a
hunch the rebase back into `master` might be subject to potential
problems that I can't foresee.

I should mention that over 70 developers will be collaborating on
`foo`, spread across multiple, widely diverging timezones; any state
that requires all of these developers to coordinate / synchronize will
be prohibitively expensive for us.

Thanks, D
