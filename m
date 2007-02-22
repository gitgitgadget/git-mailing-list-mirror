From: "Francis Moreau" <francis.moro@gmail.com>
Subject: git-am failed, what's next ?
Date: Thu, 22 Feb 2007 09:22:27 +0100
Message-ID: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 09:22:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK9Dm-0004Nf-Gu
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 09:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbXBVIWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 03:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbXBVIWb
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 03:22:31 -0500
Received: from qb-out-0506.google.com ([72.14.204.234]:16526 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbXBVIWa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 03:22:30 -0500
Received: by qb-out-0506.google.com with SMTP id z8so48367qbc
        for <git@vger.kernel.org>; Thu, 22 Feb 2007 00:22:28 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Tr4yLwRsilUIRXe9niXloAlk0HG6kr4OE7eK/+WWvAj2JR6h5M/zVKGFNeq6aRh0Q2i06oe2LzeyojKmPSjJmUxlCwZWXLIwXJcTUvyfmyt8GbSxi2AAy8qMjCIuSaAL/kerUHLPe4z3RKYJEm62YPeYHiry4nci37zMGnG1xeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VCc6MVq4tpikKVyA7D2RVkfsotAI8zI1wjGdMNfk8qAOimpuXXEha5mWNumg0Vrd4QtyGstEOhxJK9QFkThjZON2FXDS8xzkk4k6vx8Gn8NPEocCG5Q31fOnFhj7scc9gqLUY88ZJ8H8fMMnvYTGZ6T41MVdMm9zPNu0QfHyJ9A=
Received: by 10.114.73.1 with SMTP id v1mr149638waa.1172132547550;
        Thu, 22 Feb 2007 00:22:27 -0800 (PST)
Received: by 10.115.47.14 with HTTP; Thu, 22 Feb 2007 00:22:27 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40338>

Hi,

I'm a bit clueless when git-am failed to apply a patch. I dunno what I
should do at this point since errors reported by git-am are not
usefull for me. For example I got:

----
error: patch failed: foo:1
error: foo: patch does not apply

Patch failed at 0001.
When you have resolved this problem run "git-am --resolved".
If you would prefer to skip this patch, instead run "git-am --skip".
---

I know that git-am let some information in '.dotest' directory and
that I can find in it the plain patch file. I can use 'patch' command
to apply it and see which part of the patch is conflicting. But I
would like to know if there are other ways to do it specially by using
git ?

BTW, would it be possible to be more verbose when describing the error ?

thanks
-- 
Francis

PS: git rocks !
