From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Feature Request for the Git Bundler
Date: Mon, 27 May 2013 21:36:57 +0000
Message-ID: <1369690617-ner-2260@calvin>
References: <CAMqnHVFKULwThG=11fiTytV9O-2wybyuOzxBSpc0tWuZKcPPCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Omid Mo'menzadeh <omid.mnzadeh@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 23:37:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh56P-0005tG-VW
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 23:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab3E0VhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 17:37:07 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:58906 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab3E0VhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 17:37:06 -0400
Received: by mail-ea0-f174.google.com with SMTP id z7so4159250eaf.33
        for <git@vger.kernel.org>; Mon, 27 May 2013 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=pDXRJpdFXvup9+jOZ9Dl2ubjqvrH98Ar5ErTHj95VpY=;
        b=TWWquZR5CP70CR5wWf/l9Tj6gfqJ0dNZqeqSl2cNANRT8O71Y3QiW4j9/dlcOJ/ZaG
         edFuzejy47hbCCrUKtbb7/Jmi51rdwxBvbyuIiLv0GTa5cNIyAC7588UjAw3UNZ7uFnC
         3VHGPK0Mvok03Ht3so2vqATRhtn7qxNDV87jbxMaKOUFbZ/LO4Y7AfKh9/rwRQRQDpFL
         JxUoxWuWPc8PFuZOxSENmYrjE3jIjZgLSLn66lIH/0E8K9TxMEsRbOJ1YAqeT7DSBj1+
         v3gM02CKzbmfaIG0cALs4g2l+i1khmn6hBtFzu9mZHUmFM4Fx/jYnPBv5lQIuFLVn6+B
         mDcQ==
X-Received: by 10.14.177.5 with SMTP id c5mr11416331eem.62.1369690624169;
        Mon, 27 May 2013 14:37:04 -0700 (PDT)
Received: from calvin.caurea.org (cust.static.46-14-151-191.swisscomdata.ch. [46.14.151.191])
        by mx.google.com with ESMTPSA id m48sm44202159eeh.16.2013.05.27.14.36.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 14:36:59 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 4AE031DD477; Mon, 27 May 2013 21:36:57 +0000 (UTC)
In-Reply-To: <CAMqnHVFKULwThG=11fiTytV9O-2wybyuOzxBSpc0tWuZKcPPCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225614>

On Mon, 27 May 2013 16:11:06 +0430, Omid Mo'menzadeh <omid.mnzadeh@gmail.com> wrote:
> Dear Tomas,
> I was using your git bundler a few days ago, and it worked like a charm.
> But there is a problem out there, and that is most users of your bundler
> are people using an unstable internet connection. I downloaded the bundle,
> and 'git bundle verify' said it was OK, but it wasn't. My only way of
> knowing that was asking for someone to download it and give me a checksum,
> and it took a whole day for me. So it would be nice if you could add a
> chekcsum, md5, sha1 or anything, to the download page, so anyone can check
> the downloaded bundle easily.

I think the real problem is that git bundle verify does not actually verify
the contents. Maybe there is another command which can check the contents of
a bundle for corruption? A added the git mailing list to CC, maybe someone
there knows more.

Note for readers on the mailing list: the bundler service Omid is referring to
is the one that I host here: http://bundler.caurea.org.
