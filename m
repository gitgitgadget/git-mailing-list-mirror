From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC] separate .git from working directory
Date: Wed, 11 Oct 2006 16:41:03 +0200
Message-ID: <81b0412b0610110741q698e6512xc8a4188bac0294a4@mail.gmail.com>
References: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 16:52:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXfGh-0007ZR-Kz
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 16:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWJKOlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 10:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWJKOlI
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 10:41:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:3647 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030434AbWJKOlF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 10:41:05 -0400
Received: by ug-out-1314.google.com with SMTP id o38so120421ugd
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 07:41:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uY7VfKl2d6Z5Ve58Q4ePmH29HKPc0XyJjuZFYP+JE0LeUPqTKyrD3PuOst/ow3mcr9NfHxyI4Zq4aJYYBV9ZuGGn6F+9K/5j2VNkLdbQDjGV3HzJAfvUZ11jvOjEnDZOKJeN1C6TUgpm4WB0Tp83qHGpONmolvVibHOje+4Vyzg=
Received: by 10.78.203.15 with SMTP id a15mr905132hug;
        Wed, 11 Oct 2006 07:41:03 -0700 (PDT)
Received: by 10.78.115.8 with HTTP; Wed, 11 Oct 2006 07:41:03 -0700 (PDT)
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
In-Reply-To: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28716>

On 10/11/06, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Hi,
> I was thinking about this while reading subproject thread. In a simple
> case, I have a repo A located at ~/project-a and another repo B
> located at ~/project-a/some/dir/project-b. With this setup, command
> "find" and other directory-recursive commands will run horribly from
> ~/project-a when they go inside project-b/.git (no I don't want to
> repack -d everytime I want to find something).
> I propose to move project-b/.git outside and place a file, say
> .gitdir, in project-b directory. git-sh-setup and setup_git_directory

You can even leave the name as is: it is impossible to misunderstand
a file for directory (except on AIX). Or put the information in extended
attributes.
