From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [RFC/PATCH 2/3] Documentation: gitrevisions
Date: Tue, 13 Jul 2010 23:16:11 -0700
Message-ID: <4C3D562B.3070404@gmail.com>
References: <cover.1278346173.git.git@drmicha.warpmail.net> <7efed85cefddff1cd2cc3a0e3802326306117f4e.1278346173.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 14 08:16:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYvGc-0001V3-Pl
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 08:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab0GNGQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 02:16:21 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57185 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0GNGQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 02:16:20 -0400
Received: by pzk26 with SMTP id 26so1524575pzk.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 23:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=apkpK174nW5X/Dk+DCTxrlToRrLD+Hv5CNEI4Pua6aM=;
        b=t4AtSH742eeitpuh1OSPddXBKqkyRrStM05iO3orWInax3sSbgLqG8gYPJOe3LhwaR
         ptRxowtxgXMZP1H5hd1eV2uT8+017cq/ErbICZksa1W/MKr6w/eAL+vXBOc4/Fcrzf0X
         YHbqdGVVX9bT9yV4bVH42gSxF6RDQPPkBY1pY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=F2r3/yBmk9fp+OkLZ/ubWk/P+HnaGHuHrtaeWilohOMKV5SW3GKtY/mfHKmUkh+5yj
         /EeKNiXqvoC5PE1V5i2fhlQgNDwfvnDuLQ+aQG4jeRXy6UlNedPRDd73JT1yBxHjCYey
         ND7paiEJ8+30owxF6Xf+pUS7ttDIeb13urro8=
Received: by 10.142.48.18 with SMTP id v18mr5060502wfv.100.1279088180106;
        Tue, 13 Jul 2010 23:16:20 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id w8sm7086024wfd.19.2010.07.13.23.16.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 23:16:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.4) Gecko/20100713 Thunderbird/3.1
In-Reply-To: <7efed85cefddff1cd2cc3a0e3802326306117f4e.1278346173.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150967>

  On 07/05/2010 09:11 AM, Michael J Gruber wrote:
> +
> +DESCRIPTION
> +-----------
> +
> +Many Git commands take revision parameters as arguments. Depending on
> +the command, they denote a specific commit or, for commands which
> +walk the revision graph (such as linkgit:git-log[1]), all commits which can
> +be reached from that commit. In the latter case one can also specify a
> +range of revisions explicitly.
> +
> +In addition, some Git commands (such as linkgit:git-show[1]) also take
> +revision parameters which denote other objects than commits, e.g. blobs
> +("files") or trees ("directories of files").
> +

Is any of this text (section?) necessary besides including revisions.txt? It seems that revisions.txt nicely covers the types of revisions in the first paragraph of each section and these two paragraphs repeat that.

Can you squash this in?

--->8----

index fc4789f..0e25c5f 100644
--- a/Documentation/gitrevisions.txt
+++ b/Documentation/gitrevisions.txt
@@ -10,19 +10,6 @@ SYNOPSIS
  gitrevisions


-DESCRIPTION
------------
-
-Many Git commands take revision parameters as arguments. Depending on
-the command, they denote a specific commit or, for commands which
-walk the revision graph (such as linkgit:git-log[1]), all commits which can
-be reached from that commit. In the latter case one can also specify a
-range of revisions explicitly.
-
-In addition, some Git commands (such as linkgit:git-show[1]) also take
-revision parameters which denote other objects than commits, e.g. blobs
-("files") or trees ("directories of files").
-
  include::revisions.txt[]
