From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Git, Mac OS X and German special characters
Date: Mon, 03 Oct 2011 21:48:39 +0200
Message-ID: <4E8A1197.4050708@web.de>
References: <CAO1Q+jf=RO=sE90-mQdi+=fUWH1RLM+JTubSgSVGC5uDyhU+2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Albert Zeyer <albzey@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 21:55:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAobS-0000MR-AM
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757462Ab1JCTy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 15:54:57 -0400
Received: from smtp-out11.han.skanova.net ([195.67.226.200]:40542 "EHLO
	smtp-out11.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757444Ab1JCTy4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 15:54:56 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Oct 2011 15:54:56 EDT
Received: from [192.168.209.16] (194.22.188.61) by smtp-out11.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4E79D7E2004B2729; Mon, 3 Oct 2011 21:48:51 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.22) Gecko/20110907 SUSE/3.1.14 Thunderbird/3.1.14
In-Reply-To: <CAO1Q+jf=RO=sE90-mQdi+=fUWH1RLM+JTubSgSVGC5uDyhU+2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182708>

The patch has probably not been applied, because it is not a god one.
I have been working on a better version,
but that is not 100% ready to be released.

I can post it in a couple of days,
(and yes, it does a NFD->NFC conversion in readdir() )
/Torsten
On 10/01/2011 02:44 PM, Albert Zeyer wrote:
> Hi,
>
> There are problems on MacOSX with different UTF8 encodings of
> filenames. A unicode string has multiple ways to be represented as
> UTF8 and Git treats them as different filenames. This is the actual
> bug. It should treat them all as the same filename. In some cases (as
> on MacOSX), the underlying operating system may use a normalized UTF8
> representation in some sort, i.e. change the actual UTF8 filename
> representation.
>
> Similar problems also exists in SVN, for example. This was reported
> [here](http://subversion.tigris.org/issues/show_bug.cgi?id=2464).
> There you can find also lengthy discussions about the topic. And also
> [here](http://svn.apache.org/repos/asf/subversion/trunk/notes/unicode-composition-for-filenames).
>
> This was already reported for Git earlier and there is also a patch
> for Git [here](http://lists-archives.org/git/719832-git-mac-os-x-and-german-special-characters.html).
>
> I wonder about the state of this. This hasn't been applied yet. Why?
>
> Regards,
> Albert
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
