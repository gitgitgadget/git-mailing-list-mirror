From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: submodule usage with links
Date: Mon, 17 Mar 2008 13:52:52 +0000
Message-ID: <320075ff0803170652i75041745v7825915f153fa577@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 14:53:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbFmY-0003iR-Pt
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 14:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbYCQNw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 09:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbYCQNw6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 09:52:58 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:29421 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbYCQNw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 09:52:58 -0400
Received: by ik-out-1112.google.com with SMTP id c28so2317730ika.5
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=vLb/knd3rCwe7+XjudLQVl9WaTAl6ekQx1ha23Z2IxY=;
        b=XWNvhm80G1GlKs1hwzGFdHa7v1UW1srptWHkl5418JYoWd5IVFmVJ4M3QQqe3rUahgH38MSrORVN1DnxI7fEP6tFhxUqA4lSrjI/8NN6telTekKSp2ZypSpAVcLtdTIWpH1nmDD4YSQFyYya0Bj6TaFRkmCpE1QysBY5dv05EjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Bcfel06jdUB3FiqX7cW48yRByFuay66iZyxuRC2ZfaKxGSH4ZB3FHjtS0ukUnLE87Zbl7sGGsZ9vRVy+YNMVITlJEcOJk3pNd0/AvvTRfBM6ho0j1tAyEtC6VRqQPWHYno99XcW8Ya6BD59pEagEBRbTnqieTZ8ZEmj8y6qKZoE=
Received: by 10.142.163.14 with SMTP id l14mr103379wfe.73.1205761972209;
        Mon, 17 Mar 2008 06:52:52 -0700 (PDT)
Received: by 10.66.243.3 with HTTP; Mon, 17 Mar 2008 06:52:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77432>

Hi there

We use a lot of repo links that I'd like to use submodule support for.

Instead of doing
git submodule add ~/module/a
or even
git submodule add git://myhost/module/a

I'd like to share a, and do something like

<<add value to .gitmodules>>
ln -s a ../modules/a
?? do something to add 'A' to the index as a 'subproject commit'
rather than a symlink ??

I'm stuck on the last bit - or is this not going to work?
