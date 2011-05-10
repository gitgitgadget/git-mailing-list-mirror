From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [BUG] Autocompletion fails with "bash: words: bad array subscript"
Date: Tue, 10 May 2011 22:13:11 +0200
Message-ID: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shawn O. Pearce" <gsoc@spearce.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Stephen Boyd <bebarino@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 22:14:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJtJj-0000B0-UK
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 22:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab1EJUNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 16:13:53 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58790 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab1EJUNw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 16:13:52 -0400
Received: by qyg14 with SMTP id 14so4919223qyg.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=kVOpRCm39LW/po0ok4L3iEwoAIKz2162TbbyvfqlEJU=;
        b=WL6Z9HtOdNl42G70Jjuv1y2Y8LHeXkAxUu7x9JlI9pYGcx/GOlcalntz88X1jay5ZV
         t2rnHYtnW0l7XGhoM2Qku+Wtsz0rDALQarxmWSG5wYh7SXsevyS3M553f4WG6jNqLJWF
         5zmGwTy+x1+3rltKa69rVQQqxavTrCmMlxg8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=xMZPunfy6L5c6NcWsj7/3t2ZbekemFIl2fjJBVArsU66LGD49PV9DNYLnok1DWW/RE
         pZKI+LoIInBcuMcZ4WoEAYvJCu3DD/itY1It/6V0FBKEdeMalR+veOTqKnHVkz0aF3yr
         +joNx46uIpQ8benV5ZwHljCkg7V21+ZpqfHmA=
Received: by 10.224.207.131 with SMTP id fy3mr7094481qab.89.1305058431184;
 Tue, 10 May 2011 13:13:51 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Tue, 10 May 2011 13:13:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173356>

Heya,

[cced: git completion people]

This happens if I try use ctrl-shift-r (reverse-i-search) for the
string `git commit -am "S`, resulting in the following:

(reverse-i-search)`git commit -am "S': git commit -am "Set new Melange
version number to 2-0-20110501 in app.yaml.template."

If I then hit tab, I get:

$ bash: words: bad array subscriptversion number to 2-0-20110501 in
app.yaml.template."

Hitting tab again gives:

bash: words: bad array subscript

Display all 3032 possibilities? (y or n)

I have no clue how to debug this, other than that it doesn't happen if
I don't source ~/code/git/contrib/completion/git-completion.bash.

Anyone have any idea's?

-- 
Cheers,

Sverre Rabbelier
