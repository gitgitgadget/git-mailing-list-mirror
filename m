From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v2 1/3] git help: group common commands by theme
Date: Sun, 03 May 2015 15:57:58 +0200
Message-ID: <55462966.1030408@gmail.com>
References: <554405D5.9080702@gmail.com> <xmqqk2wqwg9f.fsf@gitster.dls.corp.google.com> <55462895.8080108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 03 15:58:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YouPI-0004BW-Ps
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 15:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbbECN6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 09:58:04 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36431 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbbECN6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 09:58:01 -0400
Received: by wizk4 with SMTP id k4so96083325wiz.1
        for <git@vger.kernel.org>; Sun, 03 May 2015 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=zOAfPhWMSxcJsMaBlAqLDeHxBkL37xL0lfZeB757hCQ=;
        b=gQiHqNdnuywlYxkx6JBf5fy3ehRW1YBIvFi3Ev4otFL3kvvN4mJV8IceV0bvOMDKGI
         6SK9Dr6RwdxyGAbb0yX6gzHpSNMgyUBaahjmDvN/osMZz06Vnj71QoXQW5T+ycf/pqwi
         XbSTrPfjlcxFtrGXsbDTw3zR6wEQPHh34SRrrQLx97Ziztv7l4ulBmMimeAiVArftw7/
         9/3dPJeljdJHRbfMuyE37rQEbLKmJ/p7iZFHGx9z3AZgamO4fH2WMn8mi1MC7Q5N4Rqf
         8ZyqVyconusv0QP1rUQu/6bPQYt5JtuGd8cab36+NPogCz9Jza4AtRLGhlehbV/r94u5
         HEqQ==
X-Received: by 10.180.100.227 with SMTP id fb3mr11813455wib.90.1430661480260;
        Sun, 03 May 2015 06:58:00 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id gs7sm6764313wib.10.2015.05.03.06.57.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2015 06:57:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <55462895.8080108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268261>

The formatting in the previous email was a bit off. Here is the proper one.

The most commonly used git commands are:
    * starting a working area:
       clone      Clone a repository into a new directory
       init       Create an empty Git repository or reinitialize an existing one

    * examining the history and state:
       diff       Show changes between commits, commit and working tree, etc
       log        Show commit logs
       show       Show various types of objects
       status     Show the working tree status
       bisect     Find by binary search the change that introduced a bug
       grep       Print lines matching a pattern

    * working on the current change:
       add        Add file contents to the index
       checkout   Checkout a branch or paths to the working tree
       reset      Reset current HEAD to the specified state
       rm         Remove files from the working tree and from the index
       mv         Move or rename a file, a directory, or a symlink

    * growing, marking and tweaking your history:
       commit     Record changes to the repository
       rebase     Forward-port local commits to the updated upstream head
       tag        Create, list, delete or verify a tag object signed with GPG

    * working with others:
       fetch      Download objects and refs from another repository
       pull       Fetch from and integrate with another repository or a local branch
       push       Update remote refs along with associated objects

    * branching and merging histories:
       branch     List, create, or delete branches
       merge      Join two or more development histories together
