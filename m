From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: How to move users from SEU (AS400) to Git?
Date: Tue, 12 May 2009 22:31:17 +0100
Message-ID: <efe2b6d70905121431p79c05addh1cd5759221ae911c@mail.gmail.com>
References: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Brisbin <jon.brisbin@npcinternational.com>
X-From: git-owner@vger.kernel.org Tue May 12 23:32:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3zZn-0001ND-5E
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 23:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429AbZELVbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 17:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756372AbZELVbi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 17:31:38 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:35279 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbZELVbh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 17:31:37 -0400
Received: by ey-out-2122.google.com with SMTP id 9so95200eyd.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 14:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Hd1lbw0hocBT1zYnRPzX1zEKCrsAYDFu+BhL1XUUaiU=;
        b=VcwlmUvSqvWapZwfDSfy4kWaNaKe7C2sHjw3RUD9tjbYQzw5F9RbKdYA8u00L5RvoR
         VUPYqP53RNx1Wd6aw3ER35MqnfnNuc85cBTodfwAW9SAJle8ZU+wysWRHPxZVTJzXyYS
         xtjNPIgbOezhYK1/dKGRt7tqPw4d4G3Hrk9VY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=r9Qh5XGhRfbAGLKG72DdpubILowNRQ6chWCZnnjGyGSeNvKSaAuVC6s83lB1pzjs8e
         ds9dQVY+axYmWLGHTcc+offD7tU5UGouPy+bMnLGjvN6Ic8rk8jXIAds93bKiD6HbJeD
         8MkY7gs3R/6IDjzA8XfQpJIgDVkYpxOo8WyjA=
Received: by 10.216.10.208 with SMTP id 58mr105852wev.82.1242163897129; Tue, 
	12 May 2009 14:31:37 -0700 (PDT)
In-Reply-To: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118957>

First, I just have to say: There are still people writing RPG? OMG!

Secondly, I think you may need to think carefully about merging.
Looking at the wikipedia entry, RPG is column oriented.
Maybe existing merge tools will screw up the column structure. Even if
they don't, they will probably screw up the alignment
and make your users have to go back and fix it.

As far as advantages go, I would suggest going back to them and asking
them 'what have you always wanted to change about SEU?' Maybe they
don't actually like locking. Maybe they have some problem we haven't
seen yet, but could easily fix.

There is some kind of RPG editor here which may be of interest:
http://www.rpgnextgen.com/

Ealdwulf
