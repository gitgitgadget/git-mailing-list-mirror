From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/6] gitweb: action in path with use_pathinfo
Date: Tue, 30 Sep 2008 14:53:08 +0200
Message-ID: <cb7bb73a0809300553o7496f4c1me14ddf55b31fe4a6@mail.gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200809301048.40046.jnareb@gmail.com>
	 <cb7bb73a0809300340t79a497fey4ededd960223fcdd@mail.gmail.com>
	 <200809301322.58280.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 14:54:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkek9-0003Cn-Ma
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 14:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbYI3MxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 08:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYI3MxK
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 08:53:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:55859 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYI3MxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 08:53:09 -0400
Received: by yw-out-2324.google.com with SMTP id 9so44ywe.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NRmZxMj9k4ImkLyEVBkQHz1TS6CjAaaf7XnRk+l68oI=;
        b=DwltwmwqP9Z3i2Oh7eXj+sxgwAANuTeAyT0RdP7OWlgC26JW01K/MEzaXQS2t/jIOf
         qJDOeD4YoAH8bWMkmYUkHBFsu/Rnk7vHcWCd2mFD2FZAskwxlMz0Lq1U7qlbtXbWpcZm
         JjwMGW2VRAH+hx9oZPyrKqP2HEj8KtfojghxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IIAo5m/fG4Y5WQObRA1w3C72QzjDSOHWekF7n6b4CfiZVVx610aevPwD1oBvkxv7YM
         8Dn5ZpDINpV8FC3lJGU7twSd4OeOofbeioXTOLvtOMbNSdhdX3F6uBsLddxvRnnknDrK
         aN9h/G3dW2QLICBufEXPSYECmIfQLpdGV+Ac8=
Received: by 10.150.122.13 with SMTP id u13mr9901355ybc.238.1222779188225;
        Tue, 30 Sep 2008 05:53:08 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Tue, 30 Sep 2008 05:53:08 -0700 (PDT)
In-Reply-To: <200809301322.58280.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97108>

On Tue, Sep 30, 2008 at 1:22 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 30 Sep 2008, Giuseppe "Oblomov" Bilotta wrote:
>> On Tue, Sep 30, 2008 at 10:48 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>
>> > Or we could just scrap and revert adding href(..., -replay=>1).
>> > There is much trouble with getting it right and performing well,
>> > and it is less useful than I thought (at least now).
>>
>> Dunno, the idea in itself is not bad. We just have to get it right ;)
>
> It is not easy to get it right, especially that there are multivalued
> parameters like @extra_options, see e.g. commit 7863c612

So we just let values be arrays. Or isn't this enough?

-- 
Giuseppe "Oblomov" Bilotta
