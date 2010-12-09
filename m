From: Thiago Farina <tfransosi@gmail.com>
Subject: file names
Date: Thu, 9 Dec 2010 15:05:33 -0200
Message-ID: <AANLkTikeAFj68Rr35gcf4dxXXHU+au9wA7wd+-WB3BSS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 09 18:05:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQjwK-0000HK-Of
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 18:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210Ab0LIRFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 12:05:36 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:59181 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108Ab0LIRFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 12:05:34 -0500
Received: by bwz16 with SMTP id 16so2894752bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=FckSNcJ03a3L/HUbZV8grHCuFavS8ZziDboqt8sZdL8=;
        b=wxwHH55UT4Sd6LtjkvT1+egE+yutZRbl441EToWgFc9guYPVkfhEvfaiS27H5OPhyC
         mxOcBBfzePDvz8MDDvq2R8mpePOzc+jHFba8P3nN+CqSbXFdA09ZW9RaMnXRfNs3Jdsb
         9i5rGqw0ld0pzd/U2V9Kb0lGvPYvBzaJnZYt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ppPeKD3XrdukYgeZwMZvFd2AEQoadJsdJtCCc8ZWkID4PFF1ryNUpSC7FxverVcgBJ
         QtP/dL7bL4Pi9r7PQLdq2AeVHLpTXfPjm8qKrZJPbTZm4GgFZIQXXIpTrv6eN+LMXEmM
         f7pYNVUTRpZhRJPGzgRarvUgfjwG1YOgba94M=
Received: by 10.204.52.75 with SMTP id h11mr3625024bkg.67.1291914333515; Thu,
 09 Dec 2010 09:05:33 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Thu, 9 Dec 2010 09:05:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163295>

Hi, I was was looking into the file names and noticed that they are
not consistent.

Some files are named like:

foo-bar.[c/h]

Others are:

foo_bar.[c/h]

On top of the git directory:

# With dash
$ lc *.c | grep - | wc -l
72

$ lc *.h | grep - | wc -l
25

# With underline
$ ls *.c | grep _ | wc -l
5

$ ls *.h | grep _ | wc -l
1

So it seems from this data, there is a preference for naming files
using dash over underline.

So the question is, should the files using underline be converted to
use dash instead? And should this be documented somewhere? Maybe in
CodingGuidelines?

Thanks in advance.
