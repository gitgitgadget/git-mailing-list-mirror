From: Jacob Kroon <jacob.kroon@gmail.com>
Subject: Re: Fixing author/email fields in commit messages
Date: Mon, 20 Feb 2006 00:33:50 +0100
Message-ID: <43F9005E.30901@gmail.com>
References: <43F8BCB1.2010701@gmail.com> <Pine.LNX.4.63.0602191634480.6352@gheavc.wnzcbav.cig> <Pine.LNX.4.63.0602191651340.6352@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 00:27:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAxxh-0005Gf-RM
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 00:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWBSX10 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 18:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWBSX10
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 18:27:26 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:61074 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932334AbWBSX10 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 18:27:26 -0500
Received: by xproxy.gmail.com with SMTP id i29so564420wxd
        for <git@vger.kernel.org>; Sun, 19 Feb 2006 15:27:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=J0I392iRqgmiZJiUfZXbTl5sahJeggjcRJVyV+WlH3Lyeo2BNtYi5oU+hsejJ0ClxgYNHEybbOeESrOjbmzL/SzdR8JmdvYkTFAzvcqz3t4qL3LEP8c5OarixAyGegsWkKH6+VRcjkZluhsl+yLUCvklH8XfQfvwr8ZAT2nPqeA=
Received: by 10.70.76.1 with SMTP id y1mr2640800wxa;
        Sun, 19 Feb 2006 15:27:25 -0800 (PST)
Received: from ?192.168.0.3? ( [83.249.217.43])
        by mx.gmail.com with ESMTP id h19sm4293447wxd.2006.02.19.15.27.23;
        Sun, 19 Feb 2006 15:27:24 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jon Nelson <jnelson-git@jamponi.net>
In-Reply-To: <Pine.LNX.4.63.0602191651340.6352@gheavc.wnzcbav.cig>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16456>

Jon Nelson wrote:

>>I modified git-convert-objects to perform just that task.
>>I'll see if I can dig it up (I'm not able to do so right now).
>>    
>>
>
>Attached. Notes:
>
>1. it's ugly
>2. it's indented funny
>3. it didn't seem to break anything for me, but no guarantees
>4. it probably smells of elderberries
>5. set your GIT_* environment up properly first or you'll wonder why it 
>doesn't work like I did.
>
>  
>
Hi Jon,

I've applied your patch to the latest git sources, and it compiles, but 
I'm not quite sure how to
invoke the command. I've setup GIT_* env. variables, and 
git-convert-objects needs a sha1 identifier.
I've tried passing "HEAD", and some other commit id's, but they don't 
seem to make any difference.
Am I doing things right ? How exactly do I invoke the command to clean 
up the commit messages ?

At least I don't get any error messages.

//Jacob
