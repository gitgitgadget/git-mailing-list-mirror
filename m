From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: large files and low memory
Date: Tue, 5 Oct 2010 08:47:44 -0500
Message-ID: <20101005134744.GB12797@burratino>
References: <20101004092046.GA4382@nibiru.local>
 <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <20101004185854.GA6466@burratino>
 <20101005005715.GB2768@nibiru.local>
 <20101005011009.GD9994@burratino>
 <20101005073505.GA14821@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Enrico Weigelt <weigelt@metux.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 15:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P37vm-0004mi-AO
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 15:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab0JENvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 09:51:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51146 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab0JENvk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 09:51:40 -0400
Received: by iwn5 with SMTP id 5so8351621iwn.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uMAFHNq6hL7NlP3rqwb4rxHiAXmkEN8IiuaPiOBcwSs=;
        b=hhTznpLcFKwg+1qtPjHGRpIheLXA1LrXyx/r4sZEXEHhXjJyUxbAOo5e4NbCeSL12m
         bUYY6WGBCm70c+ftp1eKiCsQOEKVLDAzCymv9B7eM+fMRokhjENi4OY7Lq+WLfBJbvxt
         p9j3u91mtTNJt8pvSwngdRv0eSIPM3FRnBWHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eKWUkjpiT7+TNZJ24khbX0QihriLJEY4ADzezfSE0ykKibA8vIyP66y9+niB8/BD65
         hAM7omI5mZM++lV5vlADie7R3+yNX0Qhk7mg2CeVTW8SuyJnIpKHKlqDBEZslOf9JZ8S
         SHv8DqP0/GxFMFCvJ5F8UGG/Qtnmq44mBx9jQ=
Received: by 10.231.194.219 with SMTP id dz27mr9998718ibb.104.1286286665993;
        Tue, 05 Oct 2010 06:51:05 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id u6sm4640003ibd.0.2010.10.05.06.51.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 06:51:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101005073505.GA14821@nibiru.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158198>

Enrico Weigelt wrote:
> * Jonathan Nieder <jrnieder@gmail.com> wrote:

>> What platform are you on? 
>
> GNU/Linux. glibc-2.25

Hmm, I've heard of glib 2.25 but never glibc 2.25. :)

 $ /lib/libc.so.6 | head -1
 GNU C Library (Debian EGLIBC 2.11.2-6) stable release version 2.11.2, by Roland McGrath et al.
