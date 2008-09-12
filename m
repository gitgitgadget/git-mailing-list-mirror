From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: CGit and repository list
Date: Fri, 12 Sep 2008 18:12:43 +0200
Message-ID: <8c5c35580809120912r22f16063sa779cd2ce43dd131@mail.gmail.com>
References: <19449377.post@talk.nabble.com>
	 <8c5c35580809120736x4170b2dbq3438bd619326ae00@mail.gmail.com>
	 <20080912145804.GF10544@machine.or.cz>
	 <200809121754.30277.jnareb@gmail.com>
	 <20080912160006.GI22960@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, "Petr Baudis" <pasky@suse.cz>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 18:14:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeBHO-0006VH-1f
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 18:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbYILQMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 12:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbYILQMr
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 12:12:47 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:16587 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbYILQMq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 12:12:46 -0400
Received: by py-out-1112.google.com with SMTP id p76so733615pyb.10
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DAnqVSVnnpC/phPPlfzeolqg1ztKuyzTakvaRwGJpPI=;
        b=EUwb+hcaAGAyudPr2WQ17GD+pWmyNx6HcrwWpGXMWc8a4eF920iS3gBb15ocUd6eUh
         Jp8qv3OWT8ZLzBirynhorTM3ICLysfjeBbPFD/yQwVx7Xe79qV05U+AvPwd+B+S17sIL
         NBRQSDo2b37vLaGLhL4Hb1Rfyvy57zSq0rde8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AimLhw2lJL+mZQDHrPFdHasVpoxhnJXyT9dPCkRkzaUrh2lj92kspPA/UwsGmPgXR+
         Y5ANCeNxyOiEocaeWaBYMfBCojSrj+Hl8ZrlUuRE+Jo3Z6ys75wR9nNvhkMZljHbhBMQ
         zKr+1azLhKYnxYf6bi+8uYBm64oRqEJ1V9KRk=
Received: by 10.114.89.1 with SMTP id m1mr3584739wab.126.1221235963877;
        Fri, 12 Sep 2008 09:12:43 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Fri, 12 Sep 2008 09:12:43 -0700 (PDT)
In-Reply-To: <20080912160006.GI22960@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95747>

On Fri, Sep 12, 2008 at 6:00 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Petr Baudis wrote:
>> >
>> >   this finally tripped me over and I wanted to quickly add cgit as an
>> > alternate viewing interface at repo.or.cz. [...]
>>
>> Or you can wait a little while for "smart" HTTP server, which I guess
>> also generates automatically or/and on the fly objects/info/packs and
>> info/refs required by "dumb" protocols clients (including old HTTP
>> clients).
>
> The automatic generation of objects/info/packs and info/refs is
> planned for support in the smart CGI, but it doesn't help the
> "gitweb URL is same as clone URL" concept.  For that you need your
> HTTP server to know how to issue some requests to gitweb and others
> to the smart CGI or to the filesystem.

In the case of cgit this should work transparently.

>
>> P.S. Could you please gather some statistics to compare the period
>> before and after installing "smart" HTTP server (and after smart
>> clients became widespread).
>
> Well, it would help if there was a working implementation of the
> "smart" HTTP server.  ;-)

I'll try to come up with a prototype for the smart server as part of cgit ;-)

--
larsh
