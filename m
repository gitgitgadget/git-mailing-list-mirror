From: "Paul Sadauskas" <psadauskas@gmail.com>
Subject: Converting a directory to submodule
Date: Fri, 30 Nov 2007 10:53:04 -0700
Message-ID: <ef2da8950711300953y374c38c4y42de42d9298391a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 18:53:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyA3N-0005nz-7t
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 18:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759631AbXK3RxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 12:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758230AbXK3RxJ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 12:53:09 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:12111 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693AbXK3RxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 12:53:07 -0500
Received: by py-out-1112.google.com with SMTP id u77so4503788pyb
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=i/VVR/YRBMZPeWSw1EgnyjnAK5l5Jbam5ywXTuv1GEg=;
        b=BLtiYyNTUJl82CUHd4kkAKdDEbzAGNZVQjDL+bT8RSIFpIvNENalVZuLt+Md7PKnEUOPEGEC/vmA4rYO43nvfMYKwzuUZFSfZI/rOovfbuSujPwKW58e4AnXK/Su8VFFyqhUzk6cQhUZ6MJgyN10UHvWNfyJ0tS3LkUOGd1qUHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Sayrxkm4gkoexqMtKUequjBlJpMWxrxOGazf4cOfHXGXgyu6pJXg21A2nOEGezySiCutQM+mm93X1DirTGqQhBpm+Jpm7rM/bNRjvwFFv6nzXY9wKs5GGffxFAkjWcKFsJygt+T5NNOnNeVrsQbHvPOzcGUSSbJSwugyRIfV4Aw=
Received: by 10.65.23.7 with SMTP id a7mr4990961qbj.1196445184661;
        Fri, 30 Nov 2007 09:53:04 -0800 (PST)
Received: by 10.65.239.2 with HTTP; Fri, 30 Nov 2007 09:53:04 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66651>

Dear list,

I'm having some trouble when I change an existing directory in a
project into a submodule. After pushing this change to the origin, I
can no longer pull into any other projects. I can, however, clone the
origin without problems.

These are the steps I take to change the dir into a submod:

rm -rf /submod
git commit -a
git submodule add git://abc/submod submod
git commit
git push

But then attempting to pull this anywhere else results in a
half-completed pull, and dies with the error:

fatal: cannot read object bb138891993fdeb3dbfcb41fe8c2a4693676f8fe
'submod~564e58282ce575db34b6f249a42b1ea59f56efd3'
Merge with strategy recursive failed.

Like I said, though, a fresh clone works fine. Am I doing something
wrong in my push, or is this a bug?

Thanks,
Paul Sadauskas
