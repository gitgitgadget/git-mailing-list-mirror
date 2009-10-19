From: Mohit Aron <mohit.aron@gmail.com>
Subject: denying branch creation in a shared repository
Date: Mon, 19 Oct 2009 01:32:24 -0700
Message-ID: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 10:32:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MznfK-00005i-Sd
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 10:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbZJSIcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 04:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754534AbZJSIcU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 04:32:20 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:59321 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbZJSIcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 04:32:19 -0400
Received: by pwj1 with SMTP id 1so512196pwj.21
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 01:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=ShWtZZMMZGSDi8Zon6fnxACxc4TXvn3bHH2/4maS9+M=;
        b=Kk8I5j8BZxD1C0cmDOBwYsGOFMa5TmTed/PcB53FvolbKC7Ro3f84TdXXR8WfFZDKY
         QJRXScx3/qMHOqghE3aR/uyno6SJ/qYg4SUVlUQwU8Tb5h4oHag5cQaRUXHq6+8goJNR
         4rZYm4abcQUe59aqihI8pfBWvPxX0kFfvb2go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bY5T5fH3vL+mQFrtFb8R2jo+C2Vi0d5zol9/3IRBbRevZL06O/Wtlf2LvartmQP/4R
         f6GzjmGrhtWDgzp1Eec6J8+RzM6G35qtuwuXlikVD1nB033hDc8vHtQOd12SoI7iaCl+
         sFUDNLCQ4JE3Wwv0lfC8KeYx0CaJ3CuAYV1A4=
Received: by 10.114.18.17 with SMTP id 17mr5649189war.131.1255941144165; Mon, 
	19 Oct 2009 01:32:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130677>

Hello,

I'm setting up a shared repository and I'd like to prevent users from
creating branches in it (they can of course create local branches in
their own clone of this repository). How can I accomplish this ? I
looked at 'git help config' and it seems I need something similar to
the parameter receive.denyDeletes - this prevents deletion of
branches.


- Mohit
