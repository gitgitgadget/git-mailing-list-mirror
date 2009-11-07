From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 0/4] Improve format-patch (mostly documentation)
Date: Sat, 07 Nov 2009 10:45:38 +0100
Message-ID: <4AF541C2.5000504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 10:45:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6hrj-0000fO-5H
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 10:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbZKGJph convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 04:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZKGJpg
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 04:45:36 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:36751 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbZKGJpg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 04:45:36 -0500
Received: by ewy3 with SMTP id 3so1770201ewy.37
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 01:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=8AVhviNP4dJ7FsB8DLMq7Aq4Bwa07x6amD6aGENfpSE=;
        b=pbpM1eS0iG6FQkVWgZOgnok5DTiZjnw8i2sm7cc5AUHLlQioknPcTLFe4wfnvt/LCj
         47MjaTmRKp2YWqfa9yEkZhDzyLGLL/bi3sBF//dPBT1JiPOlYJYwBdvxzG6rAhz0WFwc
         HrVSAxMYk8VP6wBTBsqWdfm/8VI+5+ZFqeqIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=C+lIPekVm9lViOGOIJCUSs6WeLWSkqhLNX0bCV8SH5Q+TL3S8zxhx/xIECf94+s6GY
         1+RoPpaGlMh62ahZrfkmJ41XG5gE6usmRC58UXNLtm3QSul2o6z/5U44zernT5x0sQLF
         iPpTF/G8HBpTOXhL+kcdXG38xUhtEmrKvCdLk=
Received: by 10.213.23.200 with SMTP id s8mr520460ebb.52.1257587140670;
        Sat, 07 Nov 2009 01:45:40 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm776705eyb.40.2009.11.07.01.45.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 01:45:39 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132354>

Here is version 2 of my patch series to improve the consistency
between the documentation and implementation of format-patch.
It is implemented on top of Peff's recent commit to reinstate -p.

Bj=C3=B6rn Gustavsson (4):
  format-patch: Always generate a patch
  format-patch documentation: Remove diff options that are not useful
  format-patch documentation: Fix formatting
  format-patch: Add "--no-stat" as a synonym for "-p"

 Documentation/diff-options.txt     |   61 ++++++++++++++++++++++++----=
--------
 Documentation/git-format-patch.txt |   46 +++++++++++++-------------
 builtin-log.c                      |   21 +++++++++---
 t/t4014-format-patch.sh            |   18 ++++++++++
 4 files changed, 98 insertions(+), 48 deletions(-)
