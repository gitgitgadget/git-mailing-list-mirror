From: Scott Chacon <schacon@gmail.com>
Subject: Git sideband hook output
Date: Tue, 8 Jun 2010 22:32:37 +0200
Message-ID: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 22:34:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5Ur-0007va-7L
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 22:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230Ab0FHUd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 16:33:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38009 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691Ab0FHUd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 16:33:58 -0400
Received: by wyf28 with SMTP id 28so411829wyf.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=jL+nrPv8tVkb2Wl56Uvi4sJbhx2kR6ekW85T43NTOnk=;
        b=UfoBljCJigjMKL/AGRT2NFr2MI9lHfPT+44Og2VbDem1upjMPWWMYFGHHnBsnF275I
         ISFZRTADrrdDkjcIqBWCBp8aPlW4LjZVFwOKSj009TDjfnzel0+lLe6EulFxjxWZP1Z0
         nrPo2J1uul6cXZ40B2QgAZQtkvBBh3bLkcqtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=naLLTwqNnWvSR1CqEJ4kk51owSy1peebhNR6YBFTE/hAPc3In3maHo0x5uXowo/y/8
         iNmtoqPHAIB6Bj4XZ8aIjTyVh3VPu4j8zTNuLsuXJnefBEAKDnte+D+fgytZaD+LUkG2
         S1lT3ytTDG/2O/MQ6xoFgFjKMOqcmpFXAqiis=
Received: by 10.227.72.206 with SMTP id n14mr1780504wbj.33.1276029157112; Tue, 
	08 Jun 2010 13:32:37 -0700 (PDT)
Received: by 10.216.23.71 with HTTP; Tue, 8 Jun 2010 13:32:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148710>

Prior to 6d525d where Shawn made the receive-pack process send hook
output over side band #2, how did the hook output get sent to the
client?  On older clients (before this commit) and on older servers,
the hook output just shows up without the 'remote:' prefix.  After
this commit I get the 'remote:' prefix, which is kind of annoying.  Is
there a way to suppress this to get the old output format?  Or a
recommended way of patching the client/server in future versions to
get the old format back?

Thanks,
Scott
