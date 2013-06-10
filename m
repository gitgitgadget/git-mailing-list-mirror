From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Mon, 10 Jun 2013 13:11:44 +0530
Message-ID: <CALkWK0nLa5tZfNvjYNAGx6zuA=49JSwZttCLhAE8+3ifBOA1FA@mail.gmail.com>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org> <20130607000006.GA25731@goldbirke>
 <CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
 <7v8v2lu5ks.fsf@alter.siamese.dyndns.org> <20130607191643.GA31625@goldbirke>
 <7vwqq5snzi.fsf@alter.siamese.dyndns.org> <20130607204430.GD31625@goldbirke>
 <7vk3m5si4h.fsf@alter.siamese.dyndns.org> <20130608001147.GA32350@goldbirke>
 <7v1u8bouam.fsf@alter.siamese.dyndns.org> <CALkWK0kvSvK=bFJo13=yw+2EZmGyv46_DUEZaniYGCe7D_V2wg@mail.gmail.com>
 <7v1u8amovl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 09:42:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlwkH-0002cw-1q
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 09:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab3FJHmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 03:42:25 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:43607 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab3FJHmY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 03:42:24 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so7107257ieb.38
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 00:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OWd42QoMsoC2VIpuTxYbwsVBV/YRyyzIqZsIbUAERo0=;
        b=s9IzyMifpF+dhjidOurBzJGNBFLKjq5fkYk4sgtgMpx5ngJiCXnHl134jfDTsICmMo
         IDOIS3CVj0uoUd3fKI6l9IgROVk6U6OqcMr3pdz9I+U2OkaH9b5XIg/HQF77le9NX8vE
         LWl/vARE52AHzrxqUNXFDukX61AfSmqTGeoHtV+L934n395lmEk7h+RcQ//X3pTrwXw8
         6ujI9HXQtyRtAmC8nzRMP3HzY88AerdN4MV5J3uSJXH07pBvz6wbgeKTw2ioiw3qxBVJ
         xdP82QgMyIfz0PsAupkqIE3MLcWb0C+8bhZgn6k8q5vYzO1WWDG0EXeC1aAyGQQCxO3n
         sWPg==
X-Received: by 10.50.79.231 with SMTP id m7mr3394037igx.40.1370850144290; Mon,
 10 Jun 2013 00:42:24 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 10 Jun 2013 00:41:44 -0700 (PDT)
In-Reply-To: <7v1u8amovl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227250>

Junio C Hamano wrote:
> But it turns out that in the context of these functions it refers to
> "what users consider paths in objects stored in the object database"
> (as opposed to working tree paths).  That is what ls-tree would take
> (i.e. <tree-ish> and <tree-ish>:<path>).  And I do not offhand think
> of a better name myself to strongly oppose to using the word FILE to
> refer to what it does.

__git_complete_treeish().  Write a new patch with a proper comment
saying why it is aliased to __git_complete_revlist_file().
