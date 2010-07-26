From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git pull (Re: need advice on usage patterns)
Date: Mon, 26 Jul 2010 09:17:52 -0500
Message-ID: <20100726141752.GA1745@burratino>
References: <AANLkTi=g2YNQtiH7+xzqWeoOV6p5r+Nwtt2kkCd3u6JN@mail.gmail.com>
 <20100726033634.GA30877@burratino>
 <AANLkTikPHARaosHLwaKUqL12va4F7O3WMp1I4LIpu7Mp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 16:19:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdOWQ-0003Tp-UC
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 16:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188Ab0GZOTK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 10:19:10 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35827 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab0GZOTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 10:19:08 -0400
Received: by qwh6 with SMTP id 6so109208qwh.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 07:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C9a04vUxCyaN65anQy5oyHGHQoL8uLJx232slu6bkdo=;
        b=EsNpMJiPfqpHTN1Q2DFdh5S1Rz8ORZM61brKfeZ+CwZPYplruA8DLQ5ZM5SMMUhFvi
         5c7otnZnIWfQJqq70S9Sj3jIRgVm/Ev+A0f/k3+wW+9dgJzyM67+ZwFSjRCIfgDLnh4B
         yGas8Y+ZdSbrDian7H1+zfjU8QNmvEkAjJhDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UzHxsrqv4dtYaBnq1ECf+0FhVtJSGe7en4zQNgFDMiL2Zplsl+bnnqdtznLXr+vKG3
         KiQincwSTJE8LKU6oC2NJUocQMHmwbkwgk/YCTBCFrMZjoxFffxJJVkwJZK0Y4VVw1AZ
         5G+hwWmriR+DjL6hl5Mz/Z1knGu5Lrm+T7sxc=
Received: by 10.220.187.5 with SMTP id cu5mr604824vcb.0.1280153939135;
        Mon, 26 Jul 2010 07:18:59 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b5sm789156vcy.33.2010.07.26.07.18.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 07:18:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikPHARaosHLwaKUqL12va4F7O3WMp1I4LIpu7Mp@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151841>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Mon, Jul 26, 2010 at 03:36, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> -'git pull' <options> <repository> <refspec>...
>> +'git pull' <options> <repository> <branch>...
>
> Wasn't it "refspec" because git-pull can take args like
> "refs/remotes/origin/*:refs/heads/*", not just branch names?

Yes, by abuse of language that might be called the noble lie (or
something; notice later where it says "<branch> can be an arbitrary
refspec).  Better ways to achieve the same effect would be welcome.
