X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/3] Ask git for author and committer name
Date: Mon, 4 Dec 2006 22:24:52 +0000
Message-ID: <b0943d9e0612041424v42313a2r22d8fc8d1b18cb55@mail.gmail.com>
References: <20061111232322.17760.26214.stgit@localhost>
	 <20061111233046.17760.62871.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 22:25:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GqqdGlGp1I1vIRuc3qZFccNfoNMkq3imfAs+FyJ0Cz3mdE+n6T0Kb52eA5RRoAc4oLbSoyRyindlKuCGz/y/7uRYiZ0xEqbvcUjK65RS2qlZmN+uqooNJzE+0+hX0ONOjTzyICmS7QfmaMBZV9OKjyBZsp3krLZ9VF1hC5gj/Fk=
In-Reply-To: <20061111233046.17760.62871.stgit@localhost>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33262>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrMF9-0001dC-22 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 23:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937125AbWLDWYz convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 17:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937174AbWLDWYz
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 17:24:55 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:44098 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S937125AbWLDWYz convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 17:24:55 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1973423nze for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 14:24:52 -0800 (PST)
Received: by 10.64.148.8 with SMTP id v8mr13040897qbd.1165271092122; Mon, 04
 Dec 2006 14:24:52 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Mon, 4 Dec 2006 14:24:52 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 11/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Consistently do the following to get hold of default user and
> committer:
>
>   1. Use the value specified on the command line, if any.
>
>   1. Otherwise, use the value from stgitrc, if available.
>
>   2. Otherwise, ask git for the value. git will produce the value fro=
m
>      on of its config files, from environment variables, or make it
>      up. It might be asking the spirits of the dead for all we care.

I haven't forgot about this patch. I switched StGIT to the gitconfig
files and there won't be a need to invoke "git repo-config". I'll try
to modify your patch.

--=20
