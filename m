From: E R <pc88mxer@gmail.com>
Subject: finding the merge of two or more commits
Date: Thu, 29 Oct 2009 16:12:45 -0500
Message-ID: <3a69fa7c0910291412l439f7f61vd3b55a77cd7e10b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 22:12:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3cId-0007W0-M0
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 22:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbZJ2VMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 17:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754848AbZJ2VMl
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 17:12:41 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:57440 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbZJ2VMk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 17:12:40 -0400
Received: by pwj9 with SMTP id 9so287280pwj.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=5i+tvJWmt4NXYx/N05YjJnj/YOLEBxjX0R/aadhDyJ4=;
        b=KdAyu6nyGs8xYO7wjgNLJdZ/iaaBcWpcx0BW3T64QzpOqfVUPw+StMpgGgUV6OhFhO
         BJLjQltRqpj73C0pq+bajAPdUR+BGwQCSoWkeYomUh7n8u4oNgMC+fAvCdwFMbU3aFHW
         kbRZaW58DpnZG/oD4GmwuWfxpL51yE7n8droE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qSBUVRi/ty2pONu5a1kGPsEl0UlV+svoM0pCycOobpM4i+EPRK3Zphf/gdGvCebaD3
         PGvKLEwRrKutpwGTQIskBtkuzLvBS4W3R358WEIkdsLmaI3FLuqvP0p8q6hV7GFTliUh
         Sel0nutzNgi4girBKF668thjjXeR3h8bISQLk=
Received: by 10.142.247.40 with SMTP id u40mr60046wfh.178.1256850765249; Thu, 
	29 Oct 2009 14:12:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131654>

Hi,

Given two commits c1 and c2, is it possible to ask git if there are
any commits in the repository that were created by either a sequence
of commands like:

git checkout c1
git merge c2

or:

git checkout c2
git merge c1

with any required conflict resolution?

That is, I don't want to merge c1 and c2 myself, but I want to know if
someone else has merged c1 and c2, performed any conflict resolution
and committed the result.

Thanks,
ER
