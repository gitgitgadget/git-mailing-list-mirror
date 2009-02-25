From: John Tapsell <johnflux@gmail.com>
Subject: git push
Date: Wed, 25 Feb 2009 06:38:41 +0000
Message-ID: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 07:40:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcDRL-00032M-Au
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 07:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759539AbZBYGiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 01:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759414AbZBYGip
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 01:38:45 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:20068 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759365AbZBYGio (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 01:38:44 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2481847qwi.37
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 22:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=vszDQ4+yVDk8o+lXMIEK95ulBz9pdLB7jjbzJnMG3jM=;
        b=HxTswhhL6XSaYlSLN4WBaT9NGpzK3O4QUoDiHV+/V41RSpiV0S7Xkis3DHuDEsf5FQ
         MYuIdSIEe8VedOrZxJwwCzZWjGOAHfeONpNVoHpIuMRqwbY/anENF9pk7WLN30ruPR5E
         LbdwPv71PzfxyZMkoRkCOCsIkyi3N/4m8hX0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=JuysKAOTpxw0MKl68WKC4YZPdMC/JJdfgw8Q0MMj5NHt/DZrzU70KfOs2DKBTM3tzh
         DNfpBWzAX40mm8yp/5Z6OaSKfQNt0bWCXVrKOC1NPBHJ73kJMK2JulQSXohLmVF9KwMF
         demc2GaKQFGdLN24pDOVeuk+pcwuE4sfxg2Do=
Received: by 10.224.11.136 with SMTP id t8mr1332841qat.73.1235543921968; Tue, 
	24 Feb 2009 22:38:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111375>

Hi all,

  Following the idea of 'least damage', what do people think of making
"git push" only push the branch you are currently on?

  I've accidentally committed commits in other branches because of a
git push.  I know there's some magic config kung-foo that you can do
to try to tame git push to just the current branch, but it would make
sense to have this as default.

John
