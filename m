From: Gergely Buday <gbuday@gmail.com>
Subject: git branch
Date: Mon, 23 May 2011 13:36:09 +0200
Message-ID: <BANLkTinzped82Njnw4ZUeHY6Qu4R4hKK-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 13:36:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOTQm-0003bI-OC
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 13:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab1EWLgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 07:36:11 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42397 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211Ab1EWLgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 07:36:09 -0400
Received: by pvg12 with SMTP id 12so2523793pvg.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 04:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=IjwtReZWAQBSFHYsOeBqzdsF+TykUXa6LojCrtGKNX4=;
        b=sMQzQALflnAxmkRpuYdWiP9xBe97evzaLgoJ62Il1HYpmnGvFboJaEcnQteVpH4gxk
         VnAt6B3qmG/s1rNL/frK/OhJdKhtJYHrT6uGU54ZVCNr6QUqG3B/ntf84M/nhJYpP8NA
         tjg42/sNu7eTWRH1ie52lSgbhsMZOg/v90vjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=PQKypJEZmwaq+fZ/ZPtYTdIfggolkO7lCtG9U2jqit57arDNnRt2kit6oWEU4v/s9y
         nzfqAJvOqi/iyJ3DfaM7Fo2f/Utga2vbN1NtS3DSvx3H6QD6kVfNpfCRTzNmiFsAyE5i
         3IEEQfc4VKJbiaBkSq462LuavnJQ9CV4e7qls=
Received: by 10.142.207.11 with SMTP id e11mr776546wfg.127.1306150569531; Mon,
 23 May 2011 04:36:09 -0700 (PDT)
Received: by 10.143.91.18 with HTTP; Mon, 23 May 2011 04:36:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174237>

Hi there,

I created

git branch install_2.0

for my install script. Then pushed to

git push origin install_2.0

so that github stores by branch

after another commit I tried to push again but git told me that I'm
not on that branch. Why git loses the state that I'm on a branch? What
should I do to have my expected behaviour?

- Gergely
