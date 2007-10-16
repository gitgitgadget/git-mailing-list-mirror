From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Is there any plan to support partial checkout or submoudule improvement?
Date: Tue, 16 Oct 2007 12:50:34 +0200
Message-ID: <8c5c35580710160350h53a7b5c4k374067372d4aac1d@mail.gmail.com>
References: <8c5c35580710160142x1f699208gfc226072a27e997a@mail.gmail.com>
	 <20071016095622.CE14F7E6F@mail.kooxoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: franky <yinping@kooxoo.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 12:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihk0c-0002yP-DJ
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 12:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757788AbXJPKug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 06:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757621AbXJPKug
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 06:50:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:60720 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757403AbXJPKuf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 06:50:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2335333wah
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MdaiDL5Fj5pxywr30RjkK5MmJT/Diu7XVNo2HNA3q5c=;
        b=HnsnOOPkYcvZ7zqe5baJLIDbnNBV3DJa2yStjo/VDstQnDxIAs10gBQ8M1oL5XmLYq0z6Ejw+6GFSFaeEU1xywdpLGsVNOblJWg0dXkuTD6MHvBlbEv10ukWRJPh1grbTePRlh/dYHG6TKBIEAAlUXDRVvKN6i16SL9upp9cKl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=muFGIhRSvagcAYowMM5tzSUbtD37jiBQ2w6ydnghxJG+yW+mdBjcOF966rKoG4ubwYvd4ExRgN3J8s9x7yfU+0XbflkSPxeqS6Un9SJUrDhDyT3IcYoB2V29OBqmPdBBzrRZfQN7P3fHJ+dVoNwzcynjDaQsopQSdMOvLEl/8jE=
Received: by 10.114.157.1 with SMTP id f1mr8294256wae.1192531834307;
        Tue, 16 Oct 2007 03:50:34 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Tue, 16 Oct 2007 03:50:34 -0700 (PDT)
In-Reply-To: <20071016095622.CE14F7E6F@mail.kooxoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61142>

On 10/16/07, franky <yinping@kooxoo.com> wrote:
> lars said:
> > $ git archive --remote=<repo> <revspec> <path> | tar -x
>
> I can't know deployment version easily

The <revspec> can be a tag. So you can easily create a wrapper script
to allow such things as

$ ./deploy.sh v1.2.3
$ ./deploy.sh HEAD
$ ./deploy.sh master
$ ./deploy.sh <sha1>

(note: for this to work with the git:// protocol, git-daemon needs
--enable=upload-archive)

-- 
larsh
