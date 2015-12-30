From: Carlos Pita <carlosjosepita@gmail.com>
Subject: Re: [bug] Graph log and orphan branches
Date: Wed, 30 Dec 2015 16:48:14 -0300
Message-ID: <CAELgYhe3Nosq3iPGsvqxJTnmZu5a_ayi4eKVdhPMfNaXVLZOXA@mail.gmail.com>
References: <CAELgYhe4u2qU0-+mBKGwf8CpdZ=MuWMFZmeOhojtdMQZ3-nfhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 20:48:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEMje-0006GH-Sk
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 20:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbbL3Tsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 14:48:36 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36769 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbbL3Tse (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 14:48:34 -0500
Received: by mail-ob0-f173.google.com with SMTP id ba1so184063641obb.3
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 11:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=aWLL1raba6CE9O4j0cJ9ecvzfIf+ks5DmR+A0REsPV4=;
        b=Sc41VfiIonxxsbBdP9x7O1qnQ9iPfOGS2zL5gw5RBk37tg09tZ7nrzgI2fpLeODkHY
         KClFj7s90p76LIdKKyLTQOesak9VmYh+l5GVpMX8g+g2sFup+UHCTGuCNaIklyvtsgRR
         DmXmIvktvFl9aBuwHnd/kng1EA4TRJiMU8IGwS4kjiXBidHIpLS8D35GcOyWXttURzez
         b73WVJYmy13/cWgFN68i91LYVeQ884b9RBqBuz9nAol00OvAFWKsOT1vH+4MfjHNxCyG
         EnOZUaWT24ynM2DeGY5XUe3ZPy0aCvV6MWrpSWOwOCkXcMG7om/g2mlZPE+gm+eYZ/KM
         SD+A==
X-Received: by 10.182.144.133 with SMTP id sm5mr45022280obb.69.1451504914271;
 Wed, 30 Dec 2015 11:48:34 -0800 (PST)
Received: by 10.182.135.167 with HTTP; Wed, 30 Dec 2015 11:48:14 -0800 (PST)
In-Reply-To: <CAELgYhe4u2qU0-+mBKGwf8CpdZ=MuWMFZmeOhojtdMQZ3-nfhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283192>

> http://stackoverflow.com/questions/22541261/git-log-of-all-branchs-in-only-the-current-tree
>
> I think this is a bug in the UI.

Please notice this happens only for the --oneline output.
