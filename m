From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: git-describe doesn't show the most recent tag
Date: Sun, 28 Sep 2008 17:29:21 +0300
Message-ID: <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com>
	 <20080928135526.GG5302@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Sep 28 16:30:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjxI8-0006KR-Ay
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 16:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbYI1O3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 10:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbYI1O3X
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 10:29:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:23591 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbYI1O3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 10:29:22 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1812074rvb.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WBTMzD2bmNEMUrjfUN+Y6dZ62exQNt3YaAOzZodwsZQ=;
        b=Dro+OOiTBSZLRf1rpyzJ9FYjoaxkI789jJ8e/Wkrem07jgf+T2iwSoTLRJ8+cRKUws
         PkrvQ4sjW97WJ4DIv8Rblc6oIwFommMkWv+r3CDy880U5gX9EUQ8BqBBrHRwLiSnE4Wu
         UKS0Ov5ZxD1TMXRQ3J09C/hUz/huYZUpuvZS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cskfBCs9AZkfWaFh5ziA3/PlTbf/KC8Azv1NtPpg3doI2Sh3X3NJiksBzdkMb1kSQS
         f4JMDVFu7hP5oIbwNqen0tKV82qj2mkr7p/FQILPRaulXRLvsIu6O4omTLTnWKuSIcYF
         ODEO3RU2jwZeDSYm/V4pczqEruahIm44J32U4=
Received: by 10.141.162.6 with SMTP id p6mr1862250rvo.121.1222612161755;
        Sun, 28 Sep 2008 07:29:21 -0700 (PDT)
Received: by 10.141.91.21 with HTTP; Sun, 28 Sep 2008 07:29:21 -0700 (PDT)
In-Reply-To: <20080928135526.GG5302@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96968>

On Sun, Sep 28, 2008 at 4:55 PM, Pierre Habouzit <madcoder@debian.org> wrote:
> On Sun, Sep 28, 2008 at 01:48:42PM +0000, Erez Zilber wrote:
>> Why is this happening?
>
>       --tags
>           Instead of using only the annotated tags, use any tag found in
>           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>           .git/refs/tags.
>

I'm not sure that I understand the difference between tags and annotated tags.

Anyway, if I move to the master branch, I see the following tags:

[erez.zilber@erez-lx:/tmp/open-iscsi.git]$ ls .git/refs/tags/
2.0-868-rc1  2.0-869  2.0-869.1  2.0-869.2  2.0-869-rc2  2.0-869-rc3
2.0-869-rc4  2.0-870-rc1
[erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-tag
2.0-868-rc1
2.0-869
2.0-869-rc2
2.0-869-rc3
2.0-869-rc4
2.0-869.1
2.0-869.2
2.0-870-rc1

However:
[erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-describe --tags
2.0-868-rc1-81-g31c9d42

I was expecting to see 2.0-870-rc1 here.

Erez
