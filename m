From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/8] Improve git-status --ignored
Date: Tue, 19 Mar 2013 12:20:39 +0700
Message-ID: <CACsJy8DShce6bXfyWyHk7pqg4PA-cAn1bKh0hgFYX=s486nwaA@mail.gmail.com>
References: <514778E4.1040607@gmail.com> <7vsj3skp5b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 06:21:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHozS-0000YS-Jv
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 06:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344Ab3CSFVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 01:21:11 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:52029 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab3CSFVL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 01:21:11 -0400
Received: by mail-oa0-f51.google.com with SMTP id h2so70869oag.38
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 22:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wT8ejZyNZ1LJIuJlO3KsWU8EaShl48AntPaLYFSh5e4=;
        b=JFOWTQavafVNu9sDJX+wiPcwpvrLTTColRFiqHtIK2p0m7c1OyQAHJN20H2TqrDwmZ
         6yvFje7sL6NMqwADpJhC/1v7zeRhc0U51BG0s/8K+YukRnQDcUXs5VPJmod2A2Qun+Sp
         7Aum7mrcr0h4y2KvHR3Occ742BIPl8ubB3C7afjq4LTW3p8eAD2kDLfuQ+TAlLz5G3We
         wpoj7+tpu0LwiyA2CCWnKbTtGz2wtByuCJLOldywtNUAx3TrX23fIfNZiMVGCsyOl70j
         4cxqCn2HWmoWArScxc89mfYoO6+4dlpP/5e0P7krj34DUngnYGy2hfsCtMSS4QKowNTX
         AwCw==
X-Received: by 10.182.147.2 with SMTP id tg2mr407565obb.47.1363670470436; Mon,
 18 Mar 2013 22:21:10 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Mon, 18 Mar 2013 22:20:39 -0700 (PDT)
In-Reply-To: <7vsj3skp5b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218481>

On Tue, Mar 19, 2013 at 11:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karsten Blees <karsten.blees@gmail.com> writes:
>
>> This patch series addresses several bugs and performance issues in
>> .gitignore processing that came up in the inotify discussion.
>
> Thanks.
>
> How does this interact with the nd/read-directory-recursive-optim
> topic that has been cooking for a while?

I think 8/8 is another version of nd/read-directory-recursive-optim
-- 
Duy
