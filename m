From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 09:51:48 +0100
Message-ID: <46d6db660901230051x57be0119ge324e4e664b1c335@mail.gmail.com>
References: <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
	 <7vljt26fp9.fsf@gitster.siamese.dyndns.org>
	 <46d6db660901230008q418f3d3bsc68ca4e9d675cb36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 09:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQHmw-0003Yi-PI
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 09:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbZAWIvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 03:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbZAWIvv
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 03:51:51 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:45857 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZAWIvu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 03:51:50 -0500
Received: by ewy13 with SMTP id 13so3315170ewy.13
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 00:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M6JVn1SaN/8sArfOcVmA6zXIqh48NsvJQlFQrfL5m8M=;
        b=I+5LVQ4Whz5YEV4i+yX5qfBsV3w0eCtwogsJXSW1/tvQdyY3HxjBqZdrMgjEEC86z9
         peQFta66eQJxL732UeEIrApTeGMElqJ6XyRyNrYFcRHnJ5W/z6vceYQ2YDp+1vNCPRA0
         usgfjrRRbndjWi9C0Hmze16w87fWJM4s+2X/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N9RThDp2u7kU4hTcX0JwMr2rjyuZYp/lXZp2ZzVGh0GopHWhx4njKTS8hgn/r8qRrF
         uPxOk3nsctDLqaoaqDJm+mHaMzvZWgB2JI/uyl+fNvkcDcmi9hxnO5zzuL4pUMI+x4rY
         PS5anNlBnKFveUB8R8SVv9OGPXb8Vyx8qS3/0=
Received: by 10.103.247.14 with SMTP id z14mr1308877mur.70.1232700708669; Fri, 
	23 Jan 2009 00:51:48 -0800 (PST)
In-Reply-To: <46d6db660901230008q418f3d3bsc68ca4e9d675cb36@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106858>

On Fri, Jan 23, 2009 at 9:08 AM, Christian MICHON
<christian.michon@gmail.com> wrote:
>> A patch to butcher "git-am" to copy GIT_COMMITTER_DATE from
>> GIT_AUTHOR_DATE and export it should be trivial to implement, though.
>>
>> Perhaps something like this totally untested patch.
>>
>
> I love this idea. I'll try to test it asap. Thanks!
>

working fine! I've predictable/reproducible commits with this patch!

many thanks and kudos!

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
