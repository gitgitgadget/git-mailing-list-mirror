From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: branch versioning
Date: Mon, 4 Oct 2010 20:18:59 +0700
Message-ID: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 15:19:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2kwc-0001ul-S0
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 15:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757Ab0JDNTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 09:19:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48456 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708Ab0JDNTA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 09:19:00 -0400
Received: by wyb28 with SMTP id 28so4873840wyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=ZF+mgY6weoxSkPiswj8P87nGFJ0OlqfkuqTaZQpcN0c=;
        b=lb3IOCNjEyl6nSzC8txa5F2jxXK3hCAuESv1Lp2W2qyNe1Mpe3b8VQL+Re4IX6xecW
         /DlBdkU4OST7LQjmWzfnPTFwWL4PtUT8EYggSnx17hCnEFWVu/k1p5UIXm/5+rkXwD9x
         E2+bp5MB8xmjaE+t2YF5Q2Uvt5+dJmixD6ToA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=L49Ks2NVn/u4n+kjC7I+O0rq+URUDDb8vMNY8lwh2dtgwts1SYFkmu7g5fqvppwbof
         IfMzGYbjd6nQwIl5Qsul8y3DAnPI/Ol/l2wJYbq2+qBVABA71rWf3KxLtBGCnmrw/lr6
         2a3bUDEEzWkgpbTEKhfYie6eMvMXVp5U17o9I=
Received: by 10.227.156.196 with SMTP id y4mr7314704wbw.219.1286198339049;
 Mon, 04 Oct 2010 06:18:59 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Mon, 4 Oct 2010 06:18:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158045>

Hi,

How do you guys manage versions of a topic branch? I usually end up
saving format-patch series somewhere or forget all old versions.
Although I really want to keep old versions around. reflog to me   is
polluted with every kind of branch updates. And it's local
information. It can't be transferred to another repo (or can it?)

On the same subject, I have quite a few old topic branches that I
rarely touch. I don't want to remove them. I just want to hide them
away from "git branch". I've been thinking of "attic/" namespace that
"git branch" by default will not show. Just wondering if other people
face the same problem..
-- 
Duy
