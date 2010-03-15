From: Bryan Richardson <btricha@gmail.com>
Subject: Problem Pushing to Remote Repository
Date: Mon, 15 Mar 2010 15:45:50 -0600
Message-ID: <3f81a4241003151445v6b45d63bm63aeb0dfdd36fb6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 22:46:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrI6m-0001ck-KR
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936876Ab0COVpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 17:45:52 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:35383 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936855Ab0COVpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:45:51 -0400
Received: by yxe29 with SMTP id 29so1661504yxe.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 14:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=1iMoezx+bISf4yx6TFyT2KDPz7vJbbUw3aAT1iV7boU=;
        b=FwnQfx61yVYSfwNkroKygZ7D5mevPt5QEUI9XusvKm+WOtcZ2SIOjOiZodjY+zoqaH
         zkz9cca34d56PpNhh68GQIKSCTyIpxdGnJklACgGZMicdt807+5K4YrA5WrvRK5GvrBO
         Vk3KB4l43+RyeqWuz615M08oEx/A2gI827ajY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=cX0DfZwmBMG5KRSIwlD7qbn4OqkMKvWspi277iqHuFlI0sH7rAMB1GpYGYg6BzkPGc
         3IBIsm6/u1qaviq/xSK5jXgpopNPl1wtB0yJq54c8i1wvAC5C5hxfcW4fSlCcmh3Rx+G
         YSHr5GCdXo4xqor9CVEK+AkaJArNQ0BLpGawY=
Received: by 10.91.51.37 with SMTP id d37mr1449913agk.65.1268689550951; Mon, 
	15 Mar 2010 14:45:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142261>

Hello All,

I'm trying to push a Rails application to Heroku using git, and the
push consistently stalls when writing objects (and always at 84%). Can
anyone tell me what might be the cause of this? Is it on my end or the
remote end? Could it be due to a slow network connection (which I'm
unfortunately on right now)?

--
Thanks!
Bryan
