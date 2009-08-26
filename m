From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Newbie / git / gitosis question
Date: Wed, 26 Aug 2009 10:27:30 +0100
Message-ID: <26ae428a0908260227k7ac6aeden9a4eae7ee95d4d45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 26 11:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgEnR-0001m7-Lc
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 11:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbZHZJ1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 05:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756459AbZHZJ1a
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 05:27:30 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:64481 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289AbZHZJ13 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 05:27:29 -0400
Received: by ewy2 with SMTP id 2so1205138ewy.17
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ndNVJyBpc1jEH+VWlNqKAgOWh25RxyFCETeP6pl5ZYM=;
        b=Kv4NF+thFuSdHyrMQhqp2wYzac5xUC6EGAhs1XhH3i0qyLjj+6YKCeClN4EHvXmJDp
         keFGSSSb7JV1hlJ9bliGA++P62LPA2xjpIg9hq51qnvbQtl63ihbmhp0V7qN3a1M2j95
         UKSpvinUizD1HieO8QtVpyvgx/IFTPyjOLBnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=fAqom8gVOMfgcq2YBznEY9Xlj0LyQ/j0de3IglTnn7lJT1ns8IcpoqlObwM05LN4I5
         OmPXCvOX/2xhBbhRYv4v6BLeJP5KcXU2Nr9W43ylD52Nb3dMLl6GFcmktoOY26i6uNah
         AYnDp15fOfWyQ/T43l0X6BRWQI2IjNq1AZsg8=
Received: by 10.216.90.212 with SMTP id e62mr1598725wef.26.1251278850462; Wed, 
	26 Aug 2009 02:27:30 -0700 (PDT)
X-Google-Sender-Auth: b63aa3130b0fc9f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127081>

I've been working away at Gitosis and it's mostly fair enough but
there's one bit that's unclear to me...

git push origin master:refs/heads/master

Would somebody kindly explain (or point to docs) what
refs/heads/master means? How is this different from just 'git push
origin master' or even 'git push origin master:master'?

Any insights much appreciated.
