From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 21:35:02 -0500
Message-ID: <5359c9d612298_771c15f72f02a@nysa.notmuch>
References: <20140422213039.GB21043@thunk.org>
 <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch>
 <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 25 04:45:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdW8t-0003uG-VU
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 04:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbaDYCpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 22:45:32 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:45021 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbaDYCpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 22:45:31 -0400
Received: by mail-oa0-f42.google.com with SMTP id i4so3611620oah.1
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 19:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=5YxAKdFvKX54tRu7xOKBXAsZAhctdofCIixzy8VsMxE=;
        b=f4F6eYnbHVCpzT+jMfpaanDeAYnPhaJgzKjkn1HT6KfCOq9Icawvqha9Kxt+mB5Hjt
         86eKZLae1gYUCx4R+eXiu9T8g2tTeTD9/aCx0zT1MHfp/Ae5MMfj7l1BUGUT1KUaAFZI
         Dv7WmZOM1DDuQKf05w5tk7ReR86MRVHbxyaE2ZYbcen9/hd+Am0T3blJwF6UYojdw/1Z
         wRBvaORyvgYcKtaZQWIKjTV47yWcuFcT77BzKGsLT1INDGb2IgJCmc+RLZWfa3tnwpbK
         K2cdXbC3cSvnDAce/c5r+cTbFtMFTh9Sm937rQSWgSruzetNLAiSG7+6l/wQ7fRJXTud
         33rQ==
X-Received: by 10.60.48.106 with SMTP id k10mr4697190oen.20.1398393930983;
        Thu, 24 Apr 2014 19:45:30 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id te6sm25697553oec.2.2014.04.24.19.45.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 19:45:29 -0700 (PDT)
In-Reply-To: <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247029>

Javier Domingo Cansino wrote:
> Felipe's
> =======
> 
> = The publish tracking branch =
> I still have problems getting upstream branches correctly configured
> as to have this introduced, anyway, I suppose it's optional, so
> nothing to add on that.

I did so too, until I patch `git branch -v` to be useful.

> = Reject non-fast-forward pulls by default =

> Not having this introduced yet allows newbie people to use git with
> just 4 commands, without bothering around with fetch and merge and so.

I don't understand what you are trying to say. There is no change for those
people, when the pull fails they would be told to use `git pull --merge` if not
sure.

> = Use "stage" instead of "index" =
> Totally agree with this.
> 
> = Default aliases =
> I hate aliases, make scripts more difficult to read and understand.

You are assuming that everyone will start to use aliases in scripts, which is
not going to happen enough to be a problem.

Try to find svn or hg scripts with aliases, let's see how many you find.

> Mine
> ====
> I have taught (or tried to) a lot of people Git. And this is some of
> the stuff I have seen they have difficulties with:
> - Remembering the commands, for example, remembering add, commit push
> and pull, which I think we can all agree is the most core and simple
> combination of Git commands.
> - What command comes for what they need. If I want to share
> everything, what should I do?
> - Most of them, have real difficulties on remembering the flows. There
> are too many commands for the start.
> 
> I wouldn't nevertheless suppress any of them, I would rather do a tuto
> on-the-go.

I think you are on the right track but the solution is not to shrug shoulders.
We should acknowledge there are serious problems with the interface, list them,
and try to fix them. One example is `git add $tracked_file` being wrong, it
should be `git stage $tracked_file`.

The real problem is that the core developers of Git don't acknowledge these
user-interface issues, according the them the interface doesn't require any
major changes. Which goes contrary to what most of the world believes.

-- 
Felipe Contreras
