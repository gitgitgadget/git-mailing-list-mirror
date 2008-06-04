From: David <wizzardx@gmail.com>
Subject: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 08:55:02 +0200
Message-ID: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 08:56:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3mue-0002XW-3j
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 08:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYFDGzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 02:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbYFDGzH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 02:55:07 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:52310 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYFDGzE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 02:55:04 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1992676rvb.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 23:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=35UL2+hO4PBZ7xOguSZKF8TXhVmH2lbqQgRxRL+RLPg=;
        b=AeaDYr/QugsXq5RfBK+cOBb/AELKJMq5JTre3uZL5mBpNXvjmZ+lgX8W4kwY+BF1yEPXzwhgtCufMwW7tGS89VLaz7goFn5ldYXIw/fjSoBSEFpbkUqbOTmEkwsvd2rQRGQCD2AIPHu/g/SXOHSDOqAHf4EUIgC0KF5JoSbb/OA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IAte4KCBsrvIQXfz4Gqweim9mZX3C7i1ixW0A/yXG4DGl8JiInEu86XBVmguika69iwJ9KgaTiQu1/IMk2sGd8W/qTYObS3NZAesAv20a9lGybW23hu847denyPSprmOTm2YlKw2B9KyP3gZKnYVCXNBWMHsG3xeoNHEpVEPIe4=
Received: by 10.141.122.20 with SMTP id z20mr6408021rvm.160.1212562502336;
        Tue, 03 Jun 2008 23:55:02 -0700 (PDT)
Received: by 10.140.194.15 with HTTP; Tue, 3 Jun 2008 23:55:02 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83750>

Hi list.

I've tried Googling for these, and checked the FAQ.

1) Is there a separate Git Users mailing list or FAQ?

So that git noobs like myself don't bother the developers directly :-)
Also so that non-git-developer users who want to help other users
don't get a lot of mails with patches & git internal development
discussions.

2) Is it possible to cherry pick multiple patches?

Sometimes git rebase isn't appropriate, and it's a pain to do multiple
'git-cherry-pick' commands. Here is my current recipe:

for C in $(git log --reverse <commit1>..<commit2> --pretty=format:%H);
do git-cherry-pick $C; done

Is there an easier syntax for doing this?

David.
