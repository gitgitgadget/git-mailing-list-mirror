From: Graham Hay <grahamrhay@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Wed, 18 Mar 2015 13:16:09 +0000
Message-ID: <CAABECY13XT3+rEGGtKfe3Xwg4RtzcWtpL=Nm7aivv4_35TvL0w@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
	<CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
	<CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com>
	<CAABECY2_MQWAkOu=6rR=mN=wKz-Yfzsu8o2+wb6F+h4FjBe9Mw@mail.gmail.com>
	<CACsJy8DdjDnacVGU83iUDj5Na1xxS6kNDbK2D0Apfv0LAuzDvA@mail.gmail.com>
	<CAABECY2_A83tWaqb_6YzXwr0Tv5AYVq0KW70j+EHqrx69k2P_A@mail.gmail.com>
	<CACsJy8AFi8-EgUJNr+KTOngeUaGfi_O5f_=qba08qJs1jcEj=w@mail.gmail.com>
	<CACsJy8BqA2dm8DpDrrFN4FxHG+4gnG3Q7c3kM=YmBrkuHftvog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 14:16:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYDpY-0003xW-IK
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 14:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756531AbbCRNQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 09:16:12 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34132 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958AbbCRNQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 09:16:10 -0400
Received: by oier21 with SMTP id r21so35731870oie.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z0hkyJAXyzb6ygSLFp7LZZiqy/Sc4hzo/YpU4mYaEY8=;
        b=NsJzPKShBI9SssXq5K7hC/wSmDJ2Lf9eZie9XjhEjsqI7RzrLgn6XHHJVQlJWc3oB8
         gCcDzzOAuGa7KJyGV085mK7iG0rS2glKFP3coYshZTd/bHwvMoxivNs6bwX0cCL3vQty
         0wZBlvgHTLQfaOcudICQDgn0t5w/lZ4h1gW0diejcQJMYK47ewjlCbL9sRi2WJ9nDCwK
         jj5TTkwetyz0VWT6lnyhoZBW1x3EI4MBNe4nSjvUSCrVFVadGh6ZI4gpfyxcndRWiJ7G
         0M+whotD7PsArozJ8PcGMC6fR9uOCLglYRW9bMGZGZjI9ptytFVkj099NhGLDT3syrXw
         0Hzw==
X-Received: by 10.202.98.197 with SMTP id w188mr53788565oib.6.1426684569360;
 Wed, 18 Mar 2015 06:16:09 -0700 (PDT)
Received: by 10.76.13.8 with HTTP; Wed, 18 Mar 2015 06:16:09 -0700 (PDT)
In-Reply-To: <CACsJy8BqA2dm8DpDrrFN4FxHG+4gnG3Q7c3kM=YmBrkuHftvog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265728>

I created a repo with over 1GB of images, but it works as expected
(only pushed 3 objects).

Sorry, I must have done something wrong. I put that script in
~/Applications, and checked it worked. Then I ran this:

$ GIT_TRACE=2 PATH=~/Applications:$PATH git push --set-upstream origin git-wtf
12:48:28.839026 git.c:349               trace: built-in: git 'push'
'--set-upstream' 'origin' 'git-wtf'
12:48:28.907605 run-command.c:351       trace: run_command: 'ssh'
'git@github.com' 'git-receive-pack
'\''grahamrhay/bornlucky-ios.git'\'''
12:48:30.137410 run-command.c:351       trace: run_command:
'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin'
'--delta-base-offset' '--progress'
12:48:30.138246 exec_cmd.c:130          trace: exec: 'git'
'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin'
'--delta-base-offset' '--progress'
12:48:30.144783 git.c:349               trace: built-in: git
'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin'
'--delta-base-offset' '--progress'
Counting objects: 10837, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (9301/9301), done.
Writing objects:  21% (2276/10837)

but there was nothing in /tmp/stdin. Have I missed a step? I tried
changing the tee to point to ~ in case it was permissions related.

I fear this is some Mac nonsense. I added an echo in the script, but
it only gets called for the first git incantation.


On 18 March 2015 at 12:34, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 18, 2015 at 7:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> It's quite a lot of work :) I created this script named "git" and put
>> it in $PATH to capture input for pack-objects. You'll need to update
>> "/path/to/real/git" to point to the real binary then you'll get
>> /tmp/stdin
>
> Forgot one important sentence: You need to push again using this fake
> "git" program to save data in /tmp/stdin. Also you can stop the push
> when it goes to "compressing objects" phase.
> --
> Duy
