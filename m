X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 12:59:12 +0100
Message-ID: <200611201159.16596.andyparkins@gmail.com>
References: <200611201157.23680.litvinov2004@gmail.com> <200611201101.04456.andyparkins@gmail.com> <ejs2lp$2r4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 11:59:40 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YAsIYIzjOa3eY5zdAZRiAXTQYXsayGa3H76TAlcXJnVUzZAheu+zdgd168vRx4c/24KoYPMAEz8+OtefsjtmcJ2S3eUo3ZI0xr+Imn3FEEv1MoB+Y9djWNXWhntYh41ZOo0ydxfVGZJxw3TTqLncX4S1CMztUJW2hwbA3BBSjFM=
User-Agent: KMail/1.9.5
In-Reply-To: <ejs2lp$2r4$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31909>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm7o4-0007nC-N8 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 12:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934078AbWKTL7V (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 06:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934081AbWKTL7V
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 06:59:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:61134 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S934078AbWKTL7U
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 06:59:20 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1152063ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 03:59:19 -0800 (PST)
Received: by 10.66.216.20 with SMTP id o20mr6093499ugg.1164023959522; Mon, 20
 Nov 2006 03:59:19 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 55sm4507585ugq.2006.11.20.03.59.19; Mon, 20 Nov 2006 03:59:19 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Monday 2006 November 20 11:15, Jakub Narebski wrote:

> I'm not sure about this. You usually both do pure renames (to reorganize
> files, to give file a better name) and renames with modification, but
> I don't think that copy without modification is very common. Usually you
> copy a file because you take one file as template for the other, or you
> split file, or you join files into one file.

Exactly - unfortunately it's the /source/ that has to be modified to be 
included in the potential list.  Who copies a file then modifies the 
original?  The copy is by definition already one of the modified files.

"For performance reasons, by default, -C option finds copies only if the 
original file of the copy was modified in the same changeset. This flag makes"

Your points about copy-and-change accepted.  Hash comparison is not 
sufficient.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
