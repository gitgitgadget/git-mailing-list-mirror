From: skillzero@gmail.com
Subject: git svn pointing at svn branch instead of trunk?
Date: Sat, 22 Aug 2009 11:40:50 -0700
Message-ID: <2729632a0908221140p532a3c29k90af7b4cbd25d65e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 20:41:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MevWM-0001tg-UC
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 20:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933144AbZHVSku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 14:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933130AbZHVSku
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 14:40:50 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:55486 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933117AbZHVSkt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 14:40:49 -0400
Received: by qw-out-2122.google.com with SMTP id 8so871089qwh.37
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=UJAB1FJScxTHFnnd2C5duWZK3ct+dY6UCz1XzrEHL1g=;
        b=KQVOcllSd21/Jj6ObOPuy8UIV4VjAisUDOYYnQELbk0ZxyMJSVvIPrPqTYV/Ty+eaV
         7IzDIFqpfzvFK/peOUKblmBRTU3fB3tZk2bFRmTHwU0wyUyi/p7+8EYIosqGw0solkrP
         1MdIefhi5rOqh/GlnUzwLcudKEE4Yq+VVcs28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=drYJBEieXDJLn6GjGcvr2FGe43tm/ddOY1JWOj3/HrWxl4WLvfnnLLwPsoa1IA61ZU
         354m4KfA4kz2wN5Tkx8fjRfx1kIdkykpV/mLSCynP6DGjEesWM0nRuOlwamgjsU3baw2
         8kg4UbejI3aEbOyjAAIw4T7aaAxaoJau18Cqg=
Received: by 10.224.72.8 with SMTP id k8mr1756174qaj.4.1250966450644; Sat, 22 
	Aug 2009 11:40:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126816>

When I used git svn to clone a repository, it ended up pointing master
at a tag in svn instead of trunk. For example, git svn info shows the
URL for the tag instead of trunk. git log master also shows the most
recent commit is the creation of that tag in svn, but then the next
commit is the most recent commit to trunk. It's like it's mixing
things from the tag with things from trunk. The most recent commit in
svn was to create the tag that master is now pointing to in case that
matters.

Is there something in the svn repository that might cause this? What's
the correct way to reset what git svn thinks master should point to?
And how should I get rid of the commit on master that created the tag
without messing up git svn (e.g. can I just git reset or will that
confuse git svn later?).
