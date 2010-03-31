From: David Hagood <david.hagood@gmail.com>
Subject: Import ClearCaase with history?
Date: Wed, 31 Mar 2010 06:33:09 -0500
Message-ID: <1270035189.2785.11.camel@chumley>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 13:33:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwwAo-0003uZ-88
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 13:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229Ab0CaLdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 07:33:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41681 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757078Ab0CaLdT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 07:33:19 -0400
Received: by gyg13 with SMTP id 13so2743232gyg.19
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 04:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:subject:from:to
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=VoXkcdHwh9TopKH7pH0ewAh6x96ik3Wx93FpOMKnofk=;
        b=jQEXqhHgU30dBAhZkN2zhhwUZ2GI5fNUy5ZuyYuNSj4Qx3WDaITsRedCyEu2kbhU93
         tiHmyYSVoxlzPmGzBJc2YVrTukFnKqHEG/dDY+fppnQ7wpP3uXM+h7+eP5zpm3W0KFX2
         DGob7e7/TerHpTll/u0L0uQNkpF4dBD86dHn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=URbwmLMo+axccFrOUTsP7ZHuGGwiGZZcsDX6hm+vCUSx9NtlQBhmlVRa7JlZ0OUqxM
         G5CudU91OjuFy0x3uE+EHPxRXKtiUp2Fx1zK5plsZkloSzrnscNt3Rh2AHpD4R9QT0JS
         Dw+Ts/xcP6jDTCT8Jve8yHGedp4i1FDLiuwcg=
Received: by 10.101.136.13 with SMTP id o13mr1034362ann.235.1270035193587;
        Wed, 31 Mar 2010 04:33:13 -0700 (PDT)
Received: from Deathwish.hagood.sktc.net (7206-2.clr.64.71.120.40.clradsl.sktc.net [64.71.120.40])
        by mx.google.com with ESMTPS id 22sm6025573iwn.4.2010.03.31.04.33.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 31 Mar 2010 04:33:12 -0700 (PDT)
Received: from [10.16.0.66] (chumley.hagood.sktc.net [10.16.0.66])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id 1F008C7B8044
	for <git@vger.kernel.org>; Wed, 31 Mar 2010 06:33:10 -0500 (CDT)
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143661>

I am trying to drag where I work into a more modern software development
process, but I am getting resistance from one division that has a large
amount of history for some projects in a Clearcase repository. If I
could show them that we could import all that history into git, it would
go a long way to removing that resistance.

I've seen programs that purport to import Subversion (which is also
good, as they also are using Subversion for other projects....) but do
any such programs exist for Clearcase?

I know that, in theory, it would be possible to 
  for all checkins to Clearcase
     check out of Clearcase
     check into git
  done

but that would take an incredibly long time in practice, wouldn't it?
