From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: git with large files...
Date: Sat, 21 Jul 2012 09:11:36 +0200
Message-ID: <CA+EOSBk8XjA5=BO_kVOmfCPT-n2vKV1rbqUHnOnGi-ORF7wKLw@mail.gmail.com>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com>
	<86fw8mf3gp.fsf@red.stonehenge.com>
	<CACPiFC+a=46n-igTUBSDdpgDQyL4cz5vrcpurNBSsb+D1c0UnA@mail.gmail.com>
	<CAJDDKr5vZz_DepYKvdu34G60fmm8V_Sv8FU+J6O-DLoum07+jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: David Aguilar <davvid@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Darek Bridges <darek.bridges@me.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 21 09:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsTqv-0001LR-0N
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 09:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab2GUHLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 03:11:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63758 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab2GUHLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 03:11:37 -0400
Received: by yhmm54 with SMTP id m54so4590251yhm.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 00:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=ghpCTZZIizZnM9FVFOGC9KUFiMDUdtxB/SQxB0A3ifA=;
        b=fkxhWO9uacrNgjOTRIYUOdyTaajCTfky4zlzhykk+k65DvFNjJVtYtoHigoxCJLwKt
         +Z0UZ7p55OEg9tiEsrA+Hm86bCWL7e4sJPLE/V5h2TSIm5xKpmzxeUVy+wedntPA75Iw
         PCz83nfE9dg8TKG1fRYeksU3D5NsKhr+Z1EpdycBZf563hHxmwkl9OSYhRt4OuV0j8Ja
         4FbZfj5lbocrN3IN6nlOAqJ3VtT+yQIzlO0qT31uTEr6IalFZAsSnNLMmMWUfoDwSBAx
         vOQp2BRuVCX8BMEGcm5jl/jsbrvLStp3+8bH+k/Us+Hziv9s/ic20U5jPoOrL75HXjoA
         5Ttw==
Received: by 10.66.78.42 with SMTP id y10mr16694136paw.31.1342854696629; Sat,
 21 Jul 2012 00:11:36 -0700 (PDT)
Received: by 10.66.157.97 with HTTP; Sat, 21 Jul 2012 00:11:36 -0700 (PDT)
In-Reply-To: <CAJDDKr5vZz_DepYKvdu34G60fmm8V_Sv8FU+J6O-DLoum07+jA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201804>

Well, many folks use puppet in serverless configuration pushing the
manifest from a central git server via cron and applying locally the
configuration fetched. In this sense git IS used for deployement. And,
for a configuration management system as puppet this could be a
sensible thing to do - reduce load, scalability ecc.

Best regards

2012/7/21, David Aguilar <davvid@gmail.com>:
> On Fri, Jul 20, 2012 at 4:28 PM, Martin Langhoff
> <martin.langhoff@gmail.com> wrote:
>> On Fri, Jul 20, 2012 at 6:54 PM, Randal L. Schwartz
>> <merlyn@stonehenge.com> wrote:
>>>>>>>> "Darek" == Darek Bridges <darek.bridges@me.com> writes:
>>>
>>> Darek> I use git for many things, but I am trying to work out the
>>> Darek> workflow to use git for deployment.
>>>
>>> Don't.
>>
>> Heh. Best to keep in mind that it just doesn't work very well.
>> git-bigfiles, git-annex might help you, but look at the docs and
>> caveats carefully.
>>
>> Perhaps use rsync, unison work better for you.
>
> I'm not sure if it was the "big files" part that Randal was responding
> to.  IIUC it was the "using git for deployment" part.
>
> Packaging tools (Makefiles, .rpm, .deb, etc) are a better suited for
> deploying software.
> --
> David
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Inviato dal mio dispositivo mobile
