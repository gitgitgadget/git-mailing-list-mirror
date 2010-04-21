From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: No way to have global diff settings? (global .gitattributes feature request)
Date: Wed, 21 Apr 2010 19:05:53 +0200
Message-ID: <87zl0wd9ce.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 19:05:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4dMw-0004Ru-Qz
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 19:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab0DURFl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 13:05:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:24984 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab0DURFl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 13:05:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3217347fgg.1
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:user-agent
         :date:message-id:mime-version:content-type:content-transfer-encoding;
        bh=lZGE5VsN5QVoQFN2L1yOrKzDilK4lXADB8U2vzIMsww=;
        b=Op4jrRF3sMmeJ+OeTT4mQL8HlhFsrtz0ZC1H04cd+9V++TGR0D1f7j8EvCSHz4bbGT
         gaXKZO3Y95VSJna7NxbnYq2xKulPZ61k5qPjvVaXD6lYL41F9nI7OB6Ls1hk+39Qi6kE
         WXQTtcnfzk0SIeap+9t4+mffR1oWVRcUUiYA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        b=sh8DAy9pdUGxAY4vPSBskTEJKuy5o2/t8xrRJWeQ6B7aYVv63s43SBUTBxjLi42zqq
         Nj6Jhiia3yTuegqDn157n1KBWmXesv40B4HgHv/5VFh/IVHIOvvQ57fnro/EZ2jajRrh
         gubYTagZ9ypmd0MrvDMRpakX7Oc8xBfA7eBXc=
Received: by 10.87.19.37 with SMTP id w37mr2923206fgi.25.1271869539148;
        Wed, 21 Apr 2010 10:05:39 -0700 (PDT)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id e11sm2318430fga.23.2010.04.21.10.05.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 10:05:37 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145445>


Hello,

it seems there is no global .gitattribute equivalent to .gitignore or
=2Egitconfig. Wouldn't it make much sense to have one? Failing that, th=
ere
really should be a way to specify some global diff options at least.

My use case:

I wanted to specify something like -F "^(" to git diff for lisp files.
But well, git diff has no -F option! So shruggar from #git pointed me t=
o
gitattributes. OK, that's great and works, but now I have to put
=2Egitattributes or info/attributes to all repos with lisp files in the=
m?
That rather sucks, if you ask me.

So I would like to ask if there is a way, and if not, if it could be
considered a useful feature addition.

Thanks,

  =C5=A0t=C4=9Bp=C3=A1n
