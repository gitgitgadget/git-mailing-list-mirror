From: Mr Guillaume Seren <guillaumeseren@gmail.com>
Subject: Re: When a file was locked by some program, git will work stupidly
Date: Tue, 03 Nov 2015 12:54:24 +0100
Message-ID: <144655166408.9681.9553872736815399069@t440s>
References: <CABEb4T7V=WEi-ZZm7ywOFASm+=LtAyOz53gqv-jjuzF-3=veeA@mail.gmail.com>
 <144647528273.8071.637981592426422555@t440s>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 12:54:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtaAc-0007uN-75
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 12:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbbKCLya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 06:54:30 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37301 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbbKCLy1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 06:54:27 -0500
Received: by wicfv8 with SMTP id fv8so9917757wic.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 03:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:content-transfer-encoding:from:user-agent
         :to:references:in-reply-to:message-id:subject:date;
        bh=0YyEZCc5AHUVApUHJqYvUNkJrOXhh/p6QVGnu4KyCDM=;
        b=s/yq6ZCejwyFfRN10MDUnC/Go8OwKmpR1fOacPpsfPvLAoWgDlCOxZroYUihst5NxF
         f9mnzVdjix2fq3hBF9yJGKp3Xs2yIwksrYOko9g/Q3s73TbKRvVa1emhasIRl/WZnFMj
         Nb0rv4MPDBICJ5HpJmhk4MejYi3/PGvgS1QXBaw43Fd8cu2vJdKI6v/oNSuuxVT7ermp
         WUpXQV26eV3/ah3B8DPHOBF9vIh/JX0Wjg1ANzArMsgJrsorglFBqJbq5HOa+OPgDj33
         I60XjwadNPn9ilf2hPkISClFj11JvCoTS6/rx/4uIqF46aVPRl1NRNE3OrJdgSqO+fIL
         r8Vw==
X-Received: by 10.194.206.39 with SMTP id ll7mr27356119wjc.114.1446551666469;
        Tue, 03 Nov 2015 03:54:26 -0800 (PST)
Received: from localhost (mic92-1-82-67-159-185.fbx.proxad.net. [82.67.159.185])
        by smtp.gmail.com with ESMTPSA id lb2sm27196694wjc.15.2015.11.03.03.54.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2015 03:54:25 -0800 (PST)
User-Agent: alot/0.3.6
In-Reply-To: <144647528273.8071.637981592426422555@t440s>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280792>

Quoting Mr Guillaume Seren (2015-11-02 15:41:22)
> Quoting dayong xie (2015-11-02 05:56:55)
> > To be specific
> > In my Unity project, there is a native plugin,  and plugin's extension
> > is .dll, and this plugin is
> > under git version control, when Unity is running, the plugin file will
> > be locked.
> > If i merge another branch, which contains modification of the plugin,
> > git will report error, looks
> > like:
> > error: unable to unlink old 'xxxxxxx/xxx.dll' (Permission denied)
> > This is not bad, however, the unfinished merge action will not revert
> > by git, a lot of changes
> > produced in repository.
> > usually it makes me crazy, even worse, some of my partners are not
> > good at using git.
> > Of course, this problem can be avoided by quit Unity, but not every
> > time we can remember. In
> > my opinion, git should revert the unfinished action when the error
> > occurred, not just stop.
> > 
> > -- 
> > --------------------------------------------------------------
> > Best Regards,
> > John Xie
> > --------------------------------------------------------------
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --------------------
> | Mr Guillaume Seren
> |
> | website: http://www.guillaumeseren.com/
> | github: https://github.com/GuillaumeSeren
> --------------------


--------------------
| Mr Guillaume Seren
|
| website: http://www.guillaumeseren.com/
| github: https://github.com/GuillaumeSeren
--------------------
