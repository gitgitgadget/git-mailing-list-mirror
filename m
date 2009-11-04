From: John Tapsell <johnflux@gmail.com>
Subject: Automatically remote prune
Date: Wed, 4 Nov 2009 10:42:52 +0000
Message-ID: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 11:43:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5dKY-00010q-WA
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 11:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbZKDKmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 05:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755256AbZKDKmr
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 05:42:47 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:54568 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141AbZKDKmq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 05:42:46 -0500
Received: by pzk26 with SMTP id 26so4604921pzk.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 02:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=wyA4lLGx9o4dzgFkygH1an40zfLPP95UOaB7ZvWrcmg=;
        b=F3s4sY1G+Y/bNX7ZSHSydcz+ooOcJ1BqBjfSukD4bxxSL0+XgimT6PITjT7rRv2c6b
         ii1F1Kp5mnqBPUjZQ4o0NXhxeo3LGFc+CKd2U1tJD4r5weHKzlNTJkxSx8fy6A71aF/t
         HS4q1+3wigf+IKwXS3zmwHEDS/8REP5usgSzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Z7SSNaxiBqttZ0H2azYfmwzRahiiP6I+2MVLgp6avybTtolJpWjchWby1txz1t92/r
         iZmDouTSvIP7hk/G/aaPceJop7ferSJCOLA0hJ2zrW0JaH5eTOA59vjXx+etiYLmOuDF
         2ZEhuIoBf6HgURm19gg7T4twqYo31WAp6sJHA=
Received: by 10.114.253.23 with SMTP id a23mr1751583wai.155.1257331372136; 
	Wed, 04 Nov 2009 02:42:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132070>

Hi all,

  Is there any particular reason why "git update" doesn't
automatically remove remote branches that have been removed on the
server?  I keep getting questions about this from confused users.

  If there's strong resistance against that (there usually is for
changing any default behaviour), could we at least mark deleted
branches?
So maybe:

$> git branch -r
origin/blah1 [Deleted]
origin/blah2

(Some branches have been deleted on the remote server.  Use  "git
remote prune origin" to remove these)

Or something.

John
