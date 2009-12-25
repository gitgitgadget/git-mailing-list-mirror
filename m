From: Sergio Belkin <sebelk@gmail.com>
Subject: Set the repository as it was on an earlier commit
Date: Fri, 25 Dec 2009 20:09:24 -0300
Message-ID: <8c6f7f450912251509i67da4665t78be0bb79f2c40d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 26 00:09:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOJHv-00070h-07
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 00:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbZLYXJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 18:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbZLYXJZ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 18:09:25 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:50641 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbZLYXJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 18:09:25 -0500
Received: by yxe17 with SMTP id 17so8280115yxe.33
        for <git@vger.kernel.org>; Fri, 25 Dec 2009 15:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=tVIqhXUmg3hAzP0Yi4LnLtHwZBRota03WZKxSOqJyu8=;
        b=UktrFogkwJVPXrcx5YVG6lL1vsIL2WdsII8kRvMwZ61XPeVHhzqXkIu3DIt1dMlJpB
         nCRJOK8a0Uc9Z833vi2aJOH+iXRtKbI/BWWL/FA7WHHtoVbHo2rS+/9PFdPQt6097M3/
         p6lTsRKSW5SE+5j0SizXVzz0IQmhwR3rZsuls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=BHCuRWBZ/7OrtVPpTdzugzhM4FMjbuk6bUgt8YD/N6dxTGAP+6qI6iHH8RSq1nxnNH
         Fglodf2EC3Plgl5sI9Izq0jHxPSfvJ3CUoc7oXpb7VGt31ruEPeJnDHvesfxYFdG0aZ8
         hRk9X4Vw/D5YEWGnfjRskC+tt1uKvIXnYawPY=
Received: by 10.150.29.30 with SMTP id c30mr19226199ybc.246.1261782564234; 
	Fri, 25 Dec 2009 15:09:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135682>

Hi,

Firstly merry Christmas everyone.

I am somewhat new to git, and I've found great, but still I have some
doubts about it, let's say I have the following repo with:

A---B---C---D

Being A the first commit,  B the second one an D the last one.

How I do to go back to let's say... B commit status, I mean somewhat as follows:

A---B---C---D---B'

B' would be the same as B. I am not asking to do something so:

A---B---C---D to A---B losing C and D commits,

I'd like to keep on history C and D commits, can git to do that?

Thanks in advance!

-- 
--
Open Kairos http://www.sergiobelkin.com
Watch More TV http://sebelk.blogspot.com
Sergio Belkin -
