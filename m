From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: bug/feature request: apply textconv in "git add -p" diff output
Date: Sat, 20 Jun 2009 17:17:41 +1000
Message-ID: <fcaeb9bf0906200017x6cc63c29q5515c11c202e424e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 20 09:18:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHuqo-00060u-Ad
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 09:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbZFTHSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 03:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbZFTHSB
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 03:18:01 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:44845 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbZFTHSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 03:18:00 -0400
Received: by an-out-0708.google.com with SMTP id d40so3666639and.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 00:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=hjBAHtieAwDl/odBKHVIhq/ln21/hsBDbQlGiUhOOPk=;
        b=MymmmJ+AS7uq8ydUISkRqJwz6bfbrBz6DAvoh9+PkN9YT+ooF18h4WLprENCWK5q6q
         03k3wFl36BG4mKCSoZss0g2gNb4PkXeI3lEQIFaopHcbLqcdZQm1MAUC8J7+Qig62e8j
         u7dHhF+F0e3zHPW66dnpU7O54CF+ISlz8/SUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=oJulEtm0/zN5jYW8yeEyTc/dEL4/FVVda92wajXkSVO15c3Y/8irhJnU/OL0cI53zK
         YGPcWHDvSubpN+Jvy252dxiWDgaaVzOTbEGKQM7otZDa6sLq77uhjFoIuS/9U919JrzB
         Oxw6NMAJfa2NmRGc8wAOje1wVMuquNYrmxalA=
Received: by 10.100.10.15 with SMTP id 15mr5046944anj.8.1245482281166; Sat, 20 
	Jun 2009 00:18:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121935>

Hi,

I use git to manage bdf font files. It it quite cryptic so textconv
for diff output makes it much easier to keep track of changes. The
only problem is that "git add -p" does not seems to use textconv, so I
have to run in parallel "git diff" and "git add -p", then add chunks
accordingly. Can somebody add textconv support to "git add -p" please?
I'm not so good at Perl to do the job.

Thanks,
-- 
Duy
