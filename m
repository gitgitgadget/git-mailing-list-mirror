From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: finding deleted file names
Date: Mon, 7 Jul 2008 10:11:05 +0930
Message-ID: <93c3eada0807061741s33e6da08lc1a8b04700d3a0dc@mail.gmail.com>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
	 <237967ef0807021812r3ccbfbacg2cb6b12358d2ee2e@mail.gmail.com>
	 <93c3eada0807021945la3e565csc50eed4b14feb9c3@mail.gmail.com>
	 <20080703104233.GA26162@sigill.intra.peff.net>
	 <93c3eada0807032345r2ff59d69kca42bc9ea7782f31@mail.gmail.com>
	 <7v1w2aw2lt.fsf@gitster.siamese.dyndns.org>
	 <93c3eada0807052154j9de9074s8c5625fb7507b96e@mail.gmail.com>
	 <7v63rjpp4s.fsf@gitster.siamese.dyndns.org>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Mikael Magnusson" <mikachu@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 02:42:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFenv-0004Qc-N1
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 02:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384AbYGGAlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 20:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757373AbYGGAlH
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 20:41:07 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:59726 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222AbYGGAlG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 20:41:06 -0400
Received: by an-out-0708.google.com with SMTP id d40so373668and.103
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 17:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kYEoEiO93a5DRyWsElr6RxOuQA52MaXDQinwz2xDleQ=;
        b=it6FH1D/5Q+mzt5LSsJ1PPh31SiFDtqIOVulh7fOx6QrZMcdt5+CofuxTKMpciXGzT
         fR2JF355lqIQfFipf7oXVrM17Y3f67qQsHFaDwNArUM+bUHMhrbdt+GkXGtEsspQWWgd
         ebP1zpBgSrXG10UMoZfmuAo41FBAnQxa99oGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=iUu48MnzWJ5E/ED491kEeAp6jQNdJRvSXP1knJhDXXPWepzU9ZwejqhGoQNwfws+y5
         j/thz+leMh4YZnZT6OMXlMatyykWCmejpA6/5VRWPdk3ARtyToGnMcZC3kF45T6wGh23
         CAv80hbUJSWCPp+jxgBhDz+LyayauFo+1ajCM=
Received: by 10.100.250.12 with SMTP id x12mr2395908anh.93.1215391265072;
        Sun, 06 Jul 2008 17:41:05 -0700 (PDT)
Received: by 10.100.232.5 with HTTP; Sun, 6 Jul 2008 17:41:05 -0700 (PDT)
In-Reply-To: <7v63rjpp4s.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87569>

On Sun, Jul 6, 2008 at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Geoff Russell" <geoffrey.russell@gmail.com> writes:
>
>> On 7/4/08, Junio C Hamano <gitster@pobox.com> wrote:
>>> "Geoff Russell" <geoffrey.russell@gmail.com> writes:
>>>
>>>  > ... I've made a bunch of changes to a repository, a few weeks later I
>>>
>>> > figure I've deleted a file I need but am not really sure of its name. So
>>>  > I want to list the files that I've deleted during the past few weeks.
>>>
>>>
>>> $ git log --pretty=oneline --diff-filter=D --name-only -M --since=90.days
>>
>> This is good, but on my version 1.5.5.1, is giving the commit-ids +
>> comments as well
>> as the names.
>
> Oh, I very much intended to give them, as --since=90.days is very broad
> that you would want to know which exact commit to learn when the found
> change was made anyway.
>

That's fine, the --name-only confused me, but I understand what is
happening now.

Geoff.


-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
