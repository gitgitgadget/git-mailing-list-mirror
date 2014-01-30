From: Scott Chacon <schacon@gmail.com>
Subject: Re: Feature Request Google Authenticator Support
Date: Thu, 30 Jan 2014 09:38:53 -0800
Message-ID: <CAP2yMaKDn2bqKy8SzXj5QXXHVPwVMFDFQmn8auSMLbyF5PFUBQ@mail.gmail.com>
References: <20140130040702.GA77226@gmail.com> <CABPQNSZmvPH-J=r57_WNjq3WOS7m8dGyrj0Y84etF+8aGAMSiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Rahm <ac90b671@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 30 18:39:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8vaB-0004Gl-67
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 18:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbaA3RjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 12:39:14 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:59144 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaA3RjO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 12:39:14 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so3393438pab.37
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 09:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=q/FtYVU91yq7Khvd3MDCmgiDWozsm4jSloq/7TGxeHg=;
        b=ISyr1Ia3/aD3GBkpnjmrSjzlpO+Fz7fXRy1HnEHuH2+0A8mgXA0bNg7M+np0UQayCo
         2rKfkFxiQZ/gVf8sen5C4viVA/VkVp0wiWjH1VFEkjW55oYowmH6uKDr6lxAgN/tEyAB
         zgmHDPB0k7bNwwkI65bvFswfBHG2DWH7XKyFATj+6v55Fhh6NmEy+p2NyMv4PnwmjQ96
         xmXkJYJ+XISOpAyFpOIp06CIygPgdvsGAuFhz9fO88blaP5bnjEjK7/yzslUU9uJxf7C
         XkpPK2nfyLTpNARtIDXwwdSGEdoyO4PCY5udh6JDKvHYK1SgHoDGY2A2dkfz8dMnrGxP
         Wa7g==
X-Received: by 10.69.20.11 with SMTP id gy11mr15793754pbd.64.1391103553579;
 Thu, 30 Jan 2014 09:39:13 -0800 (PST)
Received: by 10.70.137.99 with HTTP; Thu, 30 Jan 2014 09:38:53 -0800 (PST)
In-Reply-To: <CABPQNSZmvPH-J=r57_WNjq3WOS7m8dGyrj0Y84etF+8aGAMSiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241274>

Hey,

On Thu, Jan 30, 2014 at 6:28 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Thu, Jan 30, 2014 at 5:07 AM, Max Rahm <ac90b671@gmail.com> wrote:
>> Github supports google authenticator 2-step authentication. I enabled it
>> and how can't figure out how to connect to my github account through git.
>> I've looked pretty hard in the man pages and on google and can't seem to
>> find anything on how to set up git to work with a repository with 2-step
>> verification. Here's a link to my stackoverflow question with my exact
>> problem if there's something I'm missing.
>>
>> http://stackoverflow.com/questions/21447137/git-github-not-working-with-google-authenticator-osx
>>
>> As far as I can tell the feature is not supported. I'd like to be able to
>> use the 2-step authentication but obviously I'd like to be able to push my
>> code :D
>
> This sounds like a question for the GitHub support rather than the Git
> community.

Erik is right, for any GitHub questions, emailing support@github.com
is way better than using this list. The answer to your question,
however, is that you have to use a personal access token:

https://help.github.com/articles/providing-your-2fa-security-code#through-the-command-line

You can generate one from this page, in the "Personal Access Tokens"
section: https://github.com/settings/applications

Thanks!
