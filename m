From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [GSoC 2010] The 9nd official week
Date: Sat, 24 Jul 2010 22:48:10 +0800
Message-ID: <AANLkTi=0gCMfPv1C8kr-KbL2M29XxTHeqcy5L9L2eMOF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 24 16:48:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocg1S-0006gO-41
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 16:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab0GXOsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 10:48:13 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36515 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab0GXOsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 10:48:12 -0400
Received: by qwh6 with SMTP id 6so4197636qwh.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=Dy+BnT1/YaZlvN09s9g2MQbquy8L9GtM4jT4yauCuOw=;
        b=mCSmFlxbb/tlcIh4h1Ht6CSYmgXorQwIkg7WmEoAM4KoDL4xdohtO6OA6DHtyu1B1Z
         N4h3rJWT6bfCuxMVGtoH8OoT3PisUjy9x0H87pmQJuW9hctUq3fxNGYrhPR7NElRsuxj
         VwZh4KwbQDfraV8fQztXp2wzdINVNQuzq6ces=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=LUpqvU/jOY+M+4u3n08O1ILHV1GrHfJ/EL+gpc29NNleMQmQcj/kfj7bjMO51kpAAt
         HJgl9C+gC6C0G2VXrNMSWzO1yOPiV7BjWsqJLx17faoFOR/+x5I6J63Nr6ls+6aPsDM6
         MmEnCb1ojKi0TIxsAwMEhRJWZl3m7u6T+1lmc=
Received: by 10.224.18.225 with SMTP id x33mr4024717qaa.356.1279982890950; 
	Sat, 24 Jul 2010 07:48:10 -0700 (PDT)
Received: by 10.229.217.149 with HTTP; Sat, 24 Jul 2010 07:48:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151631>

Hi all,

   Here is a short update of my developing status. In the past two
weeks, most of time are spent to revised the posted series. This
includes:

1. Thomas helped me to rewrite all the commit messages to make it
'parsed' well. Thanks a lot for his patience.
2. Fix some issues of the series, this includes most of comments
posted by Junio and some other bugs found by Thomas and myself.
3. Revise the way of parent rewriting. Now, the code has prune most of
uninteresting merges out of the history and can provide a real simple
history of the ranges that user focused on. We will adopt the same way
of parent rewriting as what 'git log path1 path2'. You will see a new
version of this series in next week.

And now, I am working on that show up a combined diff for a merge
commit and a more sensible --full-line-diff ( original
--always-print). :)

That's all, thanks!

-- 
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
