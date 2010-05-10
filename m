From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git branch descriptions
Date: Mon, 10 May 2010 17:08:55 +0200
Message-ID: <AANLkTin9e0-Zyk1RTpp3hFA0-Wqclabd2JQZAuxd74gG@mail.gmail.com>
References: <657A681BEF27534399890012B8C8E50E1AD63D1FEA@lcs-exchange01.Lantekcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joel Reed <jreed@lantekcs.com>
X-From: git-owner@vger.kernel.org Mon May 10 17:09:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBUcH-00034L-IK
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 17:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab0EJPJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 11:09:21 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:36526 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab0EJPJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 11:09:20 -0400
Received: by qyk13 with SMTP id 13so6279457qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lK++ju1GZDHut61GKtC5T+haAyg4l4MS7qUt4Kw9giY=;
        b=Mjl9K8I5PILWXSyXqA6P0KM3G7umeSQkpRA52FN87wylBA8wNt5d1VYIgjR2lXPabe
         upheUXbZxpAWm91R5Ku71T2JVvDydaueiJ5nfwpCo8tIWuZnes/SaeLenic5CeMXjYbr
         t7q64rSBornOQJthIYrVaXxZxwFrq+WRrkz+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=T92rB5bvJLqEdgLSjyaRU8/V+GIv9F4wiJ+MtWihhrmlOftYhR8VVkqHxsCYxpOg7C
         TwDd3pFjQECV2ahiMBfv0+L/4WQwNU0a68T1kAhBpHjDdvcKy7GUPvNbTNHOsHFzNuqi
         WO7wWdB1NumJBlZmbYUOMpqfeQUVHbEz2N3/Y=
Received: by 10.224.59.222 with SMTP id m30mr2767448qah.40.1273504155232; Mon, 
	10 May 2010 08:09:15 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 10 May 2010 08:08:55 -0700 (PDT)
In-Reply-To: <657A681BEF27534399890012B8C8E50E1AD63D1FEA@lcs-exchange01.Lantekcs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146819>

Hi,

> I've used git in several jobs now and keep coming back to _really_ wi=
shing I could attach a description to some of my branches. Working on a=
 wide range of topics/branches from week to week and project to project=
, it's sometimes difficult to quickly remember what each branch is abou=
t, without doing a git diff master <branch>. =C2=A0I like to keep branc=
h names short so they're easy to switch to and from, but being able to =
attach a description that would display when doing a "git branch" would=
 be a huge help.

I think git-notes(1) is the closest thing to what you want.

-- Ram
