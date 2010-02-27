From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Error on push (unable to create temporary sha1 filename)
Date: Sat, 27 Feb 2010 21:01:05 +0800
Message-ID: <be6fef0d1002270501j124540c5g36a6a97142f4a7fc@mail.gmail.com>
References: <8dacd7b31002231311q46c1c3b9o63c57fabe696f2ea@mail.gmail.com>
	 <be6fef0d1002231654r4fe08149qa937bbd9cc83d6a2@mail.gmail.com>
	 <8dacd7b31002270438ve59e43djd44e2866b697d3ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jan Niklas Hasse <jhasse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 14:01:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlMIP-0007gL-HT
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 14:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968297Ab0B0NBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 08:01:09 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:63434 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968281Ab0B0NBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 08:01:06 -0500
Received: by iwn12 with SMTP id 12so1041077iwn.21
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 05:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=G15QzaZdNjQLEEK6517R3dLincg77kfzmbjQsYrPYdk=;
        b=AMYmx2JOlTv2T6YmTbsxZYcNKjg3fGhzr4VPR4J+u1pydWtWV62x4W1EbY5xCOddHt
         w+f7j5sE6OXcANZntkFD+K2H7HPU/Dj9fz0X+ln57KbcjOeDG27jFvfWnSKOhT+ljxpE
         j+dYJcJPKXbP/I2ptlE8f9w/DDvKbApAfpBR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SYkdesGZBAnkKKlXQKpuCa45MGwP07Jhs/vdpScL1AnVq5Rcx6cn4dcCU3La7gXSeO
         mG3i3CWP9g5vOgQ11y20/Ygb9s0O74AB/BCpj5R7Bxs0qFxXJLMp2AYDGNXtVAjhBpJm
         1KIav392vbidI9euXeHDfzMv/GUYiThLWx66I=
Received: by 10.231.166.68 with SMTP id l4mr410265iby.40.1267275665631; Sat, 
	27 Feb 2010 05:01:05 -0800 (PST)
In-Reply-To: <8dacd7b31002270438ve59e43djd44e2866b697d3ab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141204>

Hi,

On Sat, Feb 27, 2010 at 8:38 PM, Jan Niklas Hasse <jhasse@gmail.com> wrote:
> The output of git gc looks like this:
>
> Counting objects: 102, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (52/52), done.
> Writing objects: 100% (102/102), done.
> Total 102 (delta 34), reused 102 (delta 34)
>
> But still the same error message when trying to push :(

running out of ideas. Could you post the output of "ls -lR .git/objects" ?

-- 
Cheers,
Ray Chuan
