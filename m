From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: git branch --current?
Date: Wed, 17 Mar 2010 21:43:30 +0700
Message-ID: <fcaeb9bf1003170743kc347d53jefe41039e3b9a69a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 17 15:45:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NruUq-0005kg-Ud
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 15:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab0CQOnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 10:43:33 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37521 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab0CQOnc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 10:43:32 -0400
Received: by pwi1 with SMTP id 1so782796pwi.19
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=BdcDjqKcqJi9qneHyl8Gxr9b1abQ+dJiEZQO9PHJtoo=;
        b=DCcRGZhZE+uIx26ge2MsfR6f/7p1AcfoFFBRTEynLjm69k4B3OLsAYHpNvyjE0cA5R
         2MHvQS2y6a6ta4UqagO9514Qt+kGWfBQNecHvi2P1qKJvAIUXUwO/IVP7IjWqJ2Hum2V
         1Vylmo9kNdg8nGIoebeBM68DA3XOeNHc6P12I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qyV8Sl6KypSEjUHfwu2Ce0wj4QRWubo+0Qb+yZGMPVmaAJpXRw2N/nv+BNiJ0UYL9A
         mqj+McOfX6T55FCjW2052kNGO2vnSxfVZKHIHq2a0iID2huoC0A8XUTtYSxz7BHEniLr
         tbk4IK61kZf7pTBqXZ4ffjBuVnutwGM5AoAtw=
Received: by 10.141.88.10 with SMTP id q10mr857924rvl.88.1268837010959; Wed, 
	17 Mar 2010 07:43:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142395>

I use "git branch" when I need to know the current branch. But I have
many branches, looking for the star is "time consuming". I'd rather
have something like pwd, just print the current branch name and that's
all. A bit more information about current branch wouldn't hurt, as
long as the branch name is printed at a fixed location.

What command do you use to know what branch you are on?
-- 
Duy
