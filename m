X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 23:39:54 +0100
Message-ID: <200610302339.55128.jnareb@gmail.com>
References: <850923.44762.qm@web31812.mail.mud.yahoo.com> <200610302250.06733.jnareb@gmail.com> <20061030233017.19f25117.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 22:40:13 +0000 (UTC)
Cc: ltuikov@yahoo.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HJZLVv0QaOzZsrkOghms9LNYbHT9aJA60RghGrR0uonFqLQma0oeZZrcbRDJ/slirh8TU7jWCOguqfZcgWpfV8QHLIAH2vPhCMA1quj8UQctA+ky/NvCwklKHRTLPCkYgffE44GWDGI5PvLivx37nK+1ecuyu+PRmV7ZbLENZCI=
User-Agent: KMail/1.9.3
In-Reply-To: <20061030233017.19f25117.froese@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30541>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GefnY-0004dL-SI for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422712AbWJ3Wj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422721AbWJ3Wj7
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:39:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:55047 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1422712AbWJ3Wj6
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:39:58 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1287971ugm for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 14:39:53 -0800 (PST)
Received: by 10.66.249.11 with SMTP id w11mr5034567ugh; Mon, 30 Oct 2006
 14:39:52 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id l40sm3433532ugc.2006.10.30.14.39.52; Mon, 30 Oct
 2006 14:39:52 -0800 (PST)
To: Edgar Toernig <froese@gmx.de>
Sender: git-owner@vger.kernel.org

Edgar Toernig wrote:
> Jakub Narebski wrote:
>>
>> I'm just saying that with HTML diffs, presented via gitweb in graphical
>> web browser, you have more possibilities, more formatting to use.
> 
> It would be nice though, when the gitweb output would be readable
> on non css-capable browsers (i.e. w3m) too.  At the moment, gitweb
> is mostly usable - the only problematic case is code and diffs.
> These are presented via div-tags so in a non-css browser, all spaces
> are collapsed thereby removing all indentation.  Couldn't code
> fragments be presented via (styled) pre-tags for backward compatibility?
> Pretty please :)

Well, we replaced using s/ /&nbsp;/g with .pre class woth white-space: pre.
Perhaps we can go halfway, and add <pre>...</pre> wrapping line.
 
> Btw, while the css version looks nice, Opera seems to have extreme
> performance problems with gitweb's project page when there are a lot
> of repositories.  I.e. trying to view http://gitweb.freedesktop.org/
> brings my system to its knees.  Turning off style sheets cures it
> but then diffs are unusable ...

Strange. It's just a simple table. Could you and would you be able to
debug it further (e.g. by bisecting CSS)?

-- 
Jakub Narebski
