From: Bruce Korb <bruce.korb@gmail.com>
Subject: Documentation problems
Date: Sun, 20 Sep 2009 10:58:36 -0700
Message-ID: <4AB66D4C.70301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 19:58:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpQgc-0004hi-LU
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 19:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbZITR6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 13:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbZITR6f
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 13:58:35 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:47730 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbZITR6f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 13:58:35 -0400
Received: by yxe37 with SMTP id 37so2417286yxe.33
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=s12glvy2F6btNPTXe0SQgcYmNAGaQ/j2pExp/yQlFnI=;
        b=TUy/dOVaRHe9ioItb0dcNFjlhkTtZMKEc/PYrBnjoEtcgnIR9GOWZ00vQWCLCbhydL
         0laaj7jSwwE27VDuZE4ASd5WdyQF2cXEnOuXJrLtOFzEI6/NsHfG632ab8t7+I/98p5R
         M/HxUhC4dw+wCbH1Dwvkw5O1RxEGTsHUv35xY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=gYWI5BqHSLmodAFdbUOp725R96bvnflJj0t593qGgKI2ILZHP+8XGIUdkVGxDNoA1e
         JDJ7DVCTsi0yOMYDVOyE/b1KJ4ZvHk3gvkBiQde5CGDomkmxh/930fOIFr5FYKYIo7l1
         kDkvcbGpSTUe+lcu8AFAVjBzh4YyIEnX3oIbQ=
Received: by 10.100.75.15 with SMTP id x15mr3490232ana.58.1253469518568;
        Sun, 20 Sep 2009 10:58:38 -0700 (PDT)
Received: from ?10.10.1.101? (adsl-75-2-129-55.dsl.pltn13.sbcglobal.net [75.2.129.55])
        by mx.google.com with ESMTPS id d21sm1646493and.11.2009.09.20.10.58.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Sep 2009 10:58:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090310)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128852>

Hi,

I'm trying to figure out what a ``tree-ish''.
I cannot seem to use many of the commands until I know.

<tree-ish>
    Indicates a tree, commit or tag object name. A command that takes a
    <tree-ish> argument ultimately wants to operate on a <tree> object
    but automatically dereferences <commit> and <tag> objects that point at a <tree>.

I need a translation.  :(  Thank you.  Regards, Bruce

P.S. I have a SuSE installation with everything relating to GIT installed.
The man pages reference commands like, "git-ls-tree --name-only" except
that there isn't any such command.  Unless you reverse engineer the
implementation of "git", discover the /usr/lib/git directory and add it
to your path.  That hassle is rather inconvenient.  More hints about
where the git commands get squirreled away would be useful.  Thank you.
