X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 17:33:42 +0600
Message-ID: <200611201733.42723.litvinov2004@gmail.com>
References: <200611201157.23680.litvinov2004@gmail.com> <200611200951.05529.andyparkins@gmail.com> <7vejry5t4g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 11:34:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ae17fbm0Yx4BqtgxbZPR6lA0NY6f/6UwtaWfPhtHIN8JwKEEMUvv1oyte8zhPiPzBzzyGN7vhKGT8+oIkiNqa93XcN33b2Sw2+idrqV82h0CX2rNvomTEpb2Y3ZPLX6OR0/deUimtcxPhAnU5oSoGZ4knYm5hsXhVGm72lBxlAI=
User-Agent: KMail/1.8
In-Reply-To: <7vejry5t4g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31908>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm7PO-00049R-Q6 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 12:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933759AbWKTLdw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 06:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933762AbWKTLdw
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 06:33:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:61529 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933759AbWKTLdv
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 06:33:51 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1146888ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 03:33:50 -0800 (PST)
Received: by 10.67.91.6 with SMTP id t6mr7677060ugl.1164022429397; Mon, 20
 Nov 2006 03:33:49 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2]) by mx.google.com with ESMTP id
 30sm8230960ugf.2006.11.20.03.33.48; Mon, 20 Nov 2006 03:33:48 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

> What it means is that "git log" will look at path that matches
> b/a (that means b/a/c and b/a/d are looked at, if b/a were a
> directory).  Since path "a" which is what the file was
> originally at is not something the pattern b/a matches, there is
> no way b/a is noticed as a rename from a.

I have found that git blame show correct commits for this case. But I am still 
in trouble then examining file's history. I have found I can use 
git show -C -M commit-sha1 
for commit there file was created to see if this was a rename :-)

