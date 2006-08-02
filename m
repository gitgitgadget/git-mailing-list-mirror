From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's in git.git
Date: Wed, 2 Aug 2006 16:02:26 +0200
Message-ID: <81b0412b0608020702q2fd4ec83ga43714c15538f7ad@mail.gmail.com>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 16:03:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8HJI-0003dp-VB
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 16:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWHBOC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 10:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWHBOC2
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 10:02:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:48020 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750704AbWHBOC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 10:02:27 -0400
Received: by nf-out-0910.google.com with SMTP id o25so647596nfa
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 07:02:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L2W5jea/ZJCLJvWgUBC/syoOLEkRfZnc9TkIAHfryV0pC0HcqPWgxOgYt/1rJMTslJkcnNMM44XGCMoe0tlPDT0gIw7TRaG5nvjpF0CCS3TmU1n95i2xniUvlDu/3Zeza4RvxyGd6WPJ5G5zP1B1ooCxZYwKLAE/XcE4Wq/+MvU=
Received: by 10.78.107.8 with SMTP id f8mr338210huc;
        Wed, 02 Aug 2006 07:02:26 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Wed, 2 Aug 2006 07:02:26 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24648>

On 8/2/06, Junio C Hamano <junkio@cox.net> wrote:
>   - Git.pm by Pasky with help from Pavel Roskin and others.
>
>     I'd like to merge this immediately after 1.4.2, unless there
>     still are concerns about its portability (in which case
>     please help fixing them up before this hits the "master"
>     branch).

Completely broken on ActiveState Perl and cygwin. Generated Makefile
contains pathnames with backslashes and the whole file has
CRLF line endings.
