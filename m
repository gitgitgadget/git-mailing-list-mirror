From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [RFC] mtn to git conversion script
Date: Sun, 24 Aug 2008 21:33:54 +0300
Message-ID: <94a0d4530808241133n5cc9f17arc79a1a5013187869@mail.gmail.com>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
	 <20080824131405.GJ23800@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, monotone-devel@nongnu.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 20:35:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXKQW-0005pL-IE
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 20:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYHXSd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 14:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbYHXSd4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 14:33:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:33088 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbYHXSdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 14:33:55 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1311043rvb.1
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VyQyYrYOUHW7JrQ9pAub+Cfc8/MIilKRCo9mg3j+ni8=;
        b=Pb8t/PMhoM+SpbUaYHXsIB6R9yXPM+Xq3+5QLJTdn+pTVFkx8v/P+/eEUay+2SQhdp
         N7QxQoL5ovfuhese+SqK9saQ1RXvf+KJfofrURa1UMpqZDUqOqRIeQoU8Aoy303hZIbY
         bwg3S1wefuwBQT8r8wNTeLcL7m05JG7cmtzIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=I+6QRLMdkIFoGEStTmafSqJzpzi/RZPpluNeVd4dJNFGfB4NJQUqLWd8BfAGcoYp5i
         YOSYa+BFEtx5zXMXOMV6qxSqBUAqqxif+w9RZmjFfAfrrPp5DVGBdxEWNqhTM1Ik0ZGd
         oAVOzrZo5cCQ1wuf7xHisMt4IBgcE/Snqyeu0=
Received: by 10.141.79.12 with SMTP id g12mr1711071rvl.87.1219602834995;
        Sun, 24 Aug 2008 11:33:54 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Sun, 24 Aug 2008 11:33:54 -0700 (PDT)
In-Reply-To: <20080824131405.GJ23800@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93545>

On Sun, Aug 24, 2008 at 4:14 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Sun, Aug 24, 2008 at 12:18:50PM +0300, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> What do you think? Does it makes sense to have a 'write-raw' command?
>> Or should I somehow use 'fast-import'?
>
> Yes, you should. ;-)
>
> The syntax of it is not so hard, see for example 'git fast-export
> HEAD~2..' on a git repo and you'll see.
>
> This should help a lot if you are like me, who likes to learn from
> examples.

Is it possible to create a fast-import from the index? I realize this
is not the best thing to do, but for now I would like to do that.

Best regards.

-- 
Felipe Contreras
