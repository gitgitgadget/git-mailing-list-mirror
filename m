X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/3] Ask git for author and committer name
Date: Tue, 5 Dec 2006 09:17:15 +0000
Message-ID: <b0943d9e0612050117i3293f999m3ebf3278aacb8ce4@mail.gmail.com>
References: <20061111232322.17760.26214.stgit@localhost>
	 <20061111233046.17760.62871.stgit@localhost>
	 <b0943d9e0612041424v42313a2r22d8fc8d1b18cb55@mail.gmail.com>
	 <20061205091017.GB25002@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 5 Dec 2006 09:17:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eepNmHuWXsAslSyvGhqIWcutgHXeOkGhz66gFae41F5D6KSlBBQco/SgkDkUU7RZe9HL0EyNfHrfiOqsrlkWneEWJzX0W+Hqh2QtZXmn0fj21qal1zzYx7LuUv8mFe3WavJCdZUpiBn3wam/jV4nIxJS7cJe0TagZ4y17CEo/Zg=
In-Reply-To: <20061205091017.GB25002@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33328>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrWQU-0008E8-In for gcvg-git@gmane.org; Tue, 05 Dec
 2006 10:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968153AbWLEJRT convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006 04:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968154AbWLEJRT
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 04:17:19 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:14710 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S968153AbWLEJRS convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 04:17:18 -0500
Received: by nz-out-0102.google.com with SMTP id s1so2048794nze for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 01:17:15 -0800 (PST)
Received: by 10.64.10.2 with SMTP id 2mr349445qbj.1165310235188; Tue, 05 Dec
 2006 01:17:15 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Tue, 5 Dec 2006 01:17:15 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 05/12/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-12-04 22:24:52 +0000, Catalin Marinas wrote:
> > I haven't forgot about this patch. I switched StGIT to the gitconfi=
g
> > files and there won't be a need to invoke "git repo-config". I'll
> > try to modify your patch.
>
> Ah, nice. But will you still honor the git author and committer
> environment variables that way?

Yes. My understanding is that the environment variables would override
the config options. I would also keep the [stgit] user information for
backward compatibility (there are people who use StGIT exclusively and
don't want to dig into GIT configs).

--=20
