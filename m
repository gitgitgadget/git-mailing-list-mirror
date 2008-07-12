From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Sat, 12 Jul 2008 10:07:15 +0200
Message-ID: <03AA6CC0-B64C-4FB8-98F1-79E3E7128713@zib.de>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de> <alpine.DEB.1.00.0807111930160.8950@racer> <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org> <alpine.DEB.1.00.0807112037220.8950@racer> <0E93411E-745C-4858-999E-F0B7487B48B1@zib.de> <alpine.DEB.1.00.0807112226190.8950@racer>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Sixt <johannes.sixt@telecom.at>, Junio C Hamano <gitster@pobox.com>, msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Jul 12 10:08:09 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.25])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHa9I-0005bb-VX
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2008 10:08:09 +0200
Received: by yw-out-2122.google.com with SMTP id 8so3874105yws.63
        for <gcvm-msysgit@m.gmane.org>; Sat, 12 Jul 2008 01:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=HxVYLEp6xFiDlC6DJdnTKJXJrwAEL462VjJBDqCJggs=;
        b=QgJECihf7pvHplwqScUFIJ9JzlMr2KT4y0i7C72vfWjYmnK+l9eThWJIHP5TSi6Rpg
         1CnGpbDGpIQrmf7yj3C9Lu2BnXrDJRddupqU+3nOdndJf3EOMv4DIsJkybaqvrFDkrSs
         hRLf6gayKydd+MKWUTDB5TeKzCTpNU2JaCy98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=gibdlzufzXeiE9F3/gCHYUqDgUyUwIz+qUxcL5ze6t+2+q4hHeJB3wMH/upb9avsuE
         5GkVBgVirYY3Bd7zfvJIt3SQ39zd/qPpj52OCDlfX+qt2GMDPzj2mfyj6l4ubKA8SW07
         qdJfB8pI775l/QTpgtsr3Uuxl9GpL+vqXa2cw=
Received: by 10.114.25.3 with SMTP id 3mr748036way.22.1215850028751;
        Sat, 12 Jul 2008 01:07:08 -0700 (PDT)
Received: by 10.107.113.4 with SMTP id q4gr2692prm.0;
	Sat, 12 Jul 2008 01:07:08 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.70.15 with SMTP id s15mr13576934aga.27.1215850025674; Sat, 12 Jul 2008 01:07:05 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si1808410yxd.0.2008.07.12.01.07.04; Sat, 12 Jul 2008 01:07:05 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6C86spi016462; Sat, 12 Jul 2008 10:06:59 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db95b87.pool.einsundeins.de [77.185.91.135]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6C86mGg014979 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Sat, 12 Jul 2008 10:06:49 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807112226190.8950@racer>
X-Mailer: Apple Mail (2.926)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88226>



On Jul 11, 2008, at 11:38 PM, Johannes Schindelin wrote:

>> Another example is the discussion about GIT_EXEC_PATH, see
>>
>> http://thread.gmane.org/gmane.comp.version-control.msysgit/2633
>
> This is a particularly good example that does not matter for Linux,
> MacOSX, Solaris or the BSDs (Git's principal platforms!) at all.
>
> And once this patch hits git@vger, it is still visible to other  
> platforms.

Hmm... on Mac OS X, applications can typically be moved freely in the
filesystem.  Installing such an application means no more than mounting
a disk image that contains a directory that you can drag and drop to any
location in the filesystem.  You do not need administrative rights to do
this.

For command line programs, like git, moving the installation freely is
less common.  Installers often place everything in /usr/local/ (they
need administrative rights to do so).  But there are other examples too.
For example, I have other vims installed in addition to the system's  
vim:

   /Applications/vim70/Vim.app
   /Applications/MacVim-snapshot-24/mvim

that I can freely move around.

The result of our discussion on GIT_EXEC_PATH might be useful to achieve
something similar for git -- although I think that it is not an  
essential
feature.

	Steffen
