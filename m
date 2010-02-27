From: Jan Niklas Hasse <jhasse@gmail.com>
Subject: Re: Error on push (unable to create temporary sha1 filename)
Date: Sat, 27 Feb 2010 14:16:49 +0100
Message-ID: <8dacd7b31002270516g63b84112g606da2a585764467@mail.gmail.com>
References: <8dacd7b31002231311q46c1c3b9o63c57fabe696f2ea@mail.gmail.com>
	 <be6fef0d1002231654r4fe08149qa937bbd9cc83d6a2@mail.gmail.com>
	 <8dacd7b31002270438ve59e43djd44e2866b697d3ab@mail.gmail.com>
	 <be6fef0d1002270501j124540c5g36a6a97142f4a7fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 14:17:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlMXX-0005ye-OS
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 14:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968309Ab0B0NQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 08:16:53 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43296 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968272Ab0B0NQu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 08:16:50 -0500
Received: by gyh20 with SMTP id 20so478932gyh.19
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 05:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=A8rNIeUDlnjx1yo+i/8Xor1987pSyFFwiqyxsroel6M=;
        b=E6QBdqbquL3Ejc5qW4EDCUus5iAnzGptzNg3flk0bWBUikUP6HdN9/up17UbdIg84m
         Y04y/o/UAfrlZ55hnMtv4sVzAagVvgyyuzvXMgQkGG5U3QztFGz28nxNzURC9eLLVp/i
         rgH/Ql0k1ZYpTqCa0c/yrhZ2g4pDqtSCXSKMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=grfkUesFQc8qi4vN/Ba5kwSrPyuP58DLhSHq47KyxGyL7p5gnPS0eAwq4U3BO8nwe1
         WXkYo+LNoBwFmAgXv5u1kRC8h+ones1QDfnBjjGk2LmbtBPabHAllyfnIDw1V3oTTdEm
         azuraaGbjbjY76/Y0iQSO3EMaKaFrFjSk/cp8=
Received: by 10.101.3.34 with SMTP id f34mr2605350ani.135.1267276609589; Sat, 
	27 Feb 2010 05:16:49 -0800 (PST)
In-Reply-To: <be6fef0d1002270501j124540c5g36a6a97142f4a7fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141205>

On Sat, Feb 27, 2010 at 2:01 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> running out of ideas. Could you post the output of "ls -lR .git/objects" ?

Yes:
$ ls -LR .git/objects
.git/objects:
info  pack

.git/objects/info:
packs

.git/objects/pack:
pack-34230f05b0351f54be4f3770abca7e483c5592c9.idx
pack-34230f05b0351f54be4f3770abca7e483c5592c9.pack
$

I'm using git version 1.6.3.3 btw. Thanks for the help so far!
